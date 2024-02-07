import json
import os
import torch
import torch.nn as nn
import torch.nn.functional as F
import numpy as np

class GRUNet(nn.Module):
    def __init__(self, input_dim, hidden_dim, output_dim, n_layers = 2, drop_prob=0.):
        super(GRUNet, self).__init__()
        self.hidden_dim = hidden_dim
        self.n_layers = n_layers
        self.device = torch.device("cuda") if torch.cuda.is_available() else torch.device("cpu")
        self.gru = nn.GRU(input_dim, hidden_dim, n_layers, batch_first=True, dropout=drop_prob)
        self.fc = nn.Linear(hidden_dim, output_dim)
        self.relu = nn.ReLU()
        dirname = os.path.dirname(__file__)
        self.feature_dict_path  = os.path.join(dirname, 'config.json')
        self.model_path = os.path.join(dirname, 'GRU.pth')
        self.signal_started = False # will evaluate to True if an input > 0 has been seen

    def calc_denormal_factor(self) -> float:
        """
            returns a value s.t after denormalization will evaluate to 0
        """
        with open(self.feature_dict_path, "r", encoding = 'utf-8') as f:
            feature_dict = json.load(f)
        return (-feature_dict["0"]["min"] / (feature_dict["0"]["max"] - feature_dict["0"]["min"])) 

    def check_signal_started(self, x, outs):
        if x.shape[0] != 1 or x.shape[1] != 1: ## batchsize has to be 1 here
            raise ValueError("Predicitions should only be made on a single sample")
        if x.item() > 0:
            self.signal_started = True
        if not self.signal_started:
            outs[0,0] = self.calc_denormal_factor()
        return outs


    def forward(self, x, h, prediction:bool = False):
        out, h = self.gru(x, h)
        out = self.fc(self.relu(out[:,-1]))
        if prediction:
            out = self.check_signal_started(x, out)
        return out, h
    
    def init_hidden(self, batch_size):
        #weight = next(self.parameters()).data
        #hidden = weight.new(self.n_layers, batch_size, self.hidden_dim).zero_().to(self.device)
        self.signal_started = False
        hidden = torch.zeros(self.n_layers, batch_size, self.hidden_dim)
        return hidden
    
    def save_model(self):
        torch.save(self.state_dict(), self.model_path)
    
    def load_model(self):
        self.load_state_dict(torch.load(self.model_path))
        self.eval()

    def forward_arbitrary_length(self, x, h):
        output = torch.zeros(x.shape[0])
        for i in range(x.shape[0]): ## batches
            h = self.init_hidden(1)
            tensor = x[i,1: int(x[i,0].item())]
            tensor = tensor[None, :]
            out, h = self(tensor,h)
            output[i] = out
        return output


    def normalize(self, tensor : "torch.tensor", is_output: "bool", i:int = 0) -> "torch.tensor":
        """
         param: tensor in R^nxm
         is output: bool
         i: int feature axis default 0 eg 1 feature incase i want to append features
        """
        normalization_dict = {i: {"min":tensor.min().item() , "max": tensor.max().item()}}
        path = self.feature_dict_path
        with open(self.feature_dict_path, "r") as f:
            feature_dict = json.load(f)
            if str(i) in feature_dict.keys():
                feature_dict[str(i)] = normalization_dict[i]
            else:
                feature_dict.update(normalization_dict)

        with open(path, "w", encoding = 'utf-8') as f:
            f.write(json.dumps(feature_dict, indent=4))    
        return (tensor - tensor.min()) / (tensor.max() - tensor.min())
    
    def denormalize(self, series: "np.array") -> "float":
            # + r"\feature_dict_output.json",
            with open(self.feature_dict_path, "r", encoding = 'utf-8') as f:
                feature_dict = json.load(f)
            return (series * (feature_dict["0"]["max"] - feature_dict["0"]["min"])) + feature_dict["0"]["min"]
    
    def get_sr(self):
        with open(self.feature_dict_path, "r") as f:
            return json.load(f)["sample_rate"]
        
    def save_sr(self, sr):
        try:
            with open(self.feature_dict_path, "r") as f:
                feature_dict = json.load(f)
        except FileNotFoundError:
            feature_dict = {}
        with open(self.feature_dict_path, "w") as f:
            feature_dict["sample_rate"] = sr
            f.write(json.dumps(feature_dict, indent = 4))
            

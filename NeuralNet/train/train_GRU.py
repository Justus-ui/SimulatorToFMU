import sys
import os
import math
#######
dirname = os.path.dirname(__file__)
sys.path.append(os.path.abspath(os.path.join(dirname, "../Model")))
import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
import logging as log
import time

import torch
from torch.utils.data import DataLoader
import torch.optim as optim

from myGRU import GRUNet as gru
from preprocesing import get_data

def validate(model, dataloader,batch_size, loss_fn):
    hidden = model.init_hidden(batch_size)
    valid_loss = 0
    for id_batch, (x_batch, y_batch) in enumerate(dataloader):
            x_batch = x_batch[:,:,None]
            out = model.forward_arbitrary_length(x_batch, hidden)
            loss = loss_fn(out , y_batch[:,-1])
            valid_loss += loss.item()
    return valid_loss

def test_model(model, dataloader, batch_size):
    loss_fn = lambda outputs,targets: np.mean(abs(outputs-targets)/abs(targets+outputs)/2)/len(outputs) ### Something nice in percent
    hidden = model.init_hidden(batch_size)
    test_loss = 0
    for id_batch, (x_batch, y_batch) in enumerate(dataloader):
            x_batch = x_batch[:,:,None]
            out = model.forward_arbitrary_length(x_batch, hidden)
            loss = loss_fn(out.detach().numpy() , y_batch[:,-1].detach().numpy())
            test_loss += loss.item()
    return test_loss

def train(model: "object", batch_size: "int", epochs: "int", Length_of_sample_s: "float", sr: "float", show_data:bool = False, use_filter:bool = False, minimum_delta: "float" = 0.0) -> "tuple(np.array(float), DataLoader)":
    loss_fn = torch.nn.MSELoss(reduction = "mean") # as it is closest to enrms
    lr = .1
    optimizer = optim.RAdam(model.parameters(), lr = lr)
    scheduler = optim.lr_scheduler.ReduceLROnPlateau(optimizer = optimizer, mode = 'min', patience = 5, verbose = True)
    loss_nd = np.zeros(epochs)
    train_data, validation_data, test_data = get_data(model, Length_of_sample_s = Length_of_sample_s, sr = sr, show_data = show_data, use_filter = False, minimum_delta = minimum_delta)
    dataloader = DataLoader(train_data, batch_size = batch_size, shuffle = True)
    validation_loader = DataLoader(validation_data, batch_size = batch_size, shuffle = True)
    train_loss = 0.
    model.train()
    for epoch in range(epochs):
        log.info(f"epoch {epoch}/{epochs}")
        time_start = time.time()
        hidden = model.init_hidden(batch_size)
        percentage = 1 # log when the epoch increase by this percentage
        for id_batch, (x_batch, y_batch) in enumerate(dataloader):
            hidden = hidden.data
            x_batch = x_batch[:,:,None]
            optimizer.zero_grad()
            out = model.forward_arbitrary_length(x_batch, hidden)
            loss = loss_fn(out.reshape(-1,1) , y_batch.reshape(-1,1))
            train_loss += loss.item()
            loss.backward()
            optimizer.step()
            if math.isclose(((id_batch / len(dataloader)) * 100), percentage, rel_tol=10e-2) or (((id_batch / len(dataloader)) * 100) > percentage):
                 log.info(f"{percentage}% done")
                 percentage += percentage
        model.save_model()
        log.info(f"Trainloss = {train_loss} with lr = {scheduler.optimizer.param_groups[0]['lr']}, time = {time.time() - time_start}")
        valid_loss = validate(model, validation_loader, batch_size, loss_fn)
        log.info(f"Validation loss {valid_loss}")
        scheduler.step(valid_loss)
        loss_nd[epoch] = train_loss
    return loss_nd, DataLoader(test_data, batch_size = batch_size, shuffle = True)
    
def visualize_model_prediction(model, file_name, sr):
    base_path = r'C:\Users\JP\Documents\TU Berlin\ProjekteMDT_clea\SimulatorToFMU\NeuralNet\Data\Test_Data'
    path = os.path.join(base_path, file_name)
    df = pd.read_csv(path)
    sample = df.loc[((df["Zeit[s]"] * 10000).astype(int) % (sr * 10000)) == 0]["Ue"].to_numpy()
    label = df.loc[((df["Zeit[s]"] * 10000).astype(int) % (sr * 10000)) == 0]["Generatorspannung[V]"].to_numpy()
    time = df.loc[((df["Zeit[s]"] * 10000).astype(int) % (sr * 10000)) == 0]["Zeit[s]"].to_numpy()
    prediction = np.zeros(len(sample))
    hidden = model.init_hidden(1)
    for i in range(1,len(sample)):
        outs, hidden = model(torch.tensor(sample[i], dtype = torch.float32).reshape(1,1,1),hidden, prediction = True)
        prediction[i] = outs.item()
    plt.plot(time, model.denormalize(prediction), label = "predicition")
    plt.plot(time,label, label = "label")
    plt.plot(time,sample, label = "sample")
    plt.legend()
    plt.show()

if __name__ == "__main__":
    ## Adjustable parameters
    show_data = True # will show some nice plots
    use_filter = False # will apply a 100 Hz lowpass to the measured signal
    minimum_delta = 0.1 # the minimal change in function value over a timeperiod 500 (tbd) ms to use as learning parameter, one has to be sure to chose delta, s.t the signal is continous to verify set show_data = True

    load_model = False
    sr = 0.004 #timeinterval[s] between samples
    if sr < 0.0001:
        raise ValueError("sr to small, not enoug samples")
    Length_of_sample_s = 0.1 # Window length in seconds. Number of samples will be -> Length_of_samples_s / sr

    batch_size = 128
    epochs = 100

    log.getLogger().setLevel(log.INFO)
    model = gru(1, 128,1)
    if load_model:
         model.load_model()
    model.save_sr(sr) ## This is needed in simulation to know when to calculate the next step
    loss_nd, test = train(model, batch_size = batch_size, epochs = epochs, Length_of_sample_s = Length_of_sample_s, sr = sr, show_data = show_data, use_filter = use_filter, minimum_delta=minimum_delta)
    model.save_model()
    test_loss = test_model(model, test, batch_size)
    log.info(f"Test_loss: {test_loss}")
    ###### Some Test #####
    visualize_model_prediction(model,'Measurement2.csv', sr)
    ###### Test_Measurements

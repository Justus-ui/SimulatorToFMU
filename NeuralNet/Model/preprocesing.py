""" This Script looks at ther given Measurementdata and returns the non linear-part of the measurement as we know apriori the outsputs when the prvoided Signal is 0 and when the 
    System is no longer oscialating disregarding noise
"""
import random
import os
import logging as log
import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
from scipy.signal import butter,lfilter, freqz
import torch
from torch.utils.data import TensorDataset, random_split

def butter_lowpass(cutoff, fs, order=5):
    return butter(order, cutoff, fs=fs, btype='low', analog=False)

def butter_lowpass_filter(data, cutoff = 100, fs = 1 / 0.0005, order=6):
    b, a = butter_lowpass(cutoff, fs, order=order)
    y = lfilter(b, a, data)
    return y

def filter_noise(signal):
    n = 300  # the larger n is, the smoother curve will be chosen n real large because in the underlying use case the resemblences with the original signal does not matter that much. Only the change in time
    b = [1.0 / n] * n
    a = 1
    return lfilter(b, a, signal)

def get_samples(sample_length,sample: "np.array") -> "(int, np.array[np.array])":
    print(sample.size, sample_length)
    num_samples = int(sample.size // sample_length)
    if num_samples < 1:
        raise ValueError("Sample length to small")
    samples = np.zeros((num_samples, 10000))
    samples[:] = np.nan
    for i in range((num_samples)):
        samples[i,0] = int((i + 1) * sample_length)
        samples[i, 1 : int((i + 1) * sample_length) + 1] =  sample[0 : int((i + 1) * sample_length)]#sample[int(i* sample_length) : int((i + 1) * sample_length)]
    return num_samples, samples

def get_labels(sample_length,sample: "np.array") -> "(int, np.array[np.array])":
    num_samples = int(sample.size // sample_length)
    #log.info(sample)
    if num_samples < 1:
        raise ValueError("Sample length to small")
    samples = np.zeros((num_samples, 1))
    samples[:] = np.nan
    for i in range((num_samples)):
        samples[i] =  sample[int((i + 1) * sample_length) - 1]
    return num_samples, samples

def load_data(show_data = False, minmim_delta = 0.0, window_length = 0.5) -> "Generator of dataframes":
    """ 
        This function returns a dataframe which has a sequence of zeros for atmost 100ms.
        Also the dataframe will only contain the part of the signal for which the signal is still oscialation eg some delta
    """
    path = r'C:\Users\JP\Documents\TU Berlin\ProjekteMDT_clea\SimulatorToFMU\NeuralNet\Data\Train_Data'
    data = os.listdir(path)
    for i,files in enumerate(data):
        df = pd.read_csv(os.path.join(path, files))
        df["is_oscilating"] = 0
        ## This is a really hard filter since we do not care about the value only about the gradient
        df["filtered_Gen"] = filter_noise(df["Generatorspannung[V]"])
        # Window length 500 ms
        window_length = 4
        iterator = int((max(df["Zeit[s]"]) / window_length)) if (max(df["Zeit[s]"])) > window_length else 1
        for i in range(iterator):
            indexes = (df["Zeit[s]"] > window_length * i) & (df["Zeit[s]"] < window_length * (i + 1))
            max_window = (df.loc[indexes]["filtered_Gen"]).max()
            min_window = (df.loc[indexes]["filtered_Gen"]).min()
            if abs(max_window - min_window) > minmim_delta:
                df.loc[indexes, "is_oscilating"] = 1
        df["filtered_signal"] = butter_lowpass_filter(df["Generatorspannung[V]"].to_numpy())

        if show_data:
            plt.plot(df["Zeit[s]"], df["Generatorspannung[V]"], label = "signal")
            plt.plot(df["Zeit[s]"].loc[df["is_oscilating"] == 1], df["Generatorspannung[V]"].loc[df["is_oscilating"] == 1], label = "filtered", color = "orange")
            plt.title("Part of the signal with sufficient change")
            plt.legend()
            plt.show()
            plt.plot(df["Zeit[s]"], df["Generatorspannung[V]"], label = "signal")
            plt.plot(df["Zeit[s]"], df["filtered_signal"], label = "filtered_signal")
            plt.title("Filtered Signal")
            plt.legend()
            plt.show()

        yield df.loc[df["is_oscilating"] == 1]

def get_data(model : "object", Length_of_sample_s, sr:"int" = 0.0001, show_data = False, use_filter = True, minimum_delta = 0.0) -> "TensorDataset":
    """
        returns a TensorDataset already split. 
    """
    # this operator describes the sampling period eg 1 / fsr
    sample_length = Length_of_sample_s / sr
    total_num_samples = 0
    X = torch.zeros((15100, 10000))#int(sample_length)))
    Y = torch.zeros((15100, 1))#int(sample_length))) # Dont use more than 500 samples
    column_name = "filtered_signal" if use_filter else "Generatorspannung[V]"
    for df in load_data(show_data, minimum_delta):
        num_samples, samples = get_samples(sample_length,df.loc[((df["Zeit[s]"] * 10000).astype(int) % (sr * 10000)) == 0]["Ue"].to_numpy())
        X[total_num_samples: total_num_samples + num_samples] = torch.tensor(samples)
        _, labels = get_labels(sample_length, df.loc[((df["Zeit[s]"] * 10000).astype(int) % (sr * 10000)) == 0][column_name].to_numpy())#"Generatorspannung[V]"
        Y[total_num_samples: total_num_samples + num_samples] = torch.Tensor(labels)
        total_num_samples += num_samples
    log.info(f"Number of available samples: {total_num_samples}")
    X = X[0:total_num_samples]
    Y = model.normalize(Y[0:total_num_samples], is_output = True)
    dataset = TensorDataset(X, Y)
    proportions = [.8, .10, .10]
    lengths = [int(p * len(dataset)) for p in proportions]
    lengths[-1] = len(dataset) - sum(lengths[:-1])
    if 0 in lengths:
        raise ValueError("choose appropiate Length_of_sample_s or sr s.t enough samples are provided")
    return random_split(dataset, lengths)

if __name__ == "__main__":
    for df in load_data():
        plt.plot(df["Zeit[s]"],df["Generatorspannung[V]"] ,label = "Ausgangsspannung")
        plt.plot(df["Zeit[s]"],df["Ue"],label = "Eingangsspannung")
        plt.title("Trainingsdaten")
        plt.xlabel('Zeit / s')
        plt.ylabel('Spannung / V')
        plt.legend()
        plt.show()


import pandas as pd
import os
import scipy
import numpy as np
import matplotlib.pyplot as plt


def resample_signal(signal):
    sample_preiod_meas = 0.0005
    upsampled_signal = scipy.signal.resample(signal, int(5 / sample_preiod_meas))
    cutoff_frequency = 0.5  # Adjust cutoff frequency as needed
    b, a = scipy.signal.butter(4, cutoff_frequency, 'low')
    filtered_signal = scipy.signal.filtfilt(b, a, upsampled_signal)
    filtered_signal[filtered_signal >= 5] = 4.999
    return filtered_signal


df = pd.read_csv(r"C:\Users\JP\Documents\TU Berlin\ProjekteMDT_clea\SimulatorToFMU\NeuralNet\Evaluate\Data\Evaluation_1.csv")
out_frame = pd.read_csv(r"C:\Users\JP\Documents\TU Berlin\ProjekteMDT_clea\SimulatorToFMU\NeuralNet\Evaluate\Measurements\results-366-Test_Measurement_1.csv")
test_frame = pd.read_csv(r"C:\Users\JP\Documents\TU Berlin\ProjekteMDT_clea\SimulatorToFMU\NeuralNet\Evaluate\Data\Test_Measurement_1.csv")
filtered_signal = resample_signal(test_frame["voltage"])
out_frame["Ue"] = np.around(filtered_signal, decimals = 5)
plt.plot(out_frame["Zeit[s]"], filtered_signal, label = "Eingangssignal")
plt.plot(out_frame["Zeit[s]"], out_frame["Generatorspannung[V]"], label = "Systemantwort gemessen")
plt.plot(df["time"], df["Output"], label = "Systemantwort vorhergesagt")
sample_preiod_meas = 0.0005
enrms = np.sum((resample_signal(df["Output"]) - out_frame["Generatorspannung[V]"]) ** 2) / (5 / sample_preiod_meas)
plt.title(f"Auswertung des Identifikators ernms = {int(enrms * 1000) / 1000}")
plt.xlabel("Zeit in s")
plt.ylabel("Spannung in V")
plt.legend()
plt.show()
out_frame.to_csv(os.path.join(r"C:\Users\JP\Documents\TU Berlin\ProjekteMDT_clea\SimulatorToFMU\NeuralNet\Data\Train_Data", "Measurement_366.csv"))
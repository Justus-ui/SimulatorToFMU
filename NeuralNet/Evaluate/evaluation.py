"""
This model reads the output of the simulation (in the controlled case) and creates
a measurement to upload to the Website to check if the system response is correct
"""


import os
import DyMat
import matplotlib.pyplot as plt
import numpy as np
import pandas as pd
from scipy import signal

measurement_id = 18
simulation_time = 5
path = r"C:\Users\JP\AppData\Local\Temp\OpenModelica\OMEdit\Test_control" #path where corresponding .mat files are saved
mat_file = [s for s in os.listdir(path) if s.endswith('_res.mat')]
d = DyMat.DyMatFile(os.path.join(path, mat_file[0].replace('.mat', '')))
pi_controller = d.data('limiter.y')
system_output = d.data('abc_me_FMU1.y')
time = np.linspace(0,simulation_time,system_output.size)
plt.plot(time, pi_controller, label = "Controller output")
plt.plot(time, system_output, label = "system output")
plt.xlabel("Zeit in s")
plt.ylabel("Spannung in V")
plt.title("Vorhergesehene Systemantwort")
plt.legend()
plt.show()
data = { "time": time,
        "Input":pi_controller,
        "Output":system_output
}
df = pd.DataFrame(data)
path_to_script = os.path.dirname(__file__)
df.to_csv(os.path.join(os.path.join(path_to_script, "Data"), f"Evaluation_{measurement_id}.csv"), index = False)


### length of simulation = 5 and steps = 0.01
upsampled_signal = signal.resample(df["Input"], int(simulation_time / 0.004))
cutoff_frequency = 0.5  # Adjust cutoff frequency as needed
b, a = signal.butter(4, cutoff_frequency, 'low')
filtered_signal = signal.filtfilt(b, a, upsampled_signal)
filtered_signal[filtered_signal >= 4.99999] = 4.99999
filtered_signal[filtered_signal <= 1e-5] = 0.00001
plt.title("resampled controller ouput")
plt.plot(filtered_signal)
plt.xlabel("Zeit in s")
plt.ylabel("Spannung in V")
plt.legend()
plt.show()

data = {"time": np.around(np.arange(0,simulation_time,0.004), decimals = 5),
        "voltage": np.around(filtered_signal, decimals = 5)}
test_frame = pd.DataFrame(data)
test_frame.to_csv(os.path.join(os.path.join(path_to_script, "Data"), f"Test_Measurement_{measurement_id}.csv"), index = False)
print("Measurement_file_name:")
path = input()
print(os.path.join(os.path.join(path_to_script, "Measurements"), path))
out_frame = pd.read_csv(os.path.join(os.path.join(path_to_script, "Measurements"), path))
plt.plot(out_frame["Zeit[s]"], out_frame["Generatorspannung[V]"], label = "Gemessene System Antwort")
plt.plot(time, system_output, label = "Vorhergesehe Systemantwort")
plt.plot(np.arange(0,5,0.004), filtered_signal, label = "Eingangssignal")

sample_preiod_meas = 0.0005
upsampled_signal = signal.resample(system_output, int(simulation_time / sample_preiod_meas))
print(upsampled_signal.shape)
cutoff_frequency = 0.5  # Adjust cutoff frequency as needed
b, a = signal.butter(4, cutoff_frequency, 'low')
filtered_signal = signal.filtfilt(b, a, upsampled_signal)

#plt.plot(out_frame["Zeit[s]"], filtered_signal)
enrms = np.mean(((upsampled_signal - out_frame["Generatorspannung[V]"]) / (max(out_frame["Generatorspannung[V]"]) - min(out_frame["Generatorspannung[V]"]))) ** 2)
plt.legend()
plt.title(f"Auswertung des Identifikators ernms = {int(enrms * 10000) / 10000}")
plt.xlabel("Zeit in s")
plt.ylabel("Spannung in V")
plt.savefig(os.path.join(os.path.join(path_to_script, "Evaluation_Measurements"), f'Result_measuremnt_{measurement_id}.png'))
plt.show()

sample_preiod_meas = 0.0005
upsampled_signal = signal.resample(df["Input"], int(simulation_time / sample_preiod_meas))
cutoff_frequency = 0.5  # Adjust cutoff frequency as needed
b, a = signal.butter(4, cutoff_frequency, 'low')
filtered_signal = signal.filtfilt(b, a, upsampled_signal)
filtered_signal[filtered_signal >= 4.99999] = 4.99999
filtered_signal[filtered_signal <= 1e-5] = 0.00001
out_frame["Ue"] = filtered_signal
df.to_csv(os.path.abspath(os.path.join(os.path.join(path_to_script, "..\Data\Train_Data"), f"Measurement_{measurement_id}.csv")), index = False)
df.to_csv(os.path.abspath(os.path.join(os.path.join(path_to_script, "Evaluation_Measurements"), f"Measurement_{measurement_id}.csv")), index = False)

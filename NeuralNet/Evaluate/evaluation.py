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

dirname = 
path = r"C:\Users\JP\AppData\Local\Temp\OpenModelica\OMEdit\Test_control" #path where corresponding .mat files are saved
mat_file = [s for s in os.listdir(path) if s.endswith('_res.mat')]
d = DyMat.DyMatFile(os.path.join(path, mat_file[0].replace('.mat', '')))
pi_controller = d.data('limiter.y')
system_output = d.data('abc_me_FMU1.y')
time = np.linspace(0,5,system_output.size)
plt.plot(time, pi_controller)
plt.plot(time, system_output)
plt.show()
data = { "time": time, 
        "Input":pi_controller,
        "Output":system_output
}
df = pd.DataFrame(data)
df.to_csv(r"C:\Users\JP\Documents\TU Berlin\ProjekteMDT_clea\NeuralNet\Evaluation.csv")


### length of simulation = 5 and steps = 0.01
upsampling_factor = 250 / 100
upsampled_signal = signal.resample(df["Input"], int(5 / 0.004))
cutoff_frequency = 0.5  # Adjust cutoff frequency as needed
b, a = signal.butter(4, cutoff_frequency, 'low')
filtered_signal = signal.filtfilt(b, a, upsampled_signal)
filtered_signal[filtered_signal >= 5] = 4.999
plt.plot(filtered_signal)
plt.show()

data = {"time": np.around(np.arange(0,5,0.004), decimals = 5),
        "voltage": np.around(filtered_signal, decimals = 5)}
filtered_signal.size
test_frame = pd.DataFrame(data)
test_frame.to_csv(r"C:\Users\JP\Documents\TU Berlin\ProjekteMDT_clea\SimulatorToFMU\NeuralNet\Evaluate\Data\Test_Measurement.csv")
input("Measurement_file_name:")
out_frame = pd.read_csv(r"C:\Users\JP\Documents\TU Berlin\ProjekteMDT_clea\SimulatorToFMU\NeuralNet\Evaluate\Measurements\results-365-Test_Measurement.csv")
plt.plot(out_frame["Zeit[s]"], out_frame["Generatorspannung[V]"])
plt.plot(time, system_output)
plt.plot(np.arange(0,5,0.004), filtered_signal)
plt.show()
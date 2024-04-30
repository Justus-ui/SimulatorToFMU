import numpy as np
import pandas as pd
import sys
from scipy.signal import sawtooth
import matplotlib.pyplot as plt
import os

Amplitude = 2. # Volts
frequency = 1# HZ
timestep = 0.0005 # Scheibenlaeufer expects: 250 Hz
percent= 25.0 # pwm   
start_time = 0
stop_time = 10
time_frame = np.arange(start_time,stop_time,timestep)
iteration = 0
if start_time:
    time_frame_no_signal = np.arange(0, start_time, timestep)
sin_signal = lambda A,f,t: A * np.sin(2* np.pi * f * t) + A
signal = sin_signal(Amplitude, frequency, time_frame)

#data = pd.DataFrame([time_frame, signal], columns = ["time","voltage"])
data = {'time': np.around(time_frame, decimals=5, out=None),
    "voltage": np.abs(np.around(signal, decimals=3, out=None))}
plt.plot(signal)
plt.show()
df = pd.DataFrame(data)
df.to_csv(os.path.join(os.path.dirname(__file__),f"sin_{iteration}_sampled.csv"), index = False)
 
data = {'time': np.around(time_frame, decimals=5, out=None),
        "voltage": np.abs(np.around(Amplitude * sawtooth(2 * np.pi * frequency * time_frame), decimals=5, out=None))}
plt.plot(data["time"], data["voltage"])
plt.show()
df = pd.DataFrame(data)
df.to_csv(f"sawtooth_{iteration}_sampled.csv", index = False)
Timeperiod = 1/frequency
pwm= time_frame%Timeperiod * 100<(Timeperiod*percent)
data = {'time': np.around(time_frame, decimals=5, out=None),
        "voltage": np.abs(np.around(Amplitude * pwm, decimals=5, out=None))}
plt.plot(data["time"], data["voltage"])
plt.show()
df = pd.DataFrame(data)
df.to_csv(f"pwm_{iteration}_sampled.csv", index = False)
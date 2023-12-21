import pandas as pd
import os

names = ["sawtooth","sin","pwm"]

for name in names:
    for i in range(2):
        id = input(f"Provide Measurement id for {name}_{i}")
        path = [os.path.join(r'C:\Users\JP\Documents\TU Berlin\IVSimulation', f"results-{id}-{name}_{i}.csv"), os.path.join(r'C:\Users\JP\Documents\TU Berlin\IVSimulation', f"{name}_{i}_sampled.csv")]
        df = pd.read_csv(path[0])
        df["Ue"] = pd.read_csv(path[1])["voltage"]
        df.to_csv(os.path.join(r'C:\Users\JP\Documents\TU Berlin\ProjekteMDT_clea\Measurement_data',f'Measurement_{id}.csv'))
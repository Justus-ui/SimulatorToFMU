import os
import json
import sys

def setup():
    dictionary = {}
    dirname = os.path.dirname(__file__)
    filename = os.path.join(dirname, 'simulatortofmu/parser/setup.json')
    modelica = input(r"Please provide the path to your openmodelica installation (e.g: C:\Users\Yournname\AppData\Roaming\.openmodelica\libraries):")
    dictionary["modelica_path"] = modelica
    with open(filename, "w") as f:
        f.write(json.dumps(dictionary, indent=4))
    if "3.7" not in sys.version:
        raise SystemError("This Script explicitly requires Python Version 3.7.X")
    pip = os.system("python -m pip install -r requirements.txt")
    print(pip)
    if pip:
        pip3 = os.system("python -m pip install -r requirements.txt")
    if pip and pip3:
        raise SystemError("Did not find pip")
    

if __name__ == '__main__':
    setup()
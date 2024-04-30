import os
import json
import sys
import warnings
import subprocess

def setup():
    dictionary = {}
    dirname = os.path.dirname(__file__)
    filename = os.path.join(dirname, 'simulatortofmu/parser/setup.json')
    change = True
    if os.path.isfile(filename):
        change = True if input("There already is a path specified, want to change the path [y/n]") == "y" else False
    if change:
        modelica = input(r"Please provide the path to your openmodelica libaries (e.g: C:\Users\{Yournname}\AppData\Roaming\.openmodelica\libraries):")
        dictionary["modelica_path"] = modelica
        with open(filename, "w") as f:
            f.write(json.dumps(dictionary, indent=4))

    req_path = os.path.join(dirname, "requirements.txt")
    if "3.7" not in sys.version:
        warnings.warn("The Applicatation is only verified to work for Python 3.7.X")
    pip = subprocess.run([sys.executable, '-m', 'pip', 'install', '-r' ,f'{req_path}'])
    print(pip)
    pip3 = 0
    if pip:
        subprocess.run([sys.executable, '-m', 'pip', 'install', '-r' ,f'{req_path}'])
        #pip3 = os.system(f""" python -m pip install -r "{req_path}" """)
    if pip and pip3:
        raise SystemError("Did not find pip")
    model_path = os.path.join(dirname, r"NeuralNet\Model")
    os.system(f""" setx PYTHONPATH "%PYTHONPATH%;{model_path}" """)
    if input("Want to use scripts created by the user in the wrapper? [y/n]") == "y":
        path = input("Provid the path of external scripts which you would like to import into the openmodelica wrapper, the paths will be added to your python path:")
        os.system(f""" setx PYTHONPATH "%PYTHONPATH%;{path}" """)

if __name__ == '__main__':
    setup()

import os
import json
import sys
import warnings


def setup():
    dictionary = {}
    dirname = os.path.dirname(__file__)
    filename = os.path.join(dirname, 'simulatortofmu/parser/setup.json')
    modelica = input(r"Please provide the path to your openmodelica libaries (e.g: C:\Users\Yournname\AppData\Roaming\.openmodelica\libraries):")
    dictionary["modelica_path"] = modelica
    req_path = os.path.join(dirname, "requirements.txt")
    with open(filename, "w") as f:
        f.write(json.dumps(dictionary, indent=4))
    if "3.7" not in sys.version:
        warnings.warn("The Applicatation is only verified to work for Python 3.7.X")
    pip = os.system(f""" python -m pip install -r "{req_path}" """)
    print(pip)
    if pip:
        pip3 = os.system(f""" python -m pip install -r "{req_path}" """)
    if pip and pip3:
        raise SystemError("Did not find pip")
    

if __name__ == '__main__':
    setup()

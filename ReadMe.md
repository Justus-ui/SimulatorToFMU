Note this Repo is exclusivly meant to be run on Windows and Openmodelica V 1.21.0
1. Clone this Repo
2. Run Setup.py provide the Path to you OpenModelica Installation
3. create a .xml and {model_name}_wrapper.py as per User_Guide.pdf
4. Create you FMU as described in USer_Guide.pdf
    An Example Command looks like: 
    c:/Users/JP/AppData/Local/Programs/Python/Python37-64/python.exe  SimulatorToFMU\simulatortofmu\parser\SimulatorToFMU.py -i "C:\Users\JP\Documents\TU Berlin\ProjekteMDT_clea\configuration.xml" -s "C:\Users\JP\Documents\TU Berlin\ProjekteMDT_Clea\abc_wrapper.py" -hm true -pv 37
5. You will see in the folder fmus/openmodelica/Windows/{model_name} your FMU, the script in {model_name}.scripts may bys altered after import


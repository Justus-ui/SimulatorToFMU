# Dummy Python-driven simulator
import logging as log 
try:
    import os
    import numpy as np 
    import torch
    from myGRU import GRUNet as gru

except Exception as e:
    log.error(e)

class Simulator():
    """
    Dummy simulator Python-driven simulator
    which increments in its doTimeSteo method the input values by 1.
    This class is for illustration purposes only.
    """
    def __init__(self, configuration_file, time, input_names,
            input_values, output_names, write_results):
        self.configuration_file = configuration_file
        self.input_values = input_values

        self.model, self.sample_period = self.load_model()
        self.sample_period = 0.01
        log.info("Sampled periode was set manually please change (!)")
        self.hidden = self.model.init_hidden(1)
    
    def load_model(self):
        model = gru(1,128,1)
        model.load_model()
        return model, model.get_sr()


    def doTimeStep(self, input_value):
        """
        This function returns the predicted new output
        """
        sign = 1
        if input_value < 0:
            input_value = abs(input_value)
            sign = -1
        tensor = torch.tensor(input_value, dtype=torch.float32).reshape(1,1,1)
        output, self.hidden = self.model(tensor, self.hidden, prediction=True)
        return sign * self.model.denormalize(output.item())

# Main Python function to be modified to interface with a simulator which has memory.
def exchange(configuration_file, time, input_names,
            input_values, output_names, write_results,
            memory):
    """
    Return  a list of output values from the Python-based Simulator.
    The order of the output values must match the order of the output names.

    :param configuration_file (String): Path to the Simulator model or configuration file
    :param time (Float): Simulation time
    :param input_names (Strings): Input names
    :param input_values (Floats): Input values (same length as input_names)
    :param output_names (Strings): Output names
    :param write_results (Integers): Store results to file (1 to store, 0 else)
    :param memory: Variable that stores the memory of a Python object

    """
    if memory == None:
        # Initialize the Simulator object
        s = Simulator(configuration_file, time, input_names,
                        input_values, output_names, write_results)
        memory = {'memory':s, 'tLast':time}
        memory["output_value"] = s.doTimeStep(input_values)
        memory['s'] = s
    else:
        if(abs(time - memory['tLast']) >= memory['s'].sample_period):
            memory["output_value"] = memory['s'].doTimeStep(input_values)
            memory['tLast'] = time
    
    if time < 0.005:
        memory["output_value"] = 0 ## Einschwingzeit
    return [memory["output_value"], memory]

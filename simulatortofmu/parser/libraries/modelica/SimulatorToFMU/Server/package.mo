within SimulatorToFMU;
package Server "Package to call server functions"
  extends Modelica.Icons.VariantsPackage;

annotation (preferredView="info", Documentation(info="<html>
<p>
This package contains blocks and functions that embed Python 2.7 in Modelica.
Data can be sent to Python functions and received from Python functions.
This allows for example data analysis in Python as part of a Modelica model,
or data.simulator as part of a hardware-in-the-loop simulation in which
Python is used to communicate with hardware.
</p>
<p>
See
<a href=\"modelica://SimulatorToFMU.Python27.UsersGuide\">
SimulatorToFMU.Python27.UsersGuide</a>
for instruction.
</p>
</html>"));
end Server;

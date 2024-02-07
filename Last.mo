block Last
  parameter Real Ra = 8.25;
  parameter Real L=0.375e-3;
  parameter Real RL = 100;
  Modelica.Blocks.Interfaces.RealOutput Ur annotation(
    Placement(visible = true, transformation(origin = {110, 72}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, 74}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Gain gain5(k = RL) annotation(
    Placement(visible = true, transformation(origin = {62, 72}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Continuous.Integrator integrator(k = 1) annotation(
    Placement(visible = true, transformation(origin = {10, 72}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Add add(k1 = 1, k2 = -1) annotation(
    Placement(visible = true, transformation(origin = {-58, 72}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput Ug annotation(
    Placement(visible = true, transformation(origin = {-100, 78}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-120, 0}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Modelica.Blocks.Math.Gain gain(k = (RL + Ra)) annotation(
    Placement(visible = true, transformation(origin = {-12, 32}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Gain gain1(k = 1/L) annotation(
    Placement(visible = true, transformation(origin = {-26, 72}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(gain5.y, Ur) annotation(
    Line(points = {{73, 72}, {110, 72}}, color = {0, 0, 127}));
  connect(Ug, add.u1) annotation(
    Line(points = {{-100, 78}, {-70, 78}}, color = {0, 0, 127}));
  connect(integrator.y, gain.u) annotation(
    Line(points = {{21, 72}, {24, 72}, {24, 32}, {0, 32}}, color = {0, 0, 127}));
  connect(gain.y, add.u2) annotation(
    Line(points = {{-22, 32}, {-72, 32}, {-72, 66}, {-70, 66}}, color = {0, 0, 127}));
  connect(integrator.y, gain5.u) annotation(
    Line(points = {{21, 72}, {50, 72}}, color = {0, 0, 127}));
  connect(add.y, gain1.u) annotation(
    Line(points = {{-46, 72}, {-38, 72}}, color = {0, 0, 127}));
  connect(gain1.y, integrator.u) annotation(
    Line(points = {{-14, 72}, {-2, 72}}, color = {0, 0, 127}));
  annotation(
    uses(Modelica(version = "4.0.0")),
    Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}})));
end Last;

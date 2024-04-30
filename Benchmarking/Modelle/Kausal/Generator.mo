block Generator
  parameter Real Ra = 8.25;
  parameter Real c = 51.5e-3;
  parameter Real L=0.375e-3;
  parameter Real cu=0.3248e-3;
  parameter Real J=47.5e-6;
  parameter Real RL = 10;
  Modelica.Blocks.Math.Gain gain(k = 1/J) annotation(
    Placement(visible = true, transformation(origin = {-38, 78}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Add3 add3(k1 = 1, k2 = -1, k3 = -1) annotation(
    Placement(visible = true, transformation(origin = {48, 4}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Continuous.Integrator integrator1(k = 1) annotation(
    Placement(visible = true, transformation(origin = {116, 4}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Gain gain4(k = cu/J) annotation(
    Placement(visible = true, transformation(origin = {54, -36}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput y annotation(
    Placement(visible = true, transformation(origin = {154, 76}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, 74}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Gain gain5(k = RL) annotation(
    Placement(visible = true, transformation(origin = {64, 76}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Gain gain1(k = c/J) annotation(
    Placement(visible = true, transformation(origin = {0, 4}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Gain gain3(k = c/L) annotation(
    Placement(visible = true, transformation(origin = {-44, -76}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  Modelica.Blocks.Continuous.Integrator integrator(k = 1) annotation(
    Placement(visible = true, transformation(origin = {-42, 4}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Gain gain2(k = (RL + Ra)/L) annotation(
    Placement(visible = true, transformation(origin = {-44, -42}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Add add(k1 = 1, k2 = -1) annotation(
    Placement(visible = true, transformation(origin = {-76, 4}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput w annotation(
    Placement(visible = true, transformation(origin = {152, 4}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput wp annotation(
    Placement(visible = true, transformation(origin = {154, -70}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, -80}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput M annotation(
    Placement(visible = true, transformation(origin = {-100, 78}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-120, 0}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
equation
  connect(integrator1.u, add3.y) annotation(
    Line(points = {{104, 4}, {60, 4}}, color = {0, 0, 127}));
  connect(integrator1.y, gain4.u) annotation(
    Line(points = {{128, 4}, {134, 4}, {134, -36}, {66, -36}}, color = {0, 0, 127}));
  connect(gain5.y, y) annotation(
    Line(points = {{76, 76}, {154, 76}}, color = {0, 0, 127}));
  connect(add3.u3, gain4.y) annotation(
    Line(points = {{36, -4}, {36, -36}, {43, -36}}, color = {0, 0, 127}));
  connect(add3.u2, gain1.y) annotation(
    Line(points = {{36, 4}, {11, 4}}, color = {0, 0, 127}));
  connect(gain3.u, integrator1.y) annotation(
    Line(points = {{-32, -76}, {134, -76}, {134, 4}, {128, 4}}, color = {0, 0, 127}));
  connect(integrator.y, gain1.u) annotation(
    Line(points = {{-31, 4}, {-12, 4}}, color = {0, 0, 127}));
  connect(add.y, integrator.u) annotation(
    Line(points = {{-64, 4}, {-54, 4}}, color = {0, 0, 127}));
  connect(gain2.y, add.u2) annotation(
    Line(points = {{-55, -42}, {-116, -42}, {-116, -2}, {-88, -2}}, color = {0, 0, 127}));
  connect(gain3.y, add.u1) annotation(
    Line(points = {{-55, -76}, {-134, -76}, {-134, 10}, {-88, 10}}, color = {0, 0, 127}));
  connect(integrator1.y, w) annotation(
    Line(points = {{128, 4}, {152, 4}}, color = {0, 0, 127}));
  connect(add3.y, wp) annotation(
    Line(points = {{59, 4}, {86, 4}, {86, -70}, {154, -70}}, color = {0, 0, 127}));
  connect(gain2.u, gain5.u) annotation(
    Line(points = {{-32, -42}, {26, -42}, {26, 76}, {52, 76}}, color = {0, 0, 127}));
  connect(add3.u1, gain.y) annotation(
    Line(points = {{36, 12}, {36, 45}, {18, 45}, {18, 78}, {-27, 78}}, color = {0, 0, 127}));
  connect(integrator.y, gain2.u) annotation(
    Line(points = {{-30, 4}, {-22, 4}, {-22, -42}, {-32, -42}}, color = {0, 0, 127}));
  connect(M, gain.u) annotation(
    Line(points = {{-100, 78}, {-50, 78}}, color = {0, 0, 127}));
  annotation(
    uses(Modelica(version = "4.0.0")),
    Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}})));
end Generator;

block Motor
  parameter Real Ra = 8.25;
  parameter Real c = 51.5e-3;
  parameter Real L=0.375e-3;
  parameter Real cu=0.3248e-3;
  parameter Real J=47.5e-6;
  Modelica.Blocks.Interfaces.RealInput u annotation(
    Placement(visible = true, transformation(origin = {-100, 62}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-120, 62}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput w annotation(
    Placement(visible = true, transformation(origin = {-100, 4}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-118, 0}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput wp annotation(
    Placement(visible = true, transformation(origin = {-100, -60}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-120, -58}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Modelica.Blocks.Math.Gain gain(k = 1/L)  annotation(
    Placement(visible = true, transformation(origin = {-52, 62}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Gain gain1(k = c/L)  annotation(
    Placement(visible = true, transformation(origin = {-54, 4}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Gain gain2(k = J)  annotation(
    Placement(visible = true, transformation(origin = {-50, -60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Add3 add3(k2 = -1, k3 = -1)  annotation(
    Placement(visible = true, transformation(origin = {-10, 54}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Gain gain3(k = cu)  annotation(
    Placement(visible = true, transformation(origin = {-22, -16}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Gain gain4(k = c)  annotation(
    Placement(visible = true, transformation(origin = {38, 54}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Gain gain5(k = Ra/L)  annotation(
    Placement(visible = true, transformation(origin = {-4, 26}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Add3 add31(k2 = -1, k3 = -1)  annotation(
    Placement(visible = true, transformation(origin = {74, 54}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput y annotation(
    Placement(visible = true, transformation(origin = {110, 54}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, 2}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(u, gain.u) annotation(
    Line(points = {{-100, 62}, {-64, 62}}, color = {0, 0, 127}));
  connect(gain.y, add3.u1) annotation(
    Line(points = {{-40, 62}, {-22, 62}}, color = {0, 0, 127}));
  connect(w, gain1.u) annotation(
    Line(points = {{-100, 4}, {-66, 4}}, color = {0, 0, 127}));
  connect(gain1.y, add3.u2) annotation(
    Line(points = {{-42, 4}, {-36, 4}, {-36, 54}, {-22, 54}}, color = {0, 0, 127}));
  connect(wp, gain2.u) annotation(
    Line(points = {{-100, -60}, {-62, -60}}, color = {0, 0, 127}));
  connect(gain1.u, gain3.u) annotation(
    Line(points = {{-66, 4}, {-72, 4}, {-72, -16}, {-34, -16}}, color = {0, 0, 127}));
  connect(gain5.y, add3.u3) annotation(
    Line(points = {{-14, 26}, {-30, 26}, {-30, 46}, {-22, 46}}, color = {0, 0, 127}));
  connect(add3.y, gain5.u) annotation(
    Line(points = {{2, 54}, {8, 54}, {8, 26}}, color = {0, 0, 127}));
  connect(add3.y, gain4.u) annotation(
    Line(points = {{2, 54}, {26, 54}}, color = {0, 0, 127}));
  connect(gain4.y, add31.u1) annotation(
    Line(points = {{50, 54}, {50, 62}, {62, 62}}, color = {0, 0, 127}));
  connect(gain3.y, add31.u2) annotation(
    Line(points = {{-10, -16}, {56, -16}, {56, 54}, {62, 54}}, color = {0, 0, 127}));
  connect(gain2.y, add31.u3) annotation(
    Line(points = {{-38, -60}, {62, -60}, {62, 46}}, color = {0, 0, 127}));
  connect(add31.y, y) annotation(
    Line(points = {{86, 54}, {110, 54}}, color = {0, 0, 127}));
  annotation(
    uses(Modelica(version = "4.0.0")));
end Motor;

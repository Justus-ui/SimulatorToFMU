model Test_control
  abc_me_FMU abc_me_FMU1 annotation(
    Placement(visible = true, transformation(origin = {-46, 32}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Continuous.PI pi(T = 0.1, k = 2)  annotation(
    Placement(visible = true, transformation(origin = {70, 38}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Last last annotation(
    Placement(visible = true, transformation(origin = {2, 38}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Feedback feedback annotation(
    Placement(visible = true, transformation(origin = {32, 38}, extent = {{10, 10}, {-10, -10}}, rotation = 90)));
  Modelica.Blocks.Sources.Constant const(k = 1)  annotation(
    Placement(visible = true, transformation(origin = {0, 76}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Nonlinear.Limiter limiter(uMax = 5, uMin = 0)  annotation(
    Placement(visible = true, transformation(origin = {4, -8}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
equation
  connect(abc_me_FMU1.y, last.u) annotation(
    Line(points = {{-35, 39}, {-16, 39}, {-16, 38}, {-10, 38}}, color = {0, 0, 127}));
  connect(last.y, feedback.u2) annotation(
    Line(points = {{14, 38}, {24, 38}}, color = {0, 0, 127}));
  connect(feedback.u1, const.y) annotation(
    Line(points = {{32, 46}, {32, 76}, {12, 76}}, color = {0, 0, 127}));
  connect(feedback.y, pi.u) annotation(
    Line(points = {{32, 30}, {58, 30}, {58, 38}}, color = {0, 0, 127}));
  connect(pi.y, limiter.u) annotation(
    Line(points = {{82, 38}, {90, 38}, {90, -8}, {16, -8}}, color = {0, 0, 127}));
  connect(limiter.y, abc_me_FMU1.x) annotation(
    Line(points = {{-6, -8}, {-76, -8}, {-76, 40}, {-56, 40}}, color = {0, 0, 127}));
  annotation(
    uses(Modelica(version = "4.0.0")),
    Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}})));
end Test_control;

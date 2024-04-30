model Hope
  Modelica.Blocks.Sources.Step step(height = 2, startTime = 1)  annotation(
    Placement(visible = true, transformation(origin = {6, 78}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Continuous.PI pi(T = 0.5, k = 1, x_start = 0, y_start = 1)  annotation(
    Placement(visible = true, transformation(origin = {56, 50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Feedback feedback annotation(
    Placement(visible = true, transformation(origin = {24, 48}, extent = {{-10, 10}, {10, -10}}, rotation = 0)));
  Modelica.Blocks.Nonlinear.Limiter limiter(homotopyType = Modelica.Blocks.Types.LimiterHomotopy.LowerLimit,uMax = 5, uMin = 2)  annotation(
    Placement(visible = true, transformation(origin = {14, 8}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  abc_me_FMU abc_me_FMU1 annotation(
    Placement(visible = true, transformation(origin = {-28, 42}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(step.y, feedback.u2) annotation(
    Line(points = {{18, 78}, {24, 78}, {24, 56}}, color = {0, 0, 127}));
  connect(feedback.y, pi.u) annotation(
    Line(points = {{34, 48}, {44, 48}, {44, 50}}, color = {0, 0, 127}));
  connect(pi.y, limiter.u) annotation(
    Line(points = {{68, 50}, {78, 50}, {78, 8}, {26, 8}}, color = {0, 0, 127}));
  connect(feedback.u1, abc_me_FMU1.y) annotation(
    Line(points = {{16, 48}, {-1, 48}, {-1, 50}, {-16, 50}}, color = {0, 0, 127}));
  connect(limiter.y, abc_me_FMU1.x) annotation(
    Line(points = {{4, 8}, {-62, 8}, {-62, 50}, {-38, 50}}, color = {0, 0, 127}));
  annotation(
    uses(Modelica(version = "4.0.0")));
end Hope;

model Scheibenlaeufer
  Motor motor annotation(
    Placement(visible = true, transformation(origin = {-28, 46}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Generator generator annotation(
    Placement(visible = true, transformation(origin = {8, 46}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Continuous.PI pi(T = 0.1, k = 2) annotation(
    Placement(visible = true, transformation(origin = {78, 44}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Nonlinear.Limiter limiter(uMax = 5, uMin = 0) annotation(
    Placement(visible = true, transformation(origin = {14, -8}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Feedback feedback annotation(
    Placement(visible = true, transformation(origin = {54, 52}, extent = {{10, 10}, {-10, -10}}, rotation = 90)));
  Modelica.Blocks.Sources.Step step(height = 1.5, startTime = 0.4) annotation(
    Placement(visible = true, transformation(origin = {8, 90}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(motor.y, generator.M) annotation(
    Line(points = {{-16, 46}, {-4, 46}}, color = {0, 0, 127}));
  connect(generator.w, motor.w) annotation(
    Line(points = {{20, 46}, {38, 46}, {38, 22}, {-52, 22}, {-52, 46}, {-40, 46}}, color = {0, 0, 127}));
  connect(motor.wp, generator.wp) annotation(
    Line(points = {{-40, 40}, {-44, 40}, {-44, 28}, {28, 28}, {28, 38}, {20, 38}}, color = {0, 0, 127}));
  connect(generator.y, feedback.u2) annotation(
    Line(points = {{20, 54}, {46, 54}, {46, 52}}, color = {0, 0, 127}));
  connect(feedback.y, pi.u) annotation(
    Line(points = {{54, 44}, {66, 44}}, color = {0, 0, 127}));
  connect(pi.y, limiter.u) annotation(
    Line(points = {{90, 44}, {92, 44}, {92, -8}, {26, -8}}, color = {0, 0, 127}));
  connect(step.y, feedback.u1) annotation(
    Line(points = {{20, 90}, {54, 90}, {54, 60}}, color = {0, 0, 127}));
  connect(limiter.y, motor.u) annotation(
    Line(points = {{4, -8}, {-72, -8}, {-72, 52}, {-40, 52}}, color = {0, 0, 127}));
  annotation(
    uses(Modelica(version = "4.0.0")));
end Scheibenlaeufer;

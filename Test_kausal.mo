model Scheibenlaeufer
  Motor motor annotation(
    Placement(visible = true, transformation(origin = {-28, 46}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Generator generator annotation(
    Placement(visible = true, transformation(origin = {8, 46}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Nonlinear.Limiter limiter(uMax = 20, uMin = 0) annotation(
    Placement(visible = true, transformation(origin = {-22, 82}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
  Modelica.Blocks.Continuous.PI pi(T = 0.5, k = 10) annotation(
    Placement(visible = true, transformation(origin = {22, 84}, extent = {{10, 10}, {-10, -10}}, rotation = 0)));
  Modelica.Blocks.Sources.Step step(height = 4, startTime = 0.1) annotation(
    Placement(visible = true, transformation(origin = {56, 28}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Feedback feedback annotation(
    Placement(visible = true, transformation(origin = {64, 54}, extent = {{10, -10}, {-10, 10}}, rotation = -90)));
equation
  connect(motor.y, generator.M) annotation(
    Line(points = {{-16, 46}, {-4, 46}}, color = {0, 0, 127}));
  connect(generator.w, motor.w) annotation(
    Line(points = {{20, 46}, {38, 46}, {38, 22}, {-52, 22}, {-52, 46}, {-40, 46}}, color = {0, 0, 127}));
  connect(motor.wp, generator.wp) annotation(
    Line(points = {{-40, 40}, {-44, 40}, {-44, 28}, {28, 28}, {28, 38}, {20, 38}}, color = {0, 0, 127}));
  connect(generator.y, feedback.u2) annotation(
    Line(points = {{20, 54}, {56, 54}}, color = {0, 0, 127}));
  connect(step.y, feedback.u1) annotation(
    Line(points = {{68, 28}, {70, 28}, {70, 46}, {64, 46}}, color = {0, 0, 127}));
  connect(feedback.y, pi.u) annotation(
    Line(points = {{64, 64}, {34, 64}, {34, 84}}, color = {0, 0, 127}));
  connect(pi.y, limiter.u) annotation(
    Line(points = {{12, 84}, {-10, 84}, {-10, 82}}, color = {0, 0, 127}));
  connect(limiter.y, motor.u) annotation(
    Line(points = {{-32, 82}, {-68, 82}, {-68, 52}, {-40, 52}}, color = {0, 0, 127}));
  annotation(
    uses(Modelica(version = "4.0.0")));
end Scheibenlaeufer;

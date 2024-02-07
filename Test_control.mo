model Test_control
  abc_me_FMU abc_me_FMU1 annotation(
    Placement(visible = true, transformation(origin = {-56, 52}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Continuous.PI pi(T = 0.1, k = 2) annotation(
    Placement(visible = true, transformation(origin = {60, 58}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Last last annotation(
    Placement(visible = true, transformation(origin = {-20, 52}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Feedback feedback annotation(
    Placement(visible = true, transformation(origin = {22, 58}, extent = {{10, 10}, {-10, -10}}, rotation = 90)));
  Modelica.Blocks.Nonlinear.Limiter limiter(uMax = 5, uMin = 0) annotation(
    Placement(visible = true, transformation(origin = {-6, 12}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Step step(height = 0.5, startTime = 0.2) annotation(
    Placement(visible = true, transformation(origin = {-12, 88}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Motor motor annotation(
    Placement(visible = true, transformation(origin = {-36, -26}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Generator generator annotation(
    Placement(visible = true, transformation(origin = {0, -26}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Step step1(height = 4, startTime = 0.2)  annotation(
    Placement(visible = true, transformation(origin = {-88, -2}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(feedback.y, pi.u) annotation(
    Line(points = {{22, 49}, {48, 49}, {48, 57}}, color = {0, 0, 127}));
  connect(pi.y, limiter.u) annotation(
    Line(points = {{71, 58}, {79, 58}, {79, 12}, {5, 12}}, color = {0, 0, 127}));
  connect(feedback.u1, step.y) annotation(
    Line(points = {{22, 66}, {22, 88}, {-1, 88}}, color = {0, 0, 127}));
  connect(abc_me_FMU1.y, last.Ug) annotation(
    Line(points = {{-45, 59}, {-39, 59}, {-39, 52}, {-32, 52}}, color = {0, 0, 127}));
  connect(last.Ur, feedback.u2) annotation(
    Line(points = {{-9, 59}, {-9, 57.2}, {13, 57.2}, {13, 57.4}}, color = {0, 0, 127}));
  connect(motor.wp, generator.wp) annotation(
    Line(points = {{-48, -31.8}, {-52, -31.8}, {-52, -43.8}, {20, -43.8}, {20, -33.8}, {12, -33.8}}, color = {0, 0, 127}));
  connect(motor.y, generator.M) annotation(
    Line(points = {{-25, -25.8}, {-13, -25.8}}, color = {0, 0, 127}));
  connect(generator.w, motor.w) annotation(
    Line(points = {{11, -26}, {29, -26}, {29, -50}, {-61, -50}, {-61, -26}, {-49, -26}}, color = {0, 0, 127}));
  connect(limiter.y, abc_me_FMU1.x) annotation(
    Line(points = {{-16, 12}, {-74, 12}, {-74, 60}, {-66, 60}}, color = {0, 0, 127}));
  connect(limiter.y, motor.u) annotation(
    Line(points = {{-16, 12}, {-60, 12}, {-60, -20}, {-48, -20}}, color = {0, 0, 127}));
  annotation(
    uses(Modelica(version = "4.0.0")),
    Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}})));
end Test_control;

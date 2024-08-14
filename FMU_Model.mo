model Test_control
  Modelica.Blocks.Continuous.PI pi(T = 0.1, k = 2) annotation(
    Placement(visible = true, transformation(origin = {60, 58}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Feedback feedback annotation(
    Placement(visible = true, transformation(origin = {22, 58}, extent = {{10, 10}, {-10, -10}}, rotation = 90)));
  Modelica.Blocks.Sources.Step step(height = 0.5, startTime = 0.2) annotation(
    Placement(visible = true, transformation(origin = {-12, 88}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Logical.Switch switch11 annotation(
    Placement(visible = true, transformation(origin = {0, -36}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  Modelica.Blocks.Logical.GreaterThreshold greaterThreshold(threshold = 4.5) annotation(
    Placement(visible = true, transformation(origin = {46, 22}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  Modelica.Blocks.Logical.Or or1 annotation(
    Placement(visible = true, transformation(origin = {-42, -20}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Step step2(height = 5, startTime = 0) annotation(
    Placement(visible = true, transformation(origin = {52, -78}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  Modelica.Blocks.Logical.Switch limiter annotation(
    Placement(visible = true, transformation(origin = {-14, 6}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Step step1(height = 0, startTime = 0) annotation(
    Placement(visible = true, transformation(origin = {54, -12}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  Modelica.Blocks.Logical.LessEqualThreshold lessEqualThreshold(threshold = 0.4) annotation(
    Placement(visible = true, transformation(origin = {48, -46}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  abc_me_FMU abc_me_FMU1 annotation(
    Placement(visible = true, transformation(origin = {-38, 52}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(feedback.y, pi.u) annotation(
    Line(points = {{22, 49}, {48, 49}, {48, 57}}, color = {0, 0, 127}));
  connect(feedback.u1, step.y) annotation(
    Line(points = {{22, 66}, {22, 88}, {-1, 88}}, color = {0, 0, 127}));
  connect(lessEqualThreshold.y, or1.u2) annotation(
    Line(points = {{37, -46}, {31, -46}, {31, -52}, {-31, -52}, {-31, -28}}, color = {255, 0, 255}));
  connect(switch11.y, limiter.u1) annotation(
    Line(points = {{-11, -36}, {-17, -36}, {-17, -8}, {9, -8}, {9, 14}, {-3, 14}}, color = {0, 0, 127}));
  connect(greaterThreshold.y, or1.u1) annotation(
    Line(points = {{35, 22}, {25, 22}, {25, -20}, {-31, -20}}, color = {255, 0, 255}));
  connect(step2.y, switch11.u3) annotation(
    Line(points = {{41, -78}, {17, -78}, {17, -44}, {11, -44}}, color = {0, 0, 127}));
  connect(lessEqualThreshold.y, switch11.u2) annotation(
    Line(points = {{37, -46}, {21, -46}, {21, -36}, {11, -36}}, color = {255, 0, 255}));
  connect(or1.y, limiter.u2) annotation(
    Line(points = {{-53, -20}, {-63, -20}, {-63, 24}, {17, 24}, {17, 6}, {-3, 6}}, color = {255, 0, 255}));
  connect(step1.y, switch11.u1) annotation(
    Line(points = {{43, -12}, {17, -12}, {17, -28}, {11, -28}}, color = {0, 0, 127}));
  connect(lessEqualThreshold.u, pi.y) annotation(
    Line(points = {{60, -46}, {86, -46}, {86, 58}, {72, 58}}, color = {0, 0, 127}));
  connect(greaterThreshold.u, pi.y) annotation(
    Line(points = {{58, 22}, {86, 22}, {86, 58}, {72, 58}}, color = {0, 0, 127}));
  connect(limiter.u3, pi.y) annotation(
    Line(points = {{-2, -2}, {86, -2}, {86, 58}, {72, 58}}, color = {0, 0, 127}));
  connect(feedback.u2, abc_me_FMU1.y) annotation(
    Line(points = {{14, 58}, {-7, 58}, {-7, 60}, {-26, 60}}, color = {0, 0, 127}));
  connect(abc_me_FMU1.x, limiter.y) annotation(
    Line(points = {{-48, 60}, {-74, 60}, {-74, 6}, {-24, 6}}, color = {0, 0, 127}));
  annotation(
    uses(Modelica(version = "4.0.0")),
    Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}})));
end Test_control;

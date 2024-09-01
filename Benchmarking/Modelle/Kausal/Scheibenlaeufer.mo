model Scheibenlaeufer
  Motor motor annotation(
    Placement(visible = true, transformation(origin = {-28, 46}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Generator generator annotation(
    Placement(visible = true, transformation(origin = {8, 46}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  abc_me_FMU abc_me_FMU1 annotation(
    Placement(visible = true, transformation(origin = {-30, 2}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Trapezoid trapezoid(amplitude = 4, falling = 0.2, rising = 0.2, width = 0.5)  annotation(
    Placement(visible = true, transformation(origin = {-86, 52}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(motor.y, generator.M) annotation(
    Line(points = {{-16, 46}, {-4, 46}}, color = {0, 0, 127}));
  connect(generator.w, motor.w) annotation(
    Line(points = {{20, 46}, {38, 46}, {38, 22}, {-52, 22}, {-52, 46}, {-40, 46}}, color = {0, 0, 127}));
  connect(motor.wp, generator.wp) annotation(
    Line(points = {{-40, 40}, {-44, 40}, {-44, 28}, {28, 28}, {28, 38}, {20, 38}}, color = {0, 0, 127}));
  connect(trapezoid.y, motor.u) annotation(
    Line(points = {{-74, 52}, {-40, 52}}, color = {0, 0, 127}));
  connect(abc_me_FMU1.x, trapezoid.y) annotation(
    Line(points = {{-40, 10}, {-74, 10}, {-74, 52}}, color = {0, 0, 127}));
  annotation(
    uses(Modelica(version = "4.0.0")),
    Diagram);
end Scheibenlaeufer;

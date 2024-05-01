package Auswertung
  model Test_control
  Modelica.Blocks.Sources.Step step1(height = 0, startTime = 0) annotation(
      Placement(visible = true, transformation(origin = {44, -20}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  Modelica.Blocks.Logical.Or or1 annotation(
      Placement(visible = true, transformation(origin = {-52, -28}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  Modelica.Blocks.Logical.Switch switch11 annotation(
      Placement(visible = true, transformation(origin = {-10, -44}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Step step(height = 1.5, startTime = 0.2) annotation(
      Placement(visible = true, transformation(origin = {-30, 86}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Logical.LessEqualThreshold lessEqualThreshold(threshold = 0.4) annotation(
      Placement(visible = true, transformation(origin = {38, -54}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Step step2(height = 5, startTime = 0) annotation(
      Placement(visible = true, transformation(origin = {42, -86}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  Modelica.Blocks.Logical.GreaterThreshold greaterThreshold(threshold = 4.5) annotation(
      Placement(visible = true, transformation(origin = {36, 14}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  Modelica.Blocks.Logical.Switch limiter annotation(
      Placement(visible = true, transformation(origin = {-24, -2}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Add add(k1 = +1, k2 = -1) annotation(
      Placement(visible = true, transformation(origin = {14, 52}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Continuous.PI pi(k = 15)  annotation(
      Placement(visible = true, transformation(origin = {60, 52}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  abc_me_FMU abc_me_FMU1 annotation(
      Placement(visible = true, transformation(origin = {-58, 46}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  equation
    connect(add.u1, step.y) annotation(
      Line(points = {{2, 58}, {-14, 58}, {-14, 86}, {-18, 86}}, color = {0, 0, 127}));
    connect(step2.y, switch11.u3) annotation(
      Line(points = {{31, -86}, {7, -86}, {7, -52}, {1, -52}}, color = {0, 0, 127}));
    connect(lessEqualThreshold.y, switch11.u2) annotation(
      Line(points = {{27, -54}, {11, -54}, {11, -44}, {1, -44}}, color = {255, 0, 255}));
    connect(step1.y, switch11.u1) annotation(
      Line(points = {{33, -20}, {7, -20}, {7, -36}, {1, -36}}, color = {0, 0, 127}));
    connect(lessEqualThreshold.y, or1.u2) annotation(
      Line(points = {{27, -54}, {21, -54}, {21, -60}, {-41, -60}, {-41, -36}}, color = {255, 0, 255}));
    connect(or1.y, limiter.u2) annotation(
      Line(points = {{-63, -28}, {-73, -28}, {-73, 16}, {7, 16}, {7, -2}, {-13, -2}}, color = {255, 0, 255}));
    connect(greaterThreshold.y, or1.u1) annotation(
      Line(points = {{25, 14}, {15, 14}, {15, -28}, {-41, -28}}, color = {255, 0, 255}));
    connect(switch11.y, limiter.u1) annotation(
      Line(points = {{-21, -44}, {-27, -44}, {-27, -16}, {-1, -16}, {-1, 6}, {-13, 6}}, color = {0, 0, 127}));
    connect(add.y, pi.u) annotation(
      Line(points = {{26, 52}, {48, 52}}, color = {0, 0, 127}));
    connect(pi.y, lessEqualThreshold.u) annotation(
      Line(points = {{71, 52}, {78, 52}, {78, -54}, {50, -54}}, color = {0, 0, 127}));
    connect(pi.y, greaterThreshold.u) annotation(
      Line(points = {{71, 52}, {57.5, 52}, {57.5, 14}, {48, 14}}, color = {0, 0, 127}));
    connect(limiter.u3, pi.y) annotation(
      Line(points = {{-12, -10}, {84, -10}, {84, 52}, {72, 52}}, color = {0, 0, 127}));
  connect(abc_me_FMU1.y, add.u2) annotation(
      Line(points = {{-46, 54}, {-12, 54}, {-12, 46}, {2, 46}}, color = {0, 0, 127}));
  connect(limiter.y, abc_me_FMU1.x) annotation(
      Line(points = {{-34, -2}, {-86, -2}, {-86, 54}, {-68, 54}}, color = {0, 0, 127}));
    annotation(
      uses(Modelica(version = "4.0.0")),
      Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}})));
  end Test_control;

  block Generator
    parameter Real Ra = 8.25;
    parameter Real c = 51.5e-3;
    parameter Real L = 0.375e-3;
    parameter Real cu = 0.3248e-3;
    parameter Real J = 47.5e-6;
    parameter Real RL = 100;
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
    Modelica.Blocks.Interfaces.RealOutput Ug annotation(
      Placement(visible = true, transformation(origin = {154, -92}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {2, 110}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
    Modelica.Blocks.Math.Gain gain6(k = L) annotation(
      Placement(visible = true, transformation(origin = {4, -92}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
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
    connect(add3.u1, gain.y) annotation(
      Line(points = {{36, 12}, {36, 45}, {18, 45}, {18, 78}, {-27, 78}}, color = {0, 0, 127}));
    connect(integrator.y, gain2.u) annotation(
      Line(points = {{-30, 4}, {-22, 4}, {-22, -42}, {-32, -42}}, color = {0, 0, 127}));
    connect(M, gain.u) annotation(
      Line(points = {{-100, 78}, {-50, 78}}, color = {0, 0, 127}));
    connect(integrator.y, gain5.u) annotation(
      Line(points = {{-30, 4}, {-22, 4}, {-22, 86}, {40, 86}, {40, 76}, {52, 76}}, color = {0, 0, 127}));
    connect(gain3.y, gain6.u) annotation(
      Line(points = {{-54, -76}, {-66, -76}, {-66, -92}, {-8, -92}}, color = {0, 0, 127}));
    connect(gain6.y, Ug) annotation(
      Line(points = {{16, -92}, {154, -92}}, color = {0, 0, 127}));
    annotation(
      uses(Modelica(version = "4.0.0")),
      Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}})));
  end Generator;

  block Motor
    parameter Real Ra = 8.25;
    parameter Real c = 51.5e-3;
    parameter Real L = 0.375e-3;
    parameter Real cu = 0.3248e-3;
    parameter Real J = 47.5e-6;
    Modelica.Blocks.Interfaces.RealInput u annotation(
      Placement(visible = true, transformation(origin = {-100, 62}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-120, 62}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
    Modelica.Blocks.Interfaces.RealInput w annotation(
      Placement(visible = true, transformation(origin = {-100, 4}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-118, 0}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
    Modelica.Blocks.Interfaces.RealInput wp annotation(
      Placement(visible = true, transformation(origin = {-100, -60}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-120, -58}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
    Modelica.Blocks.Math.Gain gain(k = 1/L) annotation(
      Placement(visible = true, transformation(origin = {-52, 62}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Math.Gain gain1(k = c/L) annotation(
      Placement(visible = true, transformation(origin = {-54, 4}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Math.Gain gain2(k = J) annotation(
      Placement(visible = true, transformation(origin = {-50, -60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Math.Add3 add3(k2 = -1, k3 = -1) annotation(
      Placement(visible = true, transformation(origin = {-10, 54}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Math.Gain gain3(k = cu) annotation(
      Placement(visible = true, transformation(origin = {-22, -16}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Math.Gain gain4(k = c) annotation(
      Placement(visible = true, transformation(origin = {38, 54}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Math.Gain gain5(k = Ra/L) annotation(
      Placement(visible = true, transformation(origin = {-4, 26}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
    Modelica.Blocks.Math.Add3 add31(k2 = -1, k3 = -1) annotation(
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

  block Last
    parameter Real Ra = 8.25;
    parameter Real L = 0.375e-3;
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

  model abc_me_FMU "Block that.simulators a vector of real values with Simulator"
    constant String fmuWorkingDir = "C:/Users/JP/AppData/Local/Temp/OpenModelica/OMEdit/temp20240426091649760";
    parameter Integer logLevel = 3 "log level used during the loading of FMU" annotation(
      Dialog(tab = "FMI", group = "Enable logging"));
    parameter Boolean debugLogging = false "enables the FMU simulation logging" annotation(
      Dialog(tab = "FMI", group = "Enable logging"));
    Real _D_TMP_1_1_;
    Real _D_TMP_3_1_;
    Modelica.Blocks.Interfaces.RealInput x "Voltage" annotation(
      Placement(transformation(extent = {{-120, 60}, {-100, 80}})));
    Modelica.Blocks.Interfaces.RealOutput y "Current" annotation(
      Placement(transformation(extent = {{100, 60}, {120, 80}})));
    parameter Boolean _saveToFile = false "Flag for writing results";
    parameter String _configurationFileName = "C:/Users/Public/server_config.txt" "parameter";
  protected
    FMI2ModelExchange fmi2me = FMI2ModelExchange(logLevel, fmuWorkingDir, "abc", debugLogging);
    constant Integer numberOfContinuousStates = 0;
    Real fmi_x[numberOfContinuousStates] "States";
    Real fmi_x_new[numberOfContinuousStates](each fixed = true) "New States";
    constant Integer numberOfEventIndicators = 0;
    Real fmi_z[numberOfEventIndicators] "Events Indicators";
    Boolean fmi_z_positive[numberOfEventIndicators](each fixed = true);
    parameter Real flowStartTime(fixed = false);
    Real flowTime;
    parameter Real flowEnterInitialization(fixed = false);
    parameter Real flowInitialized(fixed = false);
    parameter Real flowParamsStart(fixed = false);
    parameter Real flowInitInputs(fixed = false);
    Real flowStatesInputs;
    Real realInputVariables[1];
    Real fmi_input_x;
    Boolean callEventUpdate;
    Boolean newStatesAvailable(fixed = true);
    Real triggerDSSEvent;
    Real nextEventTime(fixed = true);

    class FMI2ModelExchange
      extends ExternalObject;

      function constructor
        input Integer logLevel;
        input String workingDirectory;
        input String instanceName;
        input Boolean debugLogging;
        output FMI2ModelExchange fmi2me;
      
        external "C" fmi2me = FMI2ModelExchangeConstructor_OMC(logLevel, workingDirectory, instanceName, debugLogging) annotation(
          Library = {"OpenModelicaFMIRuntimeC", "fmilib"});
      end constructor;

      function destructor
        input FMI2ModelExchange fmi2me;
      
        external "C" FMI2ModelExchangeDestructor_OMC(fmi2me) annotation(
          Library = {"OpenModelicaFMIRuntimeC", "fmilib"});
      end destructor;
    end FMI2ModelExchange;

    package fmi2Functions
      function fmi2SetupExperiment
        input FMI2ModelExchange fmi2me;
        input Boolean inToleranceDefined;
        input Real inTolerance;
        input Real inStartTime;
        input Boolean inStopTimeDefined;
        input Real inStopTime;
        input Real inFlow;
        output Real outFlow = inFlow;
      
        external "C" fmi2SetupExperiment_OMC(fmi2me, inToleranceDefined, inTolerance, inStartTime, inStopTimeDefined, inStopTime) annotation(
          Library = {"OpenModelicaFMIRuntimeC", "fmilib"});
      end fmi2SetupExperiment;

      function fmi2SetTime
        input FMI2ModelExchange fmi2me;
        input Real inTime;
        input Real inFlow;
        output Real outFlow = inFlow;
      
        external "C" fmi2SetTime_OMC(fmi2me, inTime) annotation(
          Library = {"OpenModelicaFMIRuntimeC", "fmilib"});
      end fmi2SetTime;

      function fmi2EnterInitialization
        input FMI2ModelExchange fmi2me;
        input Real inFlowVariable;
        output Real outFlowVariable = inFlowVariable;
      
        external "C" fmi2EnterInitializationModel_OMC(fmi2me) annotation(
          Library = {"OpenModelicaFMIRuntimeC", "fmilib"});
      end fmi2EnterInitialization;

      function fmi2ExitInitialization
        input FMI2ModelExchange fmi2me;
        input Real inFlowVariable;
        output Real outFlowVariable = inFlowVariable;
      
        external "C" fmi2ExitInitializationModel_OMC(fmi2me) annotation(
          Library = {"OpenModelicaFMIRuntimeC", "fmilib"});
      end fmi2ExitInitialization;

      function fmi2GetContinuousStates
        input FMI2ModelExchange fmi2me;
        input Integer numberOfContinuousStates;
        input Real inFlowParams;
        output Real fmi_x[numberOfContinuousStates];
      
        external "C" fmi2GetContinuousStates_OMC(fmi2me, numberOfContinuousStates, inFlowParams, fmi_x) annotation(
          Library = {"OpenModelicaFMIRuntimeC", "fmilib"});
      end fmi2GetContinuousStates;

      function fmi2SetContinuousStates
        input FMI2ModelExchange fmi2me;
        input Real fmi_x[:];
        input Real inFlowParams;
        output Real outFlowStates;
      
        external "C" outFlowStates = fmi2SetContinuousStates_OMC(fmi2me, size(fmi_x, 1), inFlowParams, fmi_x) annotation(
          Library = {"OpenModelicaFMIRuntimeC", "fmilib"});
      end fmi2SetContinuousStates;

      function fmi2GetDerivatives
        input FMI2ModelExchange fmi2me;
        input Integer numberOfContinuousStates;
        input Real inFlowStates;
        output Real fmi_x[numberOfContinuousStates];
      
        external "C" fmi2GetDerivatives_OMC(fmi2me, numberOfContinuousStates, inFlowStates, fmi_x) annotation(
          Library = {"OpenModelicaFMIRuntimeC", "fmilib"});
      end fmi2GetDerivatives;

      function fmi2GetEventIndicators
        input FMI2ModelExchange fmi2me;
        input Integer numberOfEventIndicators;
        input Real inFlowStates;
        output Real fmi_z[numberOfEventIndicators];
      
        external "C" fmi2GetEventIndicators_OMC(fmi2me, numberOfEventIndicators, inFlowStates, fmi_z) annotation(
          Library = {"OpenModelicaFMIRuntimeC", "fmilib"});
      end fmi2GetEventIndicators;

      function fmi2GetReal
        input FMI2ModelExchange fmi2me;
        input Real realValuesReferences[:];
        input Real inFlowStatesInput;
        output Real realValues[size(realValuesReferences, 1)];
      
        external "C" fmi2GetReal_OMC(fmi2me, size(realValuesReferences, 1), realValuesReferences, inFlowStatesInput, realValues, 1) annotation(
          Library = {"OpenModelicaFMIRuntimeC", "fmilib"});
      end fmi2GetReal;

      function fmi2SetReal
        input FMI2ModelExchange fmi2me;
        input Real realValueReferences[:];
        input Real realValues[size(realValueReferences, 1)];
        output Real outValues[size(realValueReferences, 1)] = realValues;
      
        external "C" fmi2SetReal_OMC(fmi2me, size(realValueReferences, 1), realValueReferences, realValues, 1) annotation(
          Library = {"OpenModelicaFMIRuntimeC", "fmilib"});
      end fmi2SetReal;

      function fmi2SetRealParameter
        input FMI2ModelExchange fmi2me;
        input Real realValueReferences[:];
        input Real realValues[size(realValueReferences, 1)];
        output Real out_Value = 1;
      
        external "C" fmi2SetReal_OMC(fmi2me, size(realValueReferences, 1), realValueReferences, realValues, 1) annotation(
          Library = {"OpenModelicaFMIRuntimeC", "fmilib"});
      end fmi2SetRealParameter;

      function fmi2GetInteger
        input FMI2ModelExchange fmi2me;
        input Real integerValueReferences[:];
        input Real inFlowStatesInput;
        output Integer integerValues[size(integerValueReferences, 1)];
      
        external "C" fmi2GetInteger_OMC(fmi2me, size(integerValueReferences, 1), integerValueReferences, inFlowStatesInput, integerValues, 1) annotation(
          Library = {"OpenModelicaFMIRuntimeC", "fmilib"});
      end fmi2GetInteger;

      function fmi2SetInteger
        input FMI2ModelExchange fmi2me;
        input Real integerValuesReferences[:];
        input Integer integerValues[size(integerValuesReferences, 1)];
        output Integer outValues[size(integerValuesReferences, 1)] = integerValues;
      
        external "C" fmi2SetInteger_OMC(fmi2me, size(integerValuesReferences, 1), integerValuesReferences, integerValues, 1) annotation(
          Library = {"OpenModelicaFMIRuntimeC", "fmilib"});
      end fmi2SetInteger;

      function fmi2SetIntegerParameter
        input FMI2ModelExchange fmi2me;
        input Real integerValuesReferences[:];
        input Integer integerValues[size(integerValuesReferences, 1)];
        output Real out_Value = 1;
      
        external "C" fmi2SetInteger_OMC(fmi2me, size(integerValuesReferences, 1), integerValuesReferences, integerValues, 1) annotation(
          Library = {"OpenModelicaFMIRuntimeC", "fmilib"});
      end fmi2SetIntegerParameter;

      function fmi2GetBoolean
        input FMI2ModelExchange fmi2me;
        input Real booleanValuesReferences[:];
        input Real inFlowStatesInput;
        output Boolean booleanValues[size(booleanValuesReferences, 1)];
      
        external "C" fmi2GetBoolean_OMC(fmi2me, size(booleanValuesReferences, 1), booleanValuesReferences, inFlowStatesInput, booleanValues, 1) annotation(
          Library = {"OpenModelicaFMIRuntimeC", "fmilib"});
      end fmi2GetBoolean;

      function fmi2SetBoolean
        input FMI2ModelExchange fmi2me;
        input Real booleanValueReferences[:];
        input Boolean booleanValues[size(booleanValueReferences, 1)];
        output Boolean outValues[size(booleanValueReferences, 1)] = booleanValues;
      
        external "C" fmi2SetBoolean_OMC(fmi2me, size(booleanValueReferences, 1), booleanValueReferences, booleanValues, 1) annotation(
          Library = {"OpenModelicaFMIRuntimeC", "fmilib"});
      end fmi2SetBoolean;

      function fmi2SetBooleanParameter
        input FMI2ModelExchange fmi2me;
        input Real booleanValueReferences[:];
        input Boolean booleanValues[size(booleanValueReferences, 1)];
        output Real out_Value = 1;
      
        external "C" fmi2SetBoolean_OMC(fmi2me, size(booleanValueReferences, 1), booleanValueReferences, booleanValues, 1) annotation(
          Library = {"OpenModelicaFMIRuntimeC", "fmilib"});
      end fmi2SetBooleanParameter;

      function fmi2GetString
        input FMI2ModelExchange fmi2me;
        input Real stringValuesReferences[:];
        input Real inFlowStatesInput;
        output String stringValues[size(stringValuesReferences, 1)];
      
        external "C" fmi2GetString_OMC(fmi2me, size(stringValuesReferences, 1), stringValuesReferences, inFlowStatesInput, stringValues, 1) annotation(
          Library = {"OpenModelicaFMIRuntimeC", "fmilib"});
      end fmi2GetString;

      function fmi2SetString
        input FMI2ModelExchange fmi2me;
        input Real stringValueReferences[:];
        input String stringValues[size(stringValueReferences, 1)];
        output String outValues[size(stringValueReferences, 1)] = stringValues;
      
        external "C" fmi2SetString_OMC(fmi2me, size(stringValueReferences, 1), stringValueReferences, stringValues, 1) annotation(
          Library = {"OpenModelicaFMIRuntimeC", "fmilib"});
      end fmi2SetString;

      function fmi2SetStringParameter
        input FMI2ModelExchange fmi2me;
        input Real stringValueReferences[:];
        input String stringValues[size(stringValueReferences, 1)];
        output Real out_Value = 1;
      
        external "C" fmi2SetString_OMC(fmi2me, size(stringValueReferences, 1), stringValueReferences, stringValues, 1) annotation(
          Library = {"OpenModelicaFMIRuntimeC", "fmilib"});
      end fmi2SetStringParameter;

      function fmi2EventUpdate
        input FMI2ModelExchange fmi2me;
        output Boolean outNewStatesAvailable;
      
        external "C" outNewStatesAvailable = fmi2EventUpdate_OMC(fmi2me) annotation(
          Library = {"OpenModelicaFMIRuntimeC", "fmilib"});
      end fmi2EventUpdate;

      function fmi2nextEventTime
        input FMI2ModelExchange fmi2me;
        input Real inFlowStates;
        output Real outNewnextTime;
      
        external "C" outNewnextTime = fmi2nextEventTime_OMC(fmi2me, inFlowStates) annotation(
          Library = {"OpenModelicaFMIRuntimeC", "fmilib"});
      end fmi2nextEventTime;

      function fmi2CompletedIntegratorStep
        input FMI2ModelExchange fmi2me;
        input Real inFlowStates;
        output Boolean outCallEventUpdate;
      
        external "C" outCallEventUpdate = fmi2CompletedIntegratorStep_OMC(fmi2me, inFlowStates) annotation(
          Library = {"OpenModelicaFMIRuntimeC", "fmilib"});
      end fmi2CompletedIntegratorStep;
    end fmi2Functions;
  initial equation

  initial algorithm
    flowParamsStart := 1;
    flowInitInputs := 1;
    flowStartTime := fmi2Functions.fmi2SetupExperiment(fmi2me, false, 0.0, time, false, 0.0, flowParamsStart + flowInitInputs);
    flowEnterInitialization := fmi2Functions.fmi2EnterInitialization(fmi2me, flowParamsStart + flowInitInputs + flowStartTime);
    flowInitialized := fmi2Functions.fmi2ExitInitialization(fmi2me, flowParamsStart + flowInitInputs + flowStartTime + flowEnterInitialization);
    flowParamsStart := fmi2Functions.fmi2SetBooleanParameter(fmi2me, {0.0}, {_saveToFile});
    flowParamsStart := fmi2Functions.fmi2SetStringParameter(fmi2me, {0.0}, {_configurationFileName});
  initial equation

  algorithm
    flowTime := if not initial() then fmi2Functions.fmi2SetTime(fmi2me, time, flowInitialized) else time;
/* algorithm section ensures that inputs to fmi (if any) are set directly after the new time is set */
    realInputVariables := fmi2Functions.fmi2SetReal(fmi2me, {2.0}, {x});
  equation
    {fmi_input_x} = realInputVariables;
    flowStatesInputs = fmi2Functions.fmi2SetContinuousStates(fmi2me, fmi_x, flowParamsStart + flowTime);
    der(fmi_x) = fmi2Functions.fmi2GetDerivatives(fmi2me, numberOfContinuousStates, flowStatesInputs);
    fmi_z = fmi2Functions.fmi2GetEventIndicators(fmi2me, numberOfEventIndicators, flowStatesInputs);
    for i in 1:size(fmi_z, 1) loop
      fmi_z_positive[i] = if not terminal() then fmi_z[i] > 0 else pre(fmi_z_positive[i]);
    end for;
    triggerDSSEvent = noEvent(if callEventUpdate then flowStatesInputs + 1.0 else flowStatesInputs - 1.0);
    {_D_TMP_1_1_, _D_TMP_3_1_, y} = fmi2Functions.fmi2GetReal(fmi2me, {0.0, 1.0, 3.0}, flowStatesInputs);
    callEventUpdate = fmi2Functions.fmi2CompletedIntegratorStep(fmi2me, flowStatesInputs + flowTime);
  algorithm
    when {triggerDSSEvent > flowStatesInputs, pre(nextEventTime) < time, terminal()} then
      newStatesAvailable := fmi2Functions.fmi2EventUpdate(fmi2me);
      nextEventTime := fmi2Functions.fmi2nextEventTime(fmi2me, flowStatesInputs);
    end when;
    annotation(
      Icon(graphics = {Rectangle(extent = {{-100, 100}, {100, -100}}, lineColor = {0, 0, 0}, fillColor = {240, 240, 240}, fillPattern = FillPattern.Solid, lineThickness = 0.5), Text(extent = {{-100, 40}, {100, 0}}, lineColor = {0, 0, 0}, textString = "%name"), Text(extent = {{-100, -50}, {100, -90}}, lineColor = {0, 0, 0}, textString = "V2.0")}));
    annotation(
      experiment(StartTime = 0.0, StopTime = 1.0, Tolerance = 1e-06));
  end abc_me_FMU;
  annotation(
    uses(Modelica(version = "4.0.0")));
end Auswertung;

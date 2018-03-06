function P = Set_Parameters()

%This function is used to collect all of the user-specified parameters and
%return them as a single struct, P.

%% Physical parameters
    P.gravity = 9.81;    %(m/s^2) gravitational acceleration
    P.mass = 10;        %(kg) mass of the ball

%% Initial Conditions:

    Pos_X = 0;    %(m) Initial horizontal position of the ball
    Pos_Y = 3;  %(m) Initial vertical position of the ball
%     Vel_X = 0.85;    %(m/s) Initial horizontal speed of the ball
    Vel_X = 0.6;    %(m/s) Initial horizontal speed of the ball
    Vel_Y = -1;   %(m/s) Initial vertical speed of the ball

    P.initCond = [Pos_X; Pos_Y; Vel_X; Vel_Y];

%% Display parameters (plotting + animation)

    %ode45 returns points that are widely spaced and not uniformly spaced.
    %Thus, for better plotting I use the function deval to accurately
    %interpolate the solution to a more useful grid spacing, while
    %preserving the endpoints of each trajectory.
    P.plotTimeStep = 0.005;


    %Sometimes it is useful to run the animation either faster or slower
    %than real time. The simulation time tracks the current cpu time,
    %divided by this number. Thus a value of 2 means play a 1 second
    %simulation over the course of 2 seconds of cpu time.
    P.slowMotionFactor = 1;
    
    %Set the font and line sizes for the figures:
    P.TitleFontSize = 18;
    P.LabelFontSize = 16;
    P.LegendFontSize = 14;
    P.AxisFontSize = 14;
    P.CurveLineWidth = 3;
    P.PlotBallSize = 50;
    
    %Set rhythm settings
    P.seq = [2 2 4 1 3];
    P.intervalTime = 0.23;

end
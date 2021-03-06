% function bounces = BouncingBall
% Currently in beta mode, remove all lines that have the comment 'dbg'
% above them

% NOTE: you must input rhythm sequences as a string or character vector enclosed by quotes (e.g.
% "11211" or '11211'), not as integers (e.g. 11211)
clf;
clear;

%% Set Parameters
P = struct(); % All user-defined parameters will be stored here
P.y_velo = eps; % The initial vertical velocity
P.x_velo = 5; % The horizontal velocity (constant)
P.precision = 0; % Round y to this many decimal places to determine whether it is in air
P.acceleration = 9.8; % Set P.acceleration of the ball downwards
P.update_time = 0.001; % update the plot every this many seconds
P.origin = [0 0]; % Where the stairs start
P.timePerBeat = 0.5; % Set the time it takes for a beat in seconds (e.g. for 1121) it would take a total of (1+1+2+1) * time per beat
P.ballRadius = 0.3; % The radius of the bouncing ball
P.ballColor = 'b';
P.leaveTrail = true; % Set this to true if you want the ball to create a trail as it moves
P.animate = true; % Set this to true if you want to see the ball actually moving, rather than the trajectory

y_velo = P.y_velo;
prev_in_air = false; % This should be initially set to false because we assume the ball starts on the ground
% Test points
% widths = [5, 10, 20];
% heights = [5, 6, 7];

[widths, heights, deltas, initialVelocities, times] = RhythmToDims(11111, P); % Get dimensions of stairs from rhythm sequence
[x_points, y_points] = DimsToStairs(widths, heights, P.origin); % Get stair coordinates from dimensions
bounceCoords = GetBounceCoords(x_points, y_points, deltas);
% Set initial position
x = x_points(2); % Start at the end of the first stair
y = y_points(1);
pos = [x, y];


DrawStairs(x_points, y_points); % Plot the stairs
hold on;

DrawBall(P, pos);
tic; % Start timer
currBounce = 1;

%% Loop for animation until termination condition is met
while true
    elapsedTime = toc;
    percentDist = elapsedTime / times(currBounce);
    
    % Calculate new position
%     x = pos(1) + (P.x_velo * P.update_time);
    xOffset = (bounceCoords(currBounce+1, 1) - bounceCoords(currBounce, 1)) * percentDist;
    x = bounceCoords(currBounce, 1) + xOffset;
%     y = pos(2) + (y_velo * P.update_time);
    yOffset = initialVelocities(currBounce) * elapsedTime + 0.5 * P.acceleration * elapsedTime^2;
    y = bounceCoords(currBounce, 2) - yOffset;
    rounded_y = round(y,P.precision);
    rounded_y_points = round(y_points,P.precision);
    
    % Find if ball is airborne by seeing if our new y value is on the
    % stairs
    stairIndex = find(rounded_y_points == rounded_y);
    if sum(stairIndex) == 0 % if we are not on a stair, then we're in the air
        in_air = true;
    else
        stairIndex = stairIndex(FindMinIndex(y, y_points, stairIndex));
        % If we reached the last stair, then decrement the stair index for
        % correct calculations
        if (stairIndex == length(x_points))
            stairIndex = stairIndex - 1;
        end
        
        % Determine the horizontal range that the ball should be
        % in if it is not in the air
        xRange = [x_points(stairIndex), x_points(stairIndex+1)];
        if x < xRange(1) || x > xRange(2)
            in_air = true;
        else
            in_air = false;
        end
    end
    % If it was in the air last point but not anymore, then flip the y velocity, assuming elasticity
    if prev_in_air && ~in_air
        y_velo = -y_velo;
        currBounce = currBounce + 1;
        disp('bounce');
    % If it is in the air, then update the y velocity
    elseif in_air
        y_velo = y_velo - (P.acceleration * P.update_time);
    end
    
    
    prev_in_air = in_air;
    pos = [x, y];
    
    % Termination condition: if both x and y positions are off the plot
    if x > x_points(size(x_points,2)) && y < y_points(size(y_points,2))
        break;
    end

    DrawBall(P, pos);
end
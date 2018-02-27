clf; clear;
%% Test points
x_points = 0:5:20;
y_points = 20:-5:0;

%% Set Parameters
DrawStairs(x_points, y_points);
x = x_points(2) - 0.01;
y = y_points(1);
pos = [x, y];
y_velo = 0;
x_velo = 5;
precision = 0; % Round y to this many decimal places to determine whether it is in air
gravity = 98;
update_time = 0.01; % update the plot every 0.01 seconds
prev_in_air = false;

%% Loop for animation until termination condition is met
while true
    % Calculate new position
    x = pos(1) + (x_velo * update_time);
    y = pos(2) + (y_velo * update_time);
    rounded_y = round(y,precision);
    
    % Find if ball is airborne by seeing if our new y value is on the
    % stairs
    if ~ismember(rounded_y, y_points)
        in_air = true;
    else
        stairIndex = find(y_points == rounded_y);
        % If we reached the last stair, then terminate here
        if (stairIndex == size(x_points, 2) + 1)
            break
        end
        % Otherwise, determine the horizontal range that the ball should be
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
    % If it is in the air, then adjust the y velocity
    elseif in_air
        y_velo = y_velo - (gravity * update_time);
    end
    
    
    prev_in_air = in_air;
    pos = [x, y];
    
    % Termination condition: if both x and y positions are off the plot
    if x > x_points(size(x_points,2)) || y < y_points(size(y_points,2))
        break;
    end

    % Draw the ball at the current position
    ball = viscircles(pos,0.9, 'Color', 'b', 'LineWidth', 10);
    % The interval time to update the plot (the lower the slower)
    pause(update_time);
    % Delete the previous line
    delete(ball);
end
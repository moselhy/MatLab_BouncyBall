% From dimensions, calculate the parameters to the function stairs(x_points, y_points)
function [x_points, y_points] = DimsToStairs(widths, heights, origin, initialDistance)
    numIntervals = length(widths);
    x_points = zeros(1, numIntervals + 2);
    y_points = zeros(1, numIntervals + 2);
    
    x_points(1) = origin(1);
    y_points(1) = origin(2);
    x_points(2) = x_points(1) + widths(1);
    
    for i = 2:numIntervals+1
        y_points(i) = y_points(i-1) - heights(i-1);
        x_points(i+1) = x_points(i) + widths(i-1);
    end
    
    y_points(numIntervals + 2) = y_points(numIntervals + 1);

end
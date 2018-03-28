function [bounceCoords] = GetBounceCoords(x_points, y_points, deltas)
    
    len = length(x_points) - 1;
    bounceCoords = zeros(len, 2);
    
    bounceCoords(1, :) = [x_points(2), y_points(1)];
    for i = 2:len
        bounceCoords(i, :) = [ x_points(i+1) - deltas(i-1), y_points(i) ];
    end

end
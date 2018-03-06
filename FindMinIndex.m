function [minIndex] = FindMinIndex(y, arr, indices)
    minIndex = 1;
    minDist = abs(y - arr(1));
    for i = 2:length(indices)
        dist = abs(y - arr(i));
        if dist < minDist
            minDist = dist;
            minIndex = i;
        end
    end
end
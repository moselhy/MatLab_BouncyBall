% Convert a rhythm sequence to dimensions of a set of stairs
function [widths, heights] = RhythmToDims(rhythmSequence, parameters)
    seq = char(string(rhythmSequence));
    nIntervals = length(seq);
    widths = zeros(nIntervals,1);
    heights = zeros(nIntervals,1);
    curr_y_velo = parameters.y_velo;
    x_velo = parameters.x_velo;
    tpb = parameters.timePerBeat;
    accel = parameters.acceleration;
%     delta = 1; % distance from the bounce to the horizontal end of each stair
    seq = double(seq - '0');
    
%     t = tpb * seq(1);
%     delta = t/4 * x_velo;
%     widths(1) = x_velo * t + delta;
%     heights(1) = curr_y_velo * tpb * seq(1);
    
    for i = 1:nIntervals
        t = tpb * seq(i);
        heights(i) = curr_y_velo * t + 0.5 * accel * t^2;
        curr_y_velo = curr_y_velo + accel * t;
        delta = t/2 * x_velo;
        widths(i) = x_velo * t + delta;
    end
end
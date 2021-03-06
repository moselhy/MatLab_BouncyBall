% Convert a rhythm sequence to dimensions of a set of stairs
function [widths, heights, deltas, velocities, times] = RhythmToDims(rhythmSequence, parameters)
    seq = char(string(rhythmSequence));
    nIntervals = length(seq);
    widths = zeros(nIntervals,1);
    heights = zeros(nIntervals,1);
    deltas = zeros(nIntervals, 1);
    times = zeros(nIntervals, 1);
    velocities = zeros(nIntervals+1, 1);
    velocities(1) = parameters.y_velo;
    x_velo = parameters.x_velo;
    tpb = parameters.timePerBeat;
    accel = parameters.acceleration;
    seq = double(seq - '0');
    
    for i = 1:nIntervals
        t = tpb * seq(i);
        times(i) = t;
        heights(i) = velocities(i) * t + 0.5 * accel * t^2;
        velocities(i+1) = velocities(i) + accel * t;
        deltas(i) = t/2 * x_velo;
        widths(i) = x_velo * t + deltas(i);
    end
end
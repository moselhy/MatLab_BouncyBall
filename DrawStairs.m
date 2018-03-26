function DrawStairs(x_points, y_points)
    stairs(x_points,y_points, 'LineWidth', 2);
    set(gca, 'XLim', [min(x_points) max(x_points)], 'YLim', [min(y_points), max(y_points) + 5]);
end
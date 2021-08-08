function I = get_intervals(x, y, knot_points)
% breaks the x-axis into `numel(knot_points)-1` many intervals
    for i = 2:numel(knot_points)
        points_ind = x >= knot_points(i-1) & x < knot_points(i);
        I(i-1) = struct('length', knot_points(i) - knot_points(i-1), ...
                        'numel', sum(points_ind), ...
                        'points', struct('x', x(points_ind), ...
                                         'y', y(points_ind)));
    end
    if ismember(knot_points(i), x) % take care of right end point
        I(i-1).numel = I(i-1).numel + 1;
        I(i-1).points(end + 1) = knot_points(i);
    end
end
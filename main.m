clc, clear

% load and sort data
data_file = 'data.txt';
points = read_data(data_file);
x = points(:,1);
y = points(:,2);

% x-values of knot points
knot_points = 0:4;

% break into intervals
intervals = get_intervals(x, y, knot_points);

% Get A and c
A = [];
c = [];
for i = 1:numel(intervals)
    I = intervals(i); % ith interval
    frac = (I.points.x - knot_points(i))/I.length; % see derivation
    A_partial = [zeros(I.numel, i-1), ...
                frac-1, -frac, ...
                zeros(I.numel,numel(knot_points)-2-i+1)]; % see derivation
    A = [A; A_partial];
    c = [c; I.points.y];
end

% design vector y = y-values of knot points
% obj fun: J(y) = (1/2)*y'* H * y + f'* y
H = 2 .* A' * A;
f = (2 * c' * A)';

[x_opt, J_eval] = quadprog(H, f);

x_opt
f = c'* c + J_eval % adding back the constant term that was 
                   % ignored in objective function formulation
                   
% ############ plot ############
figure;
hold on;
xlabel('$x$', 'Interpreter', 'Latex');
ylabel('$y$', 'Interpreter', 'Latex');

% plot points
plot(x, y, '.');

% plot best fit spline
plot(knot_points, x_opt);
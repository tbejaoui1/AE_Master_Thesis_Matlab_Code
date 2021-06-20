function body_plot(r_body, body_color , scaling)
% Function will plot the body we are interested in as a sphere located at
% the origin.

if nargin < 3
    scaling = 1;
end

%% Create the body we are located around (Magrathea called with billing info)
[x, y, z] = sphere(48);

% Scale sphere to planets actual size
x = r_body*scaling*x;
y = r_body*scaling*y;
z = r_body*scaling*z;

%% Define Body Centered Vectors
% Left column is direction right, column is magnitude
% X Vector
x_x = [1 r_body+r_body/4];
x_y = [0 0];
x_z = [0 0];

% Y Vector
y_x = [0 0];
y_y = [1 r_body+r_body/4];
y_z = [0 0];

% Z Vector
z_x = [0 0];
z_y = [0 0];
z_z = [1 r_body+r_body/4];

%% Plot System
hold on;
grid on;

% Graph the body we are centered around
surf(x, y, z,'facecolor',body_color,'tag','body');

% Plot reference frame vectors
plot3(x_x, x_y, x_z, '-r', 'LineWidth', 2, 'Tag', 'X axis');
xlabel('x')
plot3(y_x, y_y, y_z, '-g', 'LineWidth', 2, 'Tag', 'Y axis');
ylabel('y')
plot3(z_x, z_y, z_z, '-b', 'LineWidth', 2, 'Tag', 'Z axis');
zlabel('z')

% Sets initial view
view(50, 20)

% Defaults option for rotation on graph
rotate3d on;
axis equal;
end


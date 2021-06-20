function [ radius_c ] = orbit_convert(radius, elem)
%%Simple function to convert from orbit reference frame to body reference
%%frame

%% Sin and Cos terms
% Precomputing sin and cosine terms to make the rotation table easier to
% read. W = angle to line of nodes, i = incliniation angle, w = angle to line of
% apsis.

C_W = cos(elem(1));
C_i = cos(elem(2));
C_w = cos(elem(3));
S_W = sin(elem(1));
S_i = sin(elem(2));
S_w = sin(elem(3));

%% Conversion table
% Table for converting between particle centered reference frame and body
% centric reference frames.

convert = [C_W*C_w-S_W*C_i*S_w  -C_W*S_w-S_W*C_i*C_w  S_W*S_i
           S_W*C_w+C_W*C_i*S_w  -S_W*S_w+C_W*C_i*C_w  -C_W*S_i
           S_i*S_w              S_i*C_w               C_i];

%% Convert radius
% Actual conversion for the radius is done in this section. First line
% converts the X component of the particle centric frame into body centric
% frame. Second line converts Y components. Third line converts Z
% components.

    radius_c(:,1) = radius(:,1)*convert(1,1)+radius(:,2)*convert(1,2)+...
        radius(:,3)*convert(1,3);
    radius_c(:,2) = radius(:,1)*convert(2,1)+radius(:,2)*convert(2,2)+...
        radius(:,3)*convert(2,3);
    radius_c(:,3) = radius(:,1)*convert(3,1)+radius(:,2)*convert(3,2)+...
        radius(:,3)*convert(3,3);

end


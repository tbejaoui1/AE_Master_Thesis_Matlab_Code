function [R, mu, Rp, Ra, soi, rgb] = orbital_constants(body)
%orbital_constants 
% This function returns the radius, mass, radius of perihelion, radius of
% apohelion and color of each planet in the solar system.

% Universal gravitational constant for KM
G = 6.67*10^-20;

% Orbital information for each planet
Names = {'Sun','Mercury','Venus','Earth','Mars','Jupiter','Saturn','Uranus','Neptune','Pluto'};

indx = find(strcmpi(Names,body));

Radius = [695000; 2440; 6052; 6378; 3397; 71492; 60268; 25559; 24766; 1150];
Mass = [1.9885e30; 3.3011e23; 4.8675e24; 5.9723e24; 6.4171e23; 1.89819e27; 5.6834e26; 8.6813e25; 1.02413e26; 1.303e22];
Parahelion = [0; 46.0e6; 107.5e6; 147.1e6; 206.6e6; 740.5e6; 1352.6e6; 2741.3e6; 4444.5e6; 4436.8e6];
Apohelion = [0; 69.8e6; 108.9e6; 152.1e6; 249.2e6; 816.6e6; 1514.5e6; 3003.6e6;	4545.7e6; 7375.9e6];

% RGB values used when graphing planets
r = [1; 102/255; 204/255; 51/255; 1; 1; 1; 51/255; 51/255; 128/255];
g = [1; 51/255; 0; 51/255; 0; 102/255; 128/255; 1; 153/255; 128/255];
b = [0; 0; 102/255; 1; 0; 102/255; 0; 1; 1; 128/255];

% Collecting all data into formatted table
% t = table(Radius, Mass, Parahelion, Apohelion, Inclination, r, g, b, 'rownames', Names);

% Storing Radius, Mass, Parahelion, Apohelion, Color Codes, and mu for selected body
R = Radius(indx);
m = Mass(indx);
Rp = Parahelion(indx);
Ra = Apohelion(indx);
rgb = [r(indx), g(indx), b(indx)];
mu = G*m;
soi = .5*(Rp+Ra)*(m/Mass(1))^(2/5);
end


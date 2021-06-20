clc, clear all, close all;

%normalization constants used in Lambert solver
TU = 5.0226757e6;
DU = 1.4959965e8;   %position 1 and 2 are divided by it
VU = 29.784582;      %velocities 1 and 2 are divided by it
GU = 1.3271544e11;    % u = GM, is divided by it

TOFinDays = 5 * 365;  %subject to change; right now it's 5 years cuz the Cassini mission
                      %for Flyby 2 from Venus to Saturn took the same
                      %amount of time.
                      %June 24 1999 to July 1 2004

SecondsInDay = 60*60*24;
Mu = 1.9885e30 * 6.67*10^-20; %mass of sun (M_s) * gravitational constant (G)

TOF = TOFinDays * SecondsInDay;  %units in (total) seconds

%Introduce Offsets for propogator, so that s/c isn't at the center of mass
%of planet 
VenusOffset = [6500, 0, 0];  %(R + alt = r) where R = radius of Venus = 6051.84 +/- 0.01 km
SaturnOffset = [120000, 0, 0];           %(R + alt = r) where R = radisu of Saturn = 60268 +/- 4 km

%Ephimeredes data below retrieved from JPL
% Position of Venus on Jan 01 2022 at 00:00:00.000
Pos1 = [-1.015245425299603E+07,    1.071173286555189E+08,  2.056027826149240E+06] + VenusOffset;
% Position of Saturn on Jan 01 2027 00:00:00.000
Pos2 = [1.364440141772364E+09, 3.390839717138447E+08, -6.021867286262363E+07] + SaturnOffset;

%Lambert code that will give you the velocities at position 1 and position
%2 respectively ;  remember thst the Lambert Solver is focused on
%interplanetary travel.
temp = Lambert( Pos1, Pos2, TOF, 'Mu', Mu);

%temp = temp * VU ; b/c Lambert values can either be normalized or
%non-normalized. Depending on what values were inputted as the arguments of
%the Lambert function.

%Magnitudes of the pos1 and pos2 vectors:
mag_pos1 = sqrt(sum(Pos1.^2));
mag_pos2 = sqrt(sum(Pos2.^2));

%Magnitude of temp's (velocity's):
vel_1 = temp(1,:);
mag_vel_1= sqrt(sum(vel_1.^2))
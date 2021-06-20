function [ radius, para, time ] = orbit_calc( para, duration )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
% para(1) = radius of the body
% para(2) = altitude of periapsis
% para(3) = altitude of apoapsis
% para(4) = semi-major axis
% para(5) = eccentricity
% para(6) = G*m
% para(7) = velocity at periapsis
% para(8) = velocity at apoapsis
% para(9) = sphere of influence of body

if nargin < 2
    duration = 1;
end

if para(2) == 0 && para(3) == 0
    % Calculates perigee as an altitude for display purposes
    para(2) = (para(4)*(1-para(5)^2))/(1+para(5)) - para(1);
    % Calculates apogee as an altitude for display purposes
    para(3) = (para(4)*(1-para(5)^2))/(1-para(5)) - para(1);
    
elseif para(2) == 0 && para(4) == 0
    % Calculates perigee as a radius
    para(3) = para(3)+para(1);
    para(2) = (para(3))*((1-para(5))/(1+para(5)));
    % Calculates semi_major axis
    para(4) = .5*(para(2) + para(3));
    % Converts perigee back into an altitude for display purposes
    para(2) = para(2) - para(1);
    para(3) = para(3) - para(1);
    
elseif para(2) == 0 && para(5) == 0
    % Calculates perigee and apogee as a radius
    para(3) = para(3) + para(1);
    para(2) = 2*para(4) - para(3);
    % Calculates eccentricity
    para(5) = (para(3)-para(2))/(para(2) + para(3));
    % Converts perigee and apogee into altitude for display purposes
    para(2) = para(2) - para(1);
    para(3) = para(3) - para(1);
    
elseif para(3) == 0 && para(4) == 0
    % Calculates apogee as radius
    para(3) = (para(2)+para(1))*((1+para(5))/(1-para(5)));
    % Calculates semi-major axis
    para(4) = .5*((para(2) + para(1)) + para(3));
    % Converts apogee into altitude for display purposes
    para(3) = para(3) - para(1);
    
elseif para(3) == 0 && para(5) == 0
    % Calculates perigee and apogee as radius
    para(2) = para(2) + para(1);
    para(3) = 2*para(4) - para(2);
    % Calculates eccentricity
    para(5) = (para(3)-para(2))/(para(2) + para(3));
    % Converts apogee to altitude for display purposes
    para(2) = para(2) - para(1);
    para(3) = para(3) - para(1);
    
elseif para(4) == 0 && para(5) == 0
    % Calculate perigee and apogee as radius
    para(2) = para(1) + para(2);
    para(3) = para(1) + para(3);
    % Calculate semi-major axis
    para(4) = .5*(para(2) + para(3));
    % Calculate eccentricity
    para(5) = (para(3)-para(2))/(para(2) + para(3));
    
    % Converts perigee and apogee back into altitudes for display purposes
    para(2) = para(2) - para(1);
    para(3) = para(3) - para(1);
end

if para(5) ~= 1
    if para(5) < 1
        theta = 0:pi/250:2*pi*duration;
    elseif para(5) > 1
        theta_max = acos(((para(4)*(1-para(5)^2)/para(9))-1)/para(5));
        theta = -theta_max:theta_max*2/500:theta_max;
    end
    
    % Calculates radius as a scalar value
    radius_e = (para(4)*(1-para(5)^2))./(1+para(5)*cos(theta));
    
    % Converts scalar radius into x, y, and z components for graphing
    radius(:,1) = radius_e.*cos(theta);
    radius(:,2) = radius_e.*sin(theta);
    radius(:,3) = 0;
    
    % Calculates velocity at perigee and apogee
    para(7) = sqrt((2*para(6)/(para(2)+para(1)))-(para(6)/para(4)));
    para(8) = sqrt((2*para(6)/(para(3)+para(1)))-(para(6)/para(4)));
    
    % Calculates orbital period. Decomposes it in days, hours, minutes, and
    % seconds
    
    tau= (theta(end) - theta(1))*sqrt((para(4))^3/para(6));
    time(1) = fix(tau/(3600*24));
    tau = tau - (3600*24)*time(1);
    time(2) = fix(tau/3600);
    tau    = tau - 3600*time(2);
    time(3) = fix(tau/60);
    tau    = tau - 60*time(3);
    time(4) = tau;
    
else
    [radius, para, time] = parabolic(para, -2*pi/3:pi/250:2*pi/3);
end

end

function [radius, para,time] = parabolic(para, duration)

para(3) = 0;
para(4) = 2*para(2)+para(1);

% Calculates radius as a scalar value
radius_p = 2*(para(2)+para(1))./(1+cos(duration));

% Converts scalar radius into x, y, and z components for graphing
radius(:,1) = radius_p.*cos(duration);
radius(:,2) = radius_p.*sin(duration);
radius(:,3) = 0;

% Calculates velocity at perigee and apogee
para(7) = sqrt((2*para(6)/(para(2)+para(1)))-(para(6)/para(4)));
para(8) = sqrt((2*para(6)/(para(3)+para(1)))-(para(6)/para(4)));

% Calculates orbital period. Decomposes it in days, hours, minutes, and
% seconds

tau= (duration(end) - duration(1))*sqrt((para(4))^3/para(6));
time(1) = fix(tau/(3600*24));
tau = tau - (3600*24)*time(1);
time(2) = fix(tau/3600);
tau    = tau - 3600*time(2);
time(3) = fix(tau/60);
tau    = tau - 60*time(3);
time(4) = tau;
end
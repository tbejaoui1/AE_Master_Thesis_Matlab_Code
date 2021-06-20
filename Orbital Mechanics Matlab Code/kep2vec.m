function [r, v] = kep2vec( para, varargin )
%kep2vec Converts from keplerian elements to a position and velocity vector
%   Function requires the orbtial elements to function properly. Optional
%   parameters are true anomoly, keplerian angles, and what angles are
%   measured in. If no optionals are given function assumes satellite is at
%   periapses, orbit is in the plane of the eclipse with the periapsis
%   along the X direction of the planet centered frame, and angles are
%   measured in degrees.

p = inputParser;
defaultTheta = 0;
defaultAngles = [0,0,0];
defaultMeasure = 'rad';

addRequired(p,'OrbitParameters')
addOptional(p,'Theta',defaultTheta,@isnumeric)
addOptional(p,'Angles',defaultAngles,@isnumeric)
addOptional(p,'Angletype',defaultMeasure)

parse(p,para,varargin{:})

theta = p.Results.Theta;
kep = p.Results.Angles;
angletype = p.Results.Angletype;

if strcmp(angletype,'deg')
    theta = deg2rad(theta);
end

h = sqrt(para(4)*para(6)*(1-para(5)^2));

r = h^2/(para(6)*(1+para(5)*cos(theta)))*[cos(theta), sin(theta), 0];
v = (para(6)/h)*[-sin(theta), para(5) + cos(theta), 0];

if any(kep) 
    r = orbit_convert(r,kep);
    v = orbit_convert(v,kep);
end

end
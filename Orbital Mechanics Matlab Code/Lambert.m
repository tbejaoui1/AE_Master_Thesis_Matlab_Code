function [ v, varargout ] = Lambert( R1, R2, TOF, varargin )
%LAMBERT Summary of this function goes here
%   Detailed explanation goes here

p = inputParser;
defaultDirection = 'Prograde';
defaultTol = 1e-8;    %iterative default.
defaultMu = 398600.440;
defaultOutput = 0;

addRequired(p,'Position_1')
addRequired(p,'Position_2')
addRequired(p,'TOF')

addOptional(p,'Dir',defaultDirection)
addOptional(p,'Tol',defaultTol,@isnumeric)
addOptional(p,'Mu',defaultMu,@isnumeric)
addOptional(p,'IterOut',defaultOutput)

parse(p,R1, R2, TOF, varargin{:})
direction = p.Results.Dir;
tol = p.Results.Tol;
mu = p.Results.Mu;
output = p.Results.IterOut;

r1 = norm(R1);
r2 = norm(R2);

if strcmpi(direction, 'Prograde')
    Z = cross(R1, R2);
    if Z(3) >= 0
        delta_theta = acos(dot(R1,R2)/(norm(R1)*norm(R2)));
    else
        delta_theta = 2*pi - acos(dot(R1,R2)/(norm(R1)*norm(R2)));
    end
end

if strcmpi(direction, 'Retrograde')
    Z = cross(R1, R2);
    if Z(3) < 0
        delta_theta = acos(dot(R1,R2)/(norm(R1)*norm(R2)));
    else
        delta_theta = 2*pi - acos(dot(R1,R2)/(norm(R1)*norm(R2)));
    end
end

a = rad2deg(delta_theta);

A = sin(delta_theta)*sqrt(norm(R1)*norm(R2)/(1-cos(delta_theta)));

% z_eqn = @(z) z - CapF(r1,r2,A,mu,TOF,z)/CapFprime(r1,r2,A,z);
ratio = 1;
z = 0;
nmax = 500;
n = 1;

%solved via Newton's Method
if output
    while abs(ratio) > tol & n <= nmax
        ratio =  CapF(r1,r2,A,mu,TOF,z)/CapFprime(r1,r2,A,z);
        z = z - ratio;
        n = n + 1;
    end
%         z = converge(z_eqn,'tolerance',tol);
else
    while abs(ratio) > tol & n <= nmax
        ratio =  CapF(r1,r2,A,mu,TOF,z)/CapFprime(r1,r2,A,z);
        z = z - ratio;
        n = n + 1;
    end
    varargout{:} = n;
end

[f, g, fdot, gdot] = FandG(r1,r2,mu,A,z);

v(1,:) = 1/g*(R2 - f*R1);
v(2,:) = 1/g*(gdot*R2 - R1);

end


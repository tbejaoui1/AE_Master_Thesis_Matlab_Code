function [ f,g,fdot,gdot ] = FandG( r1,r2,mu,A,z )
%FANDG Summary of this function goes here
%   Detailed explanation goes here
f = 1 - yz(r1,r2,A,z)/r1;
g = A*sqrt(yz(r1,r2,A,z)/mu);
fdot = sqrt(mu)/(r1*r2)*sqrt(yz(r1,r2,A,z)/stumpC(z))*(z*stumpS(z)-1);
gdot = 1 - yz(r1,r2,A,z)/r2;

end


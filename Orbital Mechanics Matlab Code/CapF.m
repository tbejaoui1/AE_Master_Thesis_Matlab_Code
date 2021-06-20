function [ F ] = CapF( r1, r2, A, mu, TOF, z )
%CAPF Summary of this function goes here
%   Detailed explanation goes here
F = (yz(r1, r2, A, z)/stumpC(z))^(3/2)*stumpS(z)...
    + A*sqrt(yz(r1, r2, A, z))...
    - sqrt(mu)*TOF;
end


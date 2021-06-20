function [ f ] = CapFprime( r1, r2, A, z )
%CAPFPRIME Summary of this function goes here
%   Detailed explanation goes here

if z == 0
    f = sqrt(2)/40*yz(r1, r2, A, z)^1.5...
        +A/8*(sqrt(yz(r1, r2, A, z)) + A*sqrt(1/(2*yz(r1, r2, A, z))));
else
    f1 = (yz(r1,r2,A,z)/stumpC(z))^(3/2);
    f2 = 1/(2*z)*(stumpC(z) - (3/2)*stumpS(z)/stumpC(z)) + (3/4)*stumpS(z)^2/stumpC(z);
    f3 = A/8*(3*stumpS(z)/stumpC(z)*sqrt(yz(r1,r2,A,z)) + A*sqrt(stumpC(z)/yz(r1,r2,A,z)));
    f = f1*f2+f3;
end
end
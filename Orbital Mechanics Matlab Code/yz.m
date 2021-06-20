function [ y ] = yz( r1, r2, A, z )
%YZ Summary of this function goes here
%   Detailed explanation goes here

y = r1 + r2 + A*(z*stumpS(z) - 1)/sqrt(stumpC(z));

end


function [fd,gd] = fdotgdot(x, r, r0, alpha, mu)
%FDOTGDOT Summary of this function goes here
%   Detailed explanation goes here
z = alpha*x^2;

fd = (sqrt(mu)/r/r0)*(z*stumpS(z) - 1)*x;
gd = 1 - ((x^2/r)*stumpC(z));
end


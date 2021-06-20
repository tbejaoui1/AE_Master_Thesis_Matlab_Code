function [ x ] = keplerU( t, r0, vr, alpha, mu )
%KEPLERU Summary of this function goes here
%   Detailed explanation goes here

err = 1e-8;
nmax = 1000;

x = sqrt(mu)*abs(alpha)*t;

n = 0;
ratio = 1;

while(abs(ratio) > err && n < nmax)
   C = stumpC(alpha*x^2);
   S = stumpS(alpha*x^2);
   F = r0*vr/sqrt(mu)*x^2*C + (1 - alpha*r0)*x^3*S + r0*x - sqrt(mu)*t;
   dFdx = r0*vr / sqrt(mu)*x*(1 - alpha*x^2*S) + (1 - alpha*r0)*x^2*C + r0;
   ratio = F/dFdx;
   x = x - ratio;
   n = n + 1;
end

end


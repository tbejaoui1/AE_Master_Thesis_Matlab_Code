clear all;
body = 'Earth';
[r, mu, ~, ~, soi, rgb] = orbital_constants(body);

para(1) = r;
para(2) = 500;
para(5) = 1.5;
para(6) = mu;
para(9) = soi;

[radius, para, time] = orbit_calc(para, 1);


Mh = mu^2/(para(2)*para(7))^3*(para(6)^2 - 1)^1.5*t;
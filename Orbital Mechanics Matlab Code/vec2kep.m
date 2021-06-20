function [para, kep, theta] = vec2kep(R,V,para)
cx = [1,0,0];
cy = [0,1,0];
cz = [0,0,1];

r = norm(R);
v = norm(V);

H = cross(R,V);

h = norm(H);

i = acos(H(3)/h);

N = cross(cz,H);

n = norm(N);


if N(2) >= 0
    W = acos(N(1)/n);
else
    W = 2*pi - acos(N(1)/n);
end

Vr = dot(R,V)/r;
vec_e = 1/para(6)*((v^2-para(6)/r)*R-r*Vr*V);

e = norm(vec_e);
para(5) = e;

if vec_e(3) >= 0
    w = acos(dot(vec_e,N)/(n*e));
else
    w = 2*pi - acos(dot(vec_e,N)/(n*e));
end

if Vr >= 0
    theta = acos(dot(vec_e/e,R/r));
else
    theta = 2*pi - acos(dot(vec_e/e,R/r));
end

kep(1) = W;
kep(2) = i;
kep(3) = w;

para(2) = h^2/para(6)*(1/(1+e)) - para(1);

end
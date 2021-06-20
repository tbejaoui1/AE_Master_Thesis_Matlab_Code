function [ jdn ] = JDN( date, time )
%%JDN Julian Date Number Calculator
% Function returns the julian date number of any given gregorian date. It
% will also return the julian date with time if time is specified.

a = floor((14-date(1))/12);
y = date(3) + 4800 - a;
m = date(1) + 12*a - 3;

jdn = date(2) + floor((153*m+2)/5) + 365*y + floor(y/4) - floor(y/100) + floor(y/400) - 32045;

if nargin > 1
    jdn = jdn + (time(1)-12)/24 + time(2)/1440 + time(3)/86400;
end

end
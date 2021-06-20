function [ date, time ] = TAD( J )
%Time and Date from Julian Date
%   This function converts a given Julian Date into a Gregorian date and
%   time. Date output form is DD:MM:YYYY while time output is 24 hour
%   H:M:S.

intgr = floor(J);
frac = J - intgr;

greg = 2299161;

if(intgr >= greg)
    tmp = floor(((intgr - 1867216) - 0.25)/36524.25);
    j1 = intgr + 1 + tmp - floor(.25*tmp);
else
    j1 = intgr;
end

dayfrac = frac + 0.5;

if dayfrac >= 1.0
    dayfrac = dayfrac - 1;
    j1 = j1 + 1;
end

j2 = j1 + 1524;
j3 = floor( 6680.0 + ( (j2 - 2439870) - 122.1 )/365.25 );
j4 = floor(j3*365.25);
j5 = floor( (j2 - j4)/30.6001 );

d = floor(j2 - j4 - floor(j5*30.6001));
m = floor(j5 - 1);
if m > 12
    m = m - 12;
end
y = floor(j3 - 4715);

if m > 2
    y = y - 1;
end

if y <= 0
    y = y - 1;
end

hr = floor(dayfrac * 24.0);
min = floor((dayfrac*24.0 - hr)*60.0);
f = ((dayfrac*24.0 - hr)*60.0 - min)*60.0;
sec = f;
f = f - sec;

if f > 0.5
    sec = sec + 1;
end

if y < 0
    y = -y;
end

date = [m d y];
time = [hr min sec];
end


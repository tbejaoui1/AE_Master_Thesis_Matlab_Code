function [ val, n ] = converge( equation, varargin )
%CONVERGE Summary of this function goes here
%   Detailed explanation goes here

p = inputParser;
defaulttol = 0.002;
defaultval = 0;
defaultmax = 2000;
addRequired(p,'Equation')

addOptional(p,'Tolerance',defaulttol,@isnumeric)
addOptional(p,'Initialval',defaultval,@isnumeric)
addOptional(p,'Nmax',defaultmax,@isnumeric)

parse(p,equation,varargin{:})

tol = p.Results.Tolerance;
val = p.Results.Initialval;
nmax = p.Results.Nmax;

check_2 = 2000000;
change = 1;
n = 0;
val_temp = val;

while(change > tol)
    val = equation(val_temp);
    
    check_1 = abs(val_temp - val);
    change = abs(check_2-check_1);
    
    val_temp = val;
    check_2 = check_1;
    n = n+1;
    if n == nmax
%         disp('Equation Failed to Converge')
        break
    end
end
end


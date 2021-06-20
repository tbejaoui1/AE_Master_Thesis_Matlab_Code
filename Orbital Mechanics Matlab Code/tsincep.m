function [ varargout ] = tsincep( para, varargin )
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here

p = inputParser;
defaultOutput = 'theta';
defaultTime = 0;

addRequired(p,'OrbitParameters')
addOptional(p,'Time',defaultTime,@isnumeric)
addOptional(p,'Output',defaultOutput)

parse(p,para,varargin{:})

output = p.Results.Output;
t = p.Results.Time;

if strcmpi('theta',output)
%     disp('Calculating Theta')
    if para(5) == 0
%         disp('Orbit is circle')
        %circular trajectory goes here
            varargout{1} = 1;
    elseif para(5) < 1 && para(5) > 0
%         disp('Orbit is ellipse')
        Me = sqrt(para(6)/para(4)^3)*t;
        
        if Me < pi
            E = Me + para(6)/2;
        else
            E = Me - para(6)/2;
        end
        
        E_funct = @(E) E - (E - para(5)*sin(E) - Me)/(1-para(5)*cos(E));
        
        E = converge(E_funct,'initialval',E,'nmax',200);
        
        theta = 2*atan(sqrt((1+para(5))/(1-para(5)))*tan(E/2));
        
        if theta < 0
            theta = theta + 2*pi;
        end
        
        varargout{1} = theta;
        
    elseif para(5) == 1
%         disp('orbit is parabola')
        %parabolic trajectory to be defined here
        
    else
%         disp('orbit is hyperbola')
            varargout{1} = 1;
    end
    
elseif strcmpi('time',output)
%     disp('Calculating time')
    if para(6) == 0
        
    elseif para(6) < 1
        
    elseif para(6) == 1
        
    else
        
    end
    varargout{1} = 1;
end

end
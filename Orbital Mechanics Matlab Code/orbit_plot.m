function orbit_plot( para, radius, elem, linecolor, indicators, figure )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

%PlotComet_3D(radius(:,1),radius(:,2),radius(:,3),linecolor,'cFigure',figure,'Frequency',100,'blockSize',1500);
if isnumeric(linecolor)
    plot3(radius(:,1),radius(:,2),radius(:,3),'Color',linecolor);
else
    plot3(radius(:,1),radius(:,2),radius(:,3),linecolor);
end

if isnan(indicators)
    indicators = {'Off'};
end

if strcmpi(indicators,'On') == 1
    if elem(2) ~= 0
        
        node = zeros(3,2);
        
        node_r = (para(4)*(1-para(5)^2))/...
            (1+cosd(-elem(3))*para(5));
        
        node(1,2) = cosd(-elem(3))*node_r;
        node(2,2) = sind(-elem(3))*node_r;
        
        [node_c] = orbit_convert(node,elem);
        
        plot3(node_c(1,:),node_c(2,:),node_c(3,:),'o--','linewidth',2);
    elseif elem(2) == 0
        % Intentionally left blank
    end
    
    if para(3:5) == 0
        
    elseif any(para(3:5)) == 1
        
        apsis = zeros(3,2);
        apsis(1,2) = para(2) + para(1);
        [apsis_c] = orbit_convert(apsis,elem);
        
        plot3(apsis_c(1,:),apsis_c(2,:),apsis_c(3,:),'o--','linewidth',2);
    end
end

end


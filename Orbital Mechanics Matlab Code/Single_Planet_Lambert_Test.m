% clc, clear all, close all;

body = 'Earth';
[r_earth, mu, Rp, Ra, soi, rgb] = orbital_constants(body);

direction = 'Prograde';
R1 = [5000, 10000, 2100];
R2 = [-14600, 2500, 7000];
TOF = 3600;

indx = 1;
i = 1;
j = 1;
%%
for indx = 1:length(TOF)
    
    v(:,:,indx) = Lambert( R1, R2, TOF(indx), 'Mu', mu, 'Dir', direction);
    [temp_para, kep(:,indx), theta(indx)] = vec2kep(R1,v(1,:,indx),...
        [r_earth,0,0,0,0,mu,0,0,soi]);
    
    if  temp_para(2) + temp_para(1) > temp_para(1)+ 200
        [ radius(:,:,i), para(:,i), ~ ] = orbit_calc( temp_para, 1 );
        [ radius(:,:,i) ] = orbit_convert(radius(:,:,i), kep(:,i));
        i = i + 1;
    else
        failed_para(:,j) = temp_para;
        failed_indx(j) = indx;
        j = j + 1;
    end
    
end

%%
figure
hold on
body_plot(r_earth,rgb,1)
plot3([0, R1(1)],[0, R1(2)],[0, R1(3)],'--o')
plot3([0, R2(1)],[0, R2(2)],[0, R2(3)],'--o')

for k = 1:size(radius,3)
    plot3(radius(:,1,k),radius(:,2,k),radius(:,3,k));
end
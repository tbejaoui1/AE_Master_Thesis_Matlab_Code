clc; clear all; close all;
bodies = {'Sun','Mercury','Venus','Earth','Mars','Jupiter','Saturn','Uranus','Neptune','Pluto'};
%%
for i = 1:length(bodies)
    [R(i), mu(i), ~, ~, soi(i), rgb(:,i)] ...
        = orbital_constants(bodies(i));
end

%%
JDOP(1) = 2457924.050321586896;
JDOP(2) = 2457805.038111704867;
JDOP(3) = 2457755.279683722649;
JDOP(4) = 2457690.980648439843;
JDOP(5) = 2459966.104397584684;
JDOP(6) = 2452832.661497939844;
JDOP(7) = 2470240.434138776734;
JDOP(8) = 2469636.659370356705;
JDOP(9) = 2447739.561283383984;

au = 149597870.700;

e =[2.056334825911780E-01, 6.792062845755795E-03, 1.714851990818832E-02...
   ,9.352245905342947E-02, 4.881221394693038E-02, 5.188511037379428E-02...
   ,4.970365726433269E-02, 6.525657761855423E-03, 2.490422209877092E-01];
 
Rp=[3.074978991199890E-01, 7.184133645075793E-01, 9.822157956706926E-01...
   ,1.381116758099809E+00, 4.948696974868465E+00, 9.072837666051521E+00...
   ,1.817814806391239E+01, 2.981764839921535E+01, 2.961061709423084E+01]*au;
 
Ra=[4.666986269950076E-01, 7.282391190921577E-01, 1.016490652996282E+00...
   ,1.666099958726084E+00, 5.456602688204296E+00, 1.006585062019296E+01...
   ,2.007970319032271E+01, 3.020936413950967E+01, 4.925032002310400E+01]*au;

a =[3.870982630574983E-01, 7.233262417998685E-01, 9.993532243334874E-01...
   ,1.523608358412947E+00, 5.202649831536380E+00, 9.569344143122244E+00...
   ,1.912892562711755E+01, 3.001350626936251E+01, 3.943046855866741E+01]*au;

R_sys = R(1)*ones(1,length(bodies)-1);
mu_sys = mu(1)*ones(1,length(bodies)-1);
vel = zeros(1,length(bodies)-1);
soi_sys = soi(1)*ones(1,length(bodies)-1);

orbit_info = [R_sys; Rp; Ra; a; e; mu_sys; vel; vel; soi_sys];

angles(1,:) = [4.830876980776888E+01, 7.003938947692758E+00, 2.917548080762229E+01];
angles(2,:) = [7.662885183255511E+01, 3.394478246051527E+00, 5.474622873631213E+01];
angles(3,:) = [1.548325104007937E+02, 2.249782696271282E-03, 3.064192657301351E+02];
angles(4,:) = [4.950697575848289E+01, 1.848365526083020E+00, 2.866266157852055E+02];
angles(5,:) = [1.005206636876966E+02, 1.303694646952005E+00, 2.736044990992327E+02];
angles(6,:) = [1.135539510435246E+02, 2.489687340504860E+00, 3.402519718161896E+02];
angles(7,:) = [7.407711066567646E+01, 7.707953778125385E-01, 9.906502307855460E+01];
angles(8,:) = [1.317415980658247E+02, 1.768143128971546E+00, 2.813201248157484E+02];
angles(9,:) = [1.103294941633621E+02, 1.692395634631051E+01, 1.132782521326169E+02];

angles = deg2rad(angles);

date_start = [6, 6, 2000];
time_start = [0, 0, 0];

JDN_start = JDN(date_start,time_start);

date_end = [6, 6, 2020];
time_end = [0, 0, 0];

JDN_end = JDN(date_end, time_end);

% JDN_dif = JDN_end - JDN_start

TSP = (JDOP - JDN_start)*86400;

JDN_current = JDN_start;
time_current = time_start;
date_current = date_start;

%%
hold on
body_plot(R(1),rgb(:,1),1)
for i = 1:length(bodies)-1
    intial_theta(i) = tsincep( orbit_info(:,i),'Time',TSP(i));
    radius = orbit_convert(orbit_calc(orbit_info(:,i), 1),angles(i,:));
    orbit_plot( orbit_info(:,i), radius, angles(i,:), rgb(:,i+1), 'Off', 1 );
end

quit = false;

h = gcf;
t = TSP;

rate = 1/60;
tstep = 10*86400;
%%
while(~quit && JDN_current <= JDN_end)
    if strcmp(get(h,'currentcharacter'),'q')
        
        quit = true;
        clc
        
    else
        tic
        if logical(exist('planet','var'))
            delete(planet);
        end
        for i = 1:length(bodies)-1
            
            theta = tsincep( orbit_info(:,i),'Time',t(i));
            pos(i,:) = kep2vec(orbit_info(:,i),'theta',theta,'angles',angles(i,:));
            planet(i) = plot3(pos(i,1),pos(i,2),pos(i,3),'ko');
            
        end
        
        pause(rate-toc);

        t = t + tstep*rate;
        time_current(3) = time_current(3) + tstep*rate;
        JDN_current = JDN(date_current, time_current);
        [date_current, time_current] = TAD(JDN_current);
    end
end
clc; clear all;% close all;
%% General Description and Use
%accepts state vectors

%% Simulation Setup
% These are the only variables that you need to change for the simulation.

%% Initial and Final Orbit information
% section defines initial and final orbit parameters.
% Body(1) is the body the satellite is in orbit around initially.
% Body(2) is the target body.

Body{1} = 'Earth';
orbit.pe(1) = 500;
orbit.ap(1) = 500;
orbit.e(1)  = 0;
orbit.a(1)  = 0;

orbit.W(1)  = 0;
orbit.i(1)  = 0;
orbit.w(1)  = 0;

Body{2} = 'Mars';
orbit.pe(2) = 500;
orbit.ap(2) = 500;
orbit.e(2)  = 0;
orbit.a(2)  = 0;

orbit.W(2) = 0;
orbit.i(2) = 0;
orbit.w(2) = 0;

%% Simulation Start and End Date
% The start and end date that the simulation will run for is specified in
% this section. Date is given as mm,dd,yyy and time is given as h,m,s.
% One thing to note is that noon is 0,0,0 for time. This is because
% of the way julian date number is calculated.
time.dstart = [6, 5, 2015];
time.tstart = [12, 0, 0];

time.dend = [6,4,2030];
time.tend = [12, 0, 0];

% tstep is the time, in seconds, the simulation moves the launch date
% forward with each step.
time.tstep = 86400;

%% Time of Flight
% Time of flight for the transfer trajectory is defined here.
% TOFstart is the lower bound for the time of flight for the transfer.
% TOFend is the upper bound for the transfer.
% TOFstep is the amount of time time of flight is incremented.
time.TOFstart = 86400*60; %5.256e+6;
time.TOFend = 86400*240; %2.102e+7;
time.TOFstep = 86400;

%% End of Simulation Setup

%% Planetary Information Collection
% Collects the Radius, mu, sphere of influence and the color for each body.
bodies = {'Sun','Mercury','Venus','Earth','Mars','Jupiter','Saturn'...
    ,'Uranus','Neptune','Pluto'};

for i = 1:length(bodies)
    [R(i), mu(i), ~, ~, soi(i), rgb(:,i)] = orbital_constants(bodies(i));
end

%% Initial Orbit Positions
% All data is pulled from the NASA JPL HORIZONS system. Data is for june
% 6th, 2017 at midnight. Given data is the Julian Date of Periapsis, the
% eccentricity, radius of periapsis, radius of apoapsis, and semi-major
% axis.

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

sysdata.ecc = ...
    [2.056334825911780E-01, 6.792062845755795E-03, 1.714851990818832E-02...
    ,9.352245905342947E-02, 4.881221394693038E-02, 5.188511037379428E-02...
    ,4.970365726433269E-02, 6.525657761855423E-03, 2.490422209877092E-01];

sysdata.Rp = ...
    [3.074978991199890E-01, 7.184133645075793E-01, 9.822157956706926E-01...
    ,1.381116758099809E+00, 4.948696974868465E+00, 9.072837666051521E+00...
    ,1.817814806391239E+01, 2.981764839921535E+01, 2.961061709423084E+01]*au;

sysdata.Ra = ...
    [4.666986269950076E-01, 7.282391190921577E-01, 1.016490652996282E+00...
    ,1.666099958726084E+00, 5.456602688204296E+00, 1.006585062019296E+01...
    ,2.007970319032271E+01, 3.020936413950967E+01, 4.925032002310400E+01]*au;

sysdata.semi = ...
    [3.870982630574983E-01, 7.233262417998685E-01, 9.993532243334874E-01...
    ,1.523608358412947E+00, 5.202649831536380E+00, 9.569344143122244E+00...
    ,1.912892562711755E+01, 3.001350626936251E+01, 3.943046855866741E+01]*au;

sysdata.R_sys = R(1)*ones(1,length(bodies)-1);
sysdata.mu_sys = mu(1)*ones(1,length(bodies)-1);
sysdata.vel = zeros(1,length(bodies)-1);
sysdata.soi_sys = soi(1)*ones(1,length(bodies)-1);

orbit_info = [sysdata.R_sys; sysdata.Rp; sysdata.Ra; sysdata.semi;...
    sysdata.ecc; sysdata.mu_sys; sysdata.vel; sysdata.vel; sysdata.soi_sys];

%% Orbit Angles
% Keplerian angles are given here. Angle order is Right Ascension of the
% Ascending Node, Inclination, and Argument of Perigee. Given in degrees.

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

%% Planetary Info of Selected Bodies
% This section gathers all data about the bodies of interest into a single
% location for use in calculations.

indx = find(ismember(bodies,Body))-1;
% -1 because bodies includes sun while sysdata information does not.
for i = 1:length(Body)
    planet.para(:,i) = [R(1), sysdata.Rp(indx(i)), sysdata.Ra(indx(i)),...
        sysdata.semi(indx(i)), sysdata.ecc(indx(i)), mu(indx(i)), 0, 0,...
        soi(indx(i))];
end

%% Time and Date
% Converts given time and date to Julian Date Number. Used in calculating
% the position of the planets on the given date. Also sets up the time of
% flight matrix.

time.JDNstart = JDN(time.dstart,time.tstart);
time.JDNend = JDN(time.dend, time.tend);
TSP = (JDOP - time.JDNstart)*86400;
launch_date = time.JDNstart:time.tstep/86400:time.JDNend;
t = TSP;

% This is the counter to ensure that the simulation ends on the specified
% end time and date.
time.JDNcurrent = time.JDNstart;
time.tcurrent = time.tstart;
time.dcurrent = time.dstart;

if time.TOFstart > time.TOFend
    disp('TOFstart must be smaller than TOFend')
else
    time.TOF = time.TOFstart:time.TOFstep:time.TOFend;
end

%% All the Calulations
% The position of the two specified bodies are calculated in this
% section. The postions of the body the craft starts at is calculated for
% each launch date, while the position for the secondary body is calculated
% for each launch date as well as each time of flight. The velocities are
% also calculated in this section.
direction = 'Prograde';

for i = 1:length(indx)
    planet.initial_theta(i) = tsincep(orbit_info(:,indx(i)),'Time',TSP(indx(i)));
    [planet.initial_pos(1,:,i),planet.initial_vel(1,:,i)] = kep2vec(orbit_info(:,indx(i)),'theta',planet.initial_theta(i),'angles',angles(indx(i),:));
    planet.orbit_path = orbit_convert(orbit_calc(orbit_info(:,indx(i)), 1),angles(indx(i),:));
end

planet.theta1 = zeros(length(launch_date));
planet.theta2 = zeros(length(time.TOF),length(launch_date));

planet.pos1 = zeros(length(launch_date),3);
planet.pos2 = zeros(length(launch_date),3,length(time.TOF));

planet.vel1 = zeros(length(launch_date),3);
planet.vel2 = zeros(length(launch_date),3,length(time.TOF));

transfer.v1 = zeros(length(launch_date), 3, length(time.TOF));
transfer.v2 = zeros(length(launch_date), 3, length(time.TOF));

transfer.dv1 = zeros(length(launch_date), 3, length(time.TOF));
transfer.dv2 = zeros(length(launch_date), 3, length(time.TOF));

transfer.dvmag1 = zeros(length(launch_date), length(time.TOF));
transfer.dvmag2 = zeros(length(launch_date), length(time.TOF));
transfer.dvmagtot = zeros(length(launch_date), length(time.TOF));

vstart = sqrt(mu(indx(1))/orbit.pe(1));

TU = 5.0226757e6;
DU = 1.4959965e8;
VU = 29.784582;
GU = 1.3271544e11;

%%
for i = 1:length(launch_date)
    [planet.pos1(i,:),planet.vel1(i,:)] = rvfromr0v0( planet.initial_pos(1,:,1),planet.initial_vel(1,:,1), TSP(1)+time.tstep*(i-1), mu(1) );
%     planet.theta1(i) = tsincep(orbit_info(:,indx(1)),'Time',TSP(1)+time.tstep*(i-1));
%     [planet.pos1(i,:),planet.vel1(i,:)] = kep2vec(orbit_info(:,indx(1)),'theta',planet.theta1(i),'angles',angles(1,:));
    
    for j = 1:length(time.TOF)
%         planet.theta2(j,i) = tsincep(orbit_info(:,indx(2)),'Time',TSP(2) + time.tstep*(j-1));
%         [planet.pos2(i,:,j), planet.vel2(i,:,j)] = kep2vec(orbit_info(:,indx(2)),'theta',planet.theta2(j,i),'angles',angles(2,:));
        [planet.pos2(i,:,j), planet.vel2(i,:,j)] = rvfromr0v0(planet.initial_pos(1,:,2),planet.initial_vel(1,:,2), TSP(2) + time.tstep*(j-1), mu(1) );
        temp = Lambert( planet.pos1(i,:)/DU, planet.pos2(i,:,j)/DU, time.TOF(j)/TU, 'Mu', mu(1)/GU, 'Dir', direction);
        
        if ~isnan(temp) & isreal(temp) & norm(temp(1,:)) < 2.5 & norm(temp(2,:)) < 2.5
            transfer.v1(i,:,j) = temp(1,:);
            transfer.v2(i,:,j) = temp(2,:);
            
            % transfer.vmag1(j,i) = real(norm(transfer.v1(1,:,j,i)));
            % transfer.vmag2(j,2,i) = real(norm(transfer.v(2,:,j,i)));
            
            transfer.dv1(i,:,j) = transfer.v1(i,:,j) - planet.vel1(i,:)/VU;
            transfer.dv2(i,:,j) = transfer.v2(i,:,j) - planet.vel2(i,:,j)/VU;
            
            transfer.dvmag1(i,j) = norm(transfer.dv1(i,:,j));
            transfer.dvmag2(i,j) = norm(transfer.dv2(i,:,j));
            transfer.dvmagtot(i,j) = transfer.dvmag1(i,j) + transfer.dvmag2(i,j);
%         else
%             transfer.v1(i,:,j) = 0;
%             transfer.v2(i,:,j) = 0;
%             
%             % transfer.vmag1(j,i) = real(norm(transfer.v1(1,:,j,i)));
%             % transfer.vmag2(j,2,i) = real(norm(transfer.v(2,:,j,i)));
%             
%             transfer.dv1(i,:,j) = 0;
%             transfer.dv2(i,:,j) = 0;
%             
%             transfer.dvmag1(i,j) = 0;
%             transfer.dvmag2(i,j) = 0;
%             transfer.dvmagtot(i,j) = 0;
        end
        
        %         if j == length(time.TOF)
        %             t(2) = TSP(2) + time.tstep*i;
        %         else
        %             t(2) = t(2) + time.TOFstep;
        %         end
    end
end

%%
% transfer.vmag(transfer.vmag(:,:,:) > .5e2) = 0;
% transfer.dv(transfer.dv(:,:,:) > .5e2) = 0;

[dvmin, minindx] = min(transfer.dvmagtot(transfer.dvmagtot ~= 0)*VU);
[min_row,min_column] = ind2sub(size(transfer.dvmagtot),minindx);
TOF_min = time.TOF(min_column);
[ld_min,lt_min] = TAD(launch_date(min_row));

[dvmax, maxindx] = max(transfer.dvmagtot(transfer.dvmagtot < 10)*VU);
[max_row,max_column] = ind2sub(size(transfer.dvmagtot),maxindx);
TOF_max = time.TOF(max_column);
[ld_max,lt_max] = TAD(launch_date(max_row));

transfer.dvmagtot(transfer.dvmagtot>5) = 5;
%%
figure
meshc(launch_date,time.TOF,transfer.dvmag1');
figure
meshc(launch_date,time.TOF,transfer.dvmag2');
figure
meshc(launch_date,time.TOF,transfer.dvmagtot');
%%
vstart = sqrt(mu(indx(1))/(orbit.pe(1)+R(indx(1)+1)));
i = min_row;
j = min_column;
theta_min = acosd(dot(planet.pos1(i,:), planet.pos2(i,:,j))/(norm(planet.pos1(i,:))*norm(planet.pos2(i,:,j))));
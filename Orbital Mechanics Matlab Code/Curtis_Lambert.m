direction = 'Prograde';
R1 = [5000 10000 2100];
R2 = [-14600 2500 7000];

TOF = 3600;

if strcmp(direction, 'Prograde')
    Z = cross(R1, R2);
    if Z(3) >= 0
        delta_theta = acos(dot(R1,R2)/(norm(R1)*norm(R2)));
    else
        delta_theta = 2*pi - acos(dot(R1,R2)/(norm(R1)*norm(R2)));
    end
end

if strcmp(direction, 'Retrograde')
    Z = cross(R1, R2);
    if Z(3) < 0
        delta_theta = acos(dot(R1,R2)/(norm(R1)*norm(R2)));
    else
        delta_theta = 2*pi - acos(dot(R1,R2)/(norm(R1)*norm(R2)));
    end
end

A = sin(delta_theta)*sqrt(norm(R1)*norm(R2)/(1-cos(delta_theta)));
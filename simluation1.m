%delcaring the simluation
function  Ninfected=simluation1(N,v,T)

%getting intial postion on the gird of individauls using a random function
x = rand(N,1)*2-1;
y = rand(N,1)*2-1;
infected = zeros(N,1);
infected(1) = 1;

%getting the direction of travel of individual
angle = 2*pi*rand(N,1);

%vector properties
vx = v*cos(angle);
vy = v*sin(angle);

 %boundaries at +1 and -1 in x and y direction
%delcaring the threshold

threshold = 0.1;

for t = 1:T
    %plotting the gird at each time to get a visual representation of
    %movemnt of indivial in the gird
    figure(1); clf; hold on
    plot(x(infected==0), y(infected==0), 'b.', 'markersize', 50)
    plot(x(infected==1), y(infected==1), 'r.', 'markersize', 50)
    xlim([-1.1 1.1])
    ylim([-1.1 1.1]);
    
    pause(0.1);
    %determing the corrdinates of each individual in plane at each frame
    x = x + vx;
    y = y + vy;
    
    % has it crossed a boundary and if the individaul goes out of boundary
    for i = 1:N
        if (x(i) > +1) % cross right hand boundary
            x(i) = x(i) - 2;
        end
        if (x(i) < -1) % cross left hand boundary
            x(i) = x(i) + 2 ;
        end
        if (y(i) > +1) % cross right hand boundary
            y(i) = y(i) - 2;
        end
        if (y(i) < -1) % cross right hand boundary
            y(i) = y(i) + 2;
        end
    
        %if the individual goes out the boundary giving them new direction
        if rand < 0.05
            angle = 2*pi*rand;
            vx(i) = v*cos(angle);
            vy(i) = v*sin(angle);
            
        end
    end
    
    % detect collisions 
    for i = 1:N
        for j = 1:N
            if i ~=j
                d = sqrt((x(i) - x(j)).^2 + (y(i) - y(j)).^2);
                %evaluating if the distance is under the thresold
                if d < threshold
                     % if collided with an infected individual
                     if infected(i) == 1
                         infected(j) = 1;
                     end
                     if infected(j) == 1;
                         infected(i) = 1;
                     end
                     
                end
                
            end
            
            
        end
    end
    % at each point in time getting the number if infected individuals in a
    % array
    Ninfected(t) = sum(infected);
end
end


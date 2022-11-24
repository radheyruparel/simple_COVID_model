%delcaring the simluation
function Ninfected=simlulation2(ratio_SD,v,v_SD,N,T)
%getting intial postion on the gird of individauls using a random function
x = rand(N,1)*2-1;
y = rand(N,1)*2-1;
%getting intial postion on the gird of individauls which are socail
%distancing
x_SD = rand(N,1)*2-1;
y_SD = rand(N,1)*2-1;
infected = zeros(N,1);
infected(1) = 1;

%getting the direction of travel of individual
angle = 2*pi*rand(N,1);

vx = v*cos(angle);
vy = v*sin(angle);

%getting the direction of travel of individual
v_SDx_SD = v_SD*cos(angle);
v_SDy_SD = v_SD*sin(angle);

% boundaries at +1 and -1 in x and y direction

T = 100;

threshold = 0.1;

for t = 1:T
     %plotting the gird at each time to get a visual representation of
    %movemnt of indivials and social distance individuals in the gird
    figure(1); clf; hold on
    plot(x(infected==0), y(infected==0), 'b.', 'markersize', 50)
    plot(x(infected==1), y(infected==1), 'r.', 'markersize', 50)
    plot(x_SD(infected==0), y_SD(infected==0), 'b.', 'markersize', 50)
    plot(x_SD(infected==1), y_SD(infected==1), 'r.', 'markersize', 50)
    xlim([-1.1 1.1])
    ylim([-1.1 1.1]);
    
    pause(0.1);

    %determing the corrdinates of each individual in plane at each frame
    x = x + vx;
    y = y + vy;
    x_SD = x_SD + v_SDx_SD;
    y_SD = y_SD + v_SDy_SD;
    
     % has it crossed a boundary and if the individaul goes out of boundary
    for i = 1:(N*v_SD)
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
            vy(i) = v*(angle);
            
        end
    end
    % has it crossed a boundary and if the socail distance individaul goes out of boundary

    for i = 1:(N*(1-v_SD))
        if (x_SD(i) > +1) % cross right hand boundary
            x_SD(i) = x_SD(i) - 2;
        end
        if (x_SD(i) < -1) % cross left hand boundary
            x_SD(i) = x_SD(i) + 2 ;
        end
        if (y_SD(i) > +1) % cross right hand boundary
            y_SD(i) = y_SD(i) - 2;
        end
        if (y_SD(i) < -1) % cross right hand boundary
            y_SD(i) = y_SD(i) + 2;
        end
    
         %if the social distancing individual goes out the boundary giving them new direction
        if rand < 0.05
            angle = 2*pi*rand;
            v_SDx_SD(i) = v_SD*cos(angle);
            v_SDy_SD(i) = v_SD*(angle);
            
        end
    end
        % detect collisions 
        for i = 1:N
        for j = 1:N
            if i ~=j
                d = sqrt((x(i) - x(j)).^2 + (y(i) - y(j)).^2);
                d_SD_N = sqrt((x(i) - x_SD(j)).^2 + (y(i) - y_SD(j)).^2);
                d_SD = sqrt((x_SD(i) - x_SD(j)).^2 + (y_SD(i) - y_SD(j)).^2);
                %evaluating if the distance is under the thresold
                if d < threshold || d_SD_N < threshold || d_SD  < threshold
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

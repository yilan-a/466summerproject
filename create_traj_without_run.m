function [x,orientation] = create_traj_without_run(condition_id,t,probability,mean_velocity)
% This function creates one trajectory based on the probability(without run) 
% and mean velocity.
% Inputs: condition_id: 1-7 respectively for ('10n1GA','10n2GA','10n3GA',
%         '10n5EA','10n5EA sucrose','H2O','H2O sucrose')
%         t: simulating time (s)
%         probability: withour run: [turn1:(-45,45]  turn2:(45,135]  
%                       turn3:(-180,-135]&(135,180]  turn4:(-135,-45]]
%         mean_velocity: mean velocity for each condition
% Outputs: x: simulated x coordinate
%          orientation: simulated orientation

%% Initilization

prob=cumsum(probability')'; % accumulated probability

orientation=zeros(1,t);
x=zeros(1,t);

% random initial value
orientation(1)=randi([-180 180]);
% x(1)=randi([0 200]);
temp=rand();
if temp<0.5
    x(1)=99.5*rand();
else
    x(1)=110+90*rand();
    
end


%% Simulation

for i=2:t

    temp=rand();% random 0-1
    if temp<probability(condition_id,1)
        % orientation 1: (-45,45]
        orientation(i)=90*(rand()-1/2); % randomly selected between (-45,45)
        x(i)=x(i-1)-mean_velocity(condition_id)*cos(orientation(i)/180*pi);
        
    elseif temp>=prob(condition_id,1) && temp<prob(condition_id,2)
        % orientation 2: (45,135]
        orientation(i)=45+90*rand();
        x(i)=x(i-1)-mean_velocity(condition_id)*cos(orientation(i)/180*pi);
        
    elseif temp>=prob(condition_id,2) && temp<prob(condition_id,3)
        % orientation 3: (-180,-135]&(135,180]
        orientation(i)=135+90*rand();
        if orientation(i)>180
            orientation(i)=orientation(i)-360;
        end
        x(i)=x(i-1)-mean_velocity(condition_id)*cos(orientation(i)/180*pi);
        
    else
        % orientation 4: (-135,-45]
        orientation(i)=-135+90*rand();
        x(i)=x(i-1)-mean_velocity(condition_id)*cos(orientation(i)/180*pi);
        
    end
    
    if x(i)<0
        x(i)=0;
    end
    
    if x(i)>200
        x(i)=200;
    end
    
end

% plot(x)


end




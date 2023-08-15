clc;clear;

%% Load data

load('probability.mat')
load('probability_without_run.mat')
load('mean_velocity.mat')

%% Initialization

num=6000; % amount of objects simulated for each condition
t=900; % simulated time (s)

x_total=cell(1,7); % x coordinate
A_total=cell(1,7); % object number of area A
B_total=A_total; % object number of area B

PI=zeros(7,t); % preferential index

%% Simulation and PI calculation

for i=1:7
   x=zeros(num,t);
   
   for j=1:num
       [x(j,:),temp]=create_traj(i,t,probability,mean_velocity); % create trajectories
       [x(j,:),temp]=create_traj_without_run(i,t,probability,mean_velocity);
   end
    
    x_total{i}=x;
    
    n_A=zeros(num,t);
    n_B=n_A;
    for j=1:t
        
        for k=1:num
            if x(k,j)<=99.5
                n_B(k,j)=1; % if in area B, set n_B as 1
            elseif (99.5<x(k,j))&&(x(k,j)<=110)
                % skip
            else
                n_A(k,j)=1; % if in area A, set n_A as 1
            end
            
        end
    end
    
    num_A=sum(n_A); % calculate total amount for each second
    num_B=sum(n_B);

    A_total{i}=num_A;
    B_total{i}=num_B;
    
    PI(i,:)=(num_A-num_B)./(num_A+num_B); % calculate PI
    
end

%% Plot

% figure
% for i=1:7
%     plot(PI(i,:),'Linewidth',1.5);
%     hold on;
%     
% end


figure
plot(PI(1,:),'Linewidth',1.5,'Color',[1 0 0]);
hold on;
plot(PI(2,:),'Linewidth',1.5,'Color',[0.24 0.35 0.67]);
hold on;
plot(PI(3,:),'Linewidth',1.5,'Color',[0 1 1]);
hold on;
plot(PI(4,:),'Linewidth',1.5,'Color',[0.10 0.5 0.08]);
hold on;
plot(PI(5,:),'Linewidth',1.5,'Color',[0 1 0]);
hold on;
plot(PI(6,:),'Linewidth',1.5,'Color',[1 0.84 0]);
hold on;
plot(PI(7,:),'Linewidth',1.5,'Color',[1 0.5 0]);
hold on;




legend('10n1GA','10n2GA','10n3GA','10n5EA','10n5EA sucrose','H2O','H2O sucrose');

% % 设置表头，坐标和图例
Title=title(['Preferential Index without run']);
Xlabel=xlabel('Time/s');
Ylabel=ylabel('PI');
% 坐标轴美化
set(gca, 'Box', 'on', ...
    'XGrid', 'on', 'YGrid', 'on', ...
    'TickDir', 'out', 'TickLength', [.015 .015], ...
    'XMinorTick', 'off', 'YMinorTick', 'off', ...
    'XColor', [.1 .1 .1],  'YColor', [.1 .1 .1])
% 字体和字号
set(gca, 'FontName', 'Helvetica')
set([Xlabel, Ylabel], 'FontName', 'AvantGarde')
set(gca, 'FontSize', 10)
set([Xlabel, Ylabel], 'FontSize', 11)
set(Title, 'FontSize', 11, 'FontWeight' , 'bold')
% 背景颜色
set(gcf,'Color',[1 1 1])




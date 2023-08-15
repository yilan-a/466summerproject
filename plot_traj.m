clc;clear;

%% Load data
load('probability.mat')
%load('probability_without_run.mat')
load('mean_velocity.mat')

t=900;
condition_id=1; 


%% plot 1 trajectory (x vs t, orientation vs t)

[x,orientation]=create_traj(condition_id,t,probability,mean_velocity); % create trajectories
% [x,orientation]=create_traj_without_run(condition_id,t,probability,mean_velocity); % create trajectories

% x vs t
figure
plot(x,'Linewidth',1);
Title=title(['Created Trajectory']);
Xlabel=xlabel('Time/s');
Ylabel=ylabel('X Value');
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

% orientation vs t
figure
plot(orientation,'Linewidth',0.8);
Title=title(['Created Trajectory']);
Xlabel=xlabel('Time/s');
Ylabel=ylabel('Orientation');
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


%% plot more trajectories (x vs t, orientation vs t)

num=3;% plot 3 trajectories
x1=zeros(num,t);
orientation1=x1;

for i=1:num 
    
    [x1(i,:),orientation1(i,:)]=create_traj(condition_id,t,probability,mean_velocity); % create trajectories
    % [x1(i,:),orientation1(i,:)]=create_traj_without_run(condition_id,t,probability,mean_velocity); % create trajectories
    
end

% x vs t
figure
for i=1:num

    plot(x1(i,:),'Linewidth',1);
    hold on;
       
end

Title=title(['Created Trajectory']);
Xlabel=xlabel('Time/s');
Ylabel=ylabel('X Value');
legend('Traj 1','Traj 2','Traj 3')
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

% orientation vs t
figure
for i=1:num

    plot(orientation1(i,:),'Linewidth',1);
    hold on;
       
end

Title=title(['Created Trajectory']);
Xlabel=xlabel('Time/s');
Ylabel=ylabel('Orientation');
legend('Traj 1','Traj 2','Traj 3')
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




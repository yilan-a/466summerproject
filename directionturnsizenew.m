clc;clear;

%% Initialization

data=cell(1,7);
turn_size=zeros(7,4); % turning size(set the interval as 90, 
                      % so there are 4 intervals between -180~180)
head_dir=1:4; % heading direction

orien_min=[-45 45 135 -135];
orien_max=[45 135 -135 -45];


%% Load data

load('10n1GA.mat');
data{1}=dat;
load('10n2GA.mat');
data{2}=dat;
load('10n3GA.mat');
data{3}=dat;
load('10n5EA.mat');
data{4}=dat;
load('10n5EA_sucrose.mat');
data{5}=dat;
load('H2O.mat');
data{6}=dat;
load('H2O_sucrose.mat');
data{7}=dat;

%% Calculate velocity and PI

for i=1:7
    
    data_table=data{i};
    turn_num=zeros(1,4); % number of turnings
    total_reorient=zeros(1,4); % total time of turnings   
    
    for j=1:height(data_table)
    %for j=1:2
        predeg=cell2mat(table2array(data_table(j,18)));
        x=cell2mat(table2array(data_table(j,5)));
        t0idx=cell2mat(table2array(data_table(j,11)));
        x_predeg=x(t0idx);
        
        reorient=cell2mat(table2array(data_table(j,22)));
        
        for k=1:4
            
            for k1=1:length(predeg)
                if k==3
                    if (orien_min(k)<predeg(k1))||(predeg(k1)<=orien_max(k))&&(x_predeg(k1)>110)
                        turn_num(k)=turn_num(k)+1; % calculating turning number
                        total_reorient(k)=total_reorient(k)+reorient(k1);
                    end
                    
                else
                    if (orien_min(k)<predeg(k1))&&(predeg(k1)<=orien_max(k))&&(x_predeg(k1)>110)
                        turn_num(k)=turn_num(k)+1; % calculating turning number
                        total_reorient(k)=total_reorient(k)+reorient(k1);
                    end
                end
                
            end          
                
            
        end
       
        
        
    end
    
     turn_size(i,:)=total_reorient./turn_num; % calculating turning frequency
     
end



%% Plot

% head_dir_label={'(-45,45]','(45,135]','(-180,-135]&(135,180]','(-135,-45]'};      
% figure
%     plot(head_dir,turn_size(1,:),'Linewidth',0.8,'Color',[0.1 0.1 0.44]);
%     hold on;
%     plot(head_dir,turn_size(2,:),'Linewidth',0.8,'Color',[0.24 0.35 0.67]);
%     hold on;
%     plot(head_dir,turn_size(3,:),'Linewidth',0.8,'Color',[0 1 1]);
%     hold on;
%     plot(head_dir,turn_size(4,:),'Linewidth',0.8,'Color',[0.10 0.5 0.08]);
%     hold on;
%     plot(head_dir,turn_size(5,:),'Linewidth',0.8,'Color',[0 1 0]);
%     hold on;
%     plot(head_dir,turn_size(6,:),'Linewidth',0.8,'Color',[1 0.84 0]);
%     hold on;
%     plot(head_dir,turn_size(7,:),'Linewidth',0.8,'Color',[1 0.5 0]);
%     hold on;
% set(gca,'xtick',1:4);
% set(gca,'xticklabel',head_dir_label);
% legend('10n1GA','10n2GA','10n3GA','10n5EA','10n5EA sucrose','H2O','H2O sucrose');

figure
c0 = categorical({'(-45,45]','(45,135]','(-180,-135]&(135,180]','(-135,-45]'});
c = reordercats(c0,{'(-45,45]','(45,135]','(-180,-135]&(135,180]','(-135,-45]'});
%b=bar(c,turn_fre');%hold on;
b = bar(c,turn_size','FaceColor','flat');
for k = 1:size(turn_size',2)
    b(k).CData = k;
end

legend('10n1GA','10n2GA','10n3GA','10n5EA','10n5EA sucrose','H2O','H2O sucrose');

% 设置表头，坐标和图例
Title=title(['Heading Direction vs Turning Size']);
Xlabel=xlabel('Heading direction');
Ylabel=ylabel('Turning size');

% 坐标轴美化
set(gca, 'Box', 'on', ...
    'XGrid', 'on', 'YGrid', 'on', ...
    'TickDir', 'out', 'TickLength', [.015 .015], ...
    'XMinorTick', 'off', 'YMinorTick', 'off', ...
    'XColor', [.1 .1 .1],  'YColor', [.1 .1 .1])
% 字体和字号
set(gca, 'FontName', 'Helvetica')
set([Xlabel, Ylabel], 'FontName', 'AvantGarde')
set(gca, 'FontSize', 9)
set([Xlabel, Ylabel], 'FontSize', 11)
set(Title, 'FontSize', 11, 'FontWeight' , 'bold')
% 背景颜色
set(gcf,'Color',[1 1 1])

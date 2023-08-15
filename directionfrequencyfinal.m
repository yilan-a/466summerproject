clc;clear;

%% Initialization

data=cell(1,7);
turn_fre=zeros(7,4); % turning frequency(set the interval as 90, 
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
    turn_time=zeros(1,4); % total time of turnings   
    
    for j=1:height(data_table)
    %for j=1:1
        t=cell2mat(table2array(data_table(j,4))); 
        delta_t=diff(t); % time change
        predeg=cell2mat(table2array(data_table(j,18)));
        orientation=cell2mat(table2array(data_table(j,13)));
        x=cell2mat(table2array(data_table(j,5)));
        t0idx=cell2mat(table2array(data_table(j,11)));
        x_predeg=x(t0idx);
        
        for k=1:4
            
            for k1=1:length(predeg)
                if k==3
                    if (orien_min(k)<predeg(k1))||(predeg(k1)<=orien_max(k))&&(x_predeg(k1)>110)
                        turn_num(k)=turn_num(k)+1; % calculating turning number
                    end
                    
                else
                    if (orien_min(k)<predeg(k1))&&(predeg(k1)<=orien_max(k))&&(x_predeg(k1)>110)
                        turn_num(k)=turn_num(k)+1; % calculating turning number
                    end
                end
                
            end
            
            
            for k2=1:length(delta_t)
                if k==3
                    if (orien_min(k)<orientation(k2))||(orientation(k2)<=orien_max(k))&&(x(k2)>110)
                        turn_time(k)=turn_time(k)+delta_t(k2); % accumulating turning time
                    end
                else
                    if (orien_min(k)<orientation(k2))&&(orientation(k2)<=orien_max(k))&&(x(k2)>110)
                        turn_time(k)=turn_time(k)+delta_t(k2); % accumulating turning time
                    end
                end
                
            end
            
        end
       
        
        
    end
    
     turn_fre(i,:)=turn_num./turn_time; % calculating turning frequency
     
end



%% Plot

% c0 = categorical({'10n1GA','10n2GA','10n3GA','10n5EA','10n5EA sucrose','H2O','H2O sucrose'});
% c = reordercats(c0,{'10n1GA','10n2GA','10n3GA','10n5EA','10n5EA sucrose','H2O','H2O sucrose'});
% bar(c,turn_fre);hold on;

figure
c0 = categorical({'(-45,45]','(45,135]','(-180,-135]&(135,180]','(-135,-45]'});
c = reordercats(c0,{'(-45,45]','(45,135]','(-180,-135]&(135,180]','(-135,-45]'});
%b=bar(c,turn_fre');%hold on;
b = bar(c,turn_fre','FaceColor','flat');
for k = 1:size(turn_fre',2)
    b(k).CData = k;
end

legend('10n1GA','10n2GA','10n3GA','10n5EA','10n5EA sucrose','H2O','H2O sucrose');

% 设置表头，坐标和图例
Title=title(['Heading Direction vs Turning Frequency']);
Xlabel=xlabel('Heading direction');
Ylabel=ylabel('Turning frequency');

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


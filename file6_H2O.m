clc;clear;

%% Load data
load('H2O.mat');

m=length(dat_grouped.tsum); % total number of trajectories
tsum=dat_grouped.tsum;
index=find(tsum>30); % find index of > 30s traced trajectories
% tsum(index)=[];
tsum=tsum(index);
n=length(tsum); % number of > 30s trajectories
data1=dat_grouped(index,:); % > 30s traced data 


num=50; % number of random selection
index_rand=randi(n,1,num); % randomly select trajectories
data2=data1(index_rand,:); % randomly selected data

% an_index=table2array(data2(:,1)); % object ID

% initialize
x=cell(1,num);
y=cell(1,num);
t=cell(1,num);

for i=1:num
    
    x{i}=table2array(data2(i,3));
    y{i}=table2array(data2(i,4));
    t{i}=table2array(data2(i,5));
    
end

%% Q1

figure;
for i=1:num
    
    x1=cell2mat(x{i}); % coordinate matrix
    y1=cell2mat(y{i});
    
    plot(x1,y1,'Linewidth',1);
    hold on;
    scatter(x1(1),y1(1),8,'green','filled');
    scatter(x1(end),y1(end),8,'red','filled');
    
    % 设置表头和坐标
    Title=title('H20 Q1');
    Xlabel=xlabel('XAxis');
    Ylabel=ylabel('YAxis');
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
        
end

%% Q3

figure;
for i=1:num
    
    x1=cell2mat(x{i}); % coordinate matrix
    y1=cell2mat(y{i});
    
    x1=x1-ones(length(x1),1)*x1(1); % align to origin(center)
    y1=y1-ones(length(y1),1)*y1(1);
    
    plot(x1,y1,'Linewidth',1);
    hold on;
    scatter(x1(1),y1(1),8,'green','filled');
    scatter(x1(end),y1(end),8,'red','filled');
    
    % 设置表头和坐标
    Title=title('H2O Q3');
    Xlabel=xlabel('XAxis');
    Ylabel=ylabel('YAxis');
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
        
end








clc;clear;

%% Initialization

data=cell(1,6);
data1=data;
N_A=zeros(6,1000);
N_B=N_A;
tmax=zeros(6,1);
PI=zeros(6,1000);

%% Load data

load('10n1GA.mat');
data{1}=dat_grouped;
load('10n2GA.mat');
data{2}=dat_grouped;
load('10n3GA.mat');
data{3}=dat_grouped;
load('10n5EA.mat');
data{4}=dat_grouped;
load('10n5EA_sucrose.mat');
data{5}=dat_grouped;
load('H2O.mat');
data{6}=dat_grouped;

%% Calculate the number of AN
for i=1:6
    
    m=length(data{i}.tsum); % total number of trajectories
    tsum=data{i}.tsum;
%     index=find(tsum>30); % find index of > 30s traced trajectories
%     tsum=tsum(index);
%     data1{i}=data{i}(index,:); % > 30s traced data
    
    data1{i}=data{i};
    
    data_table=data1{i};
    
    for j=1:height(data_table)
        t=cell2mat(table2array(data_table(j,5)));  % turn the table to double matrix
        x=cell2mat(table2array(data_table(j,3)));  % turn the table to double matrix
        
        t_A=t; % initialize the time of area A and B
        t_B=t_A;
        
        for k=1:length(x) % set the time as NAN for corresponding area
            if x(k)<=99.5
                t_A(k)=nan;
            elseif (99.5<x(k))&&(x(k)<=110)
                t_A(k)=nan;
                t_B(k)=nan;
            else
                t_B(k)=nan;
            end
                       
        end
        
        t_A1=t_A(~isnan(t_A)); % remove the NAN
        t_B1=t_B(~isnan(t_B));
        
        t_A2=ceil(t_A1); % round up the time to calculate the number of objects 
        t_B2=ceil(t_B1); % at each second (when k < time < k+1 for an object,
                         % we regard that the object exists at time k+1)
                  
        t_A3=unique(t_A2); % remove the repeating numbers
        t_B3=unique(t_B2);
        
        if isempty(t_B3)==0      % if there exists object in area B, calculate
           for k=1:length(t_B3)  % the total number of AN
               N_B(i,t_B3(k))=N_B(i,t_B3(k))+1;
            end     
        end
        
        if isempty(t_A3)==0
           for k=1:length(t_A3)
               N_A(i,t_A3(k))=N_A(i,t_A3(k))+1;
            end     
        end

        temp=max([t_A3;t_B3]);
        if temp>tmax(i)
            tmax(i)=temp; % calculate the maximum experimenting time for each group
        end

     end
    
end

%% Calculate PI

for i=1:6
    areaA=N_A(i,:);
    areaB=N_B(i,:);
    PI(i,:)=(areaA-areaB)./(areaA+areaB);
    
end


%% Plot

t=0:tmax(1)-1;
title_label=["10n1GA","10n2GA","10n3GA","10n5EA","10n5EA sucrose","H2O"];

figure
for i=1:4
    
    plot(t,PI(i,1:tmax(1)),'Linewidth',0.8);
    hold on;
    
end
% 设置表头，坐标和图例
Title=title(['Preferential Index']);
Xlabel=xlabel('Time/s');
Ylabel=ylabel('PI');
legend(title_label(1),title_label(2),title_label(3),title_label(4));
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


figure
for i=5:6
    
    plot(t,PI(i,1:tmax(1)),'Linewidth',0.8);
    hold on;
    
end
% 设置表头，坐标和图例
Title=title(['Preferential Index']);
Xlabel=xlabel('Time/s');
Ylabel=ylabel('PI');
legend(title_label(5),title_label(6));
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
clc;clear;

%% Initialization

data=cell(1,7);

mean_velocity=zeros(7,1);
mean_run_probability=zeros(7,1);

probability=zeros(7,5);  % with run: [run  turn1:(-45,45]  turn2:(45,135]  
                         % turn3:(-180,-135]&(135,180]  turn4:(-135,-45]]
probability_without_run=zeros(7,4);  % without run: [turn1:(-45,45]  turn2:(45,135]  
                                     % turn3:(-180,-135]&(135,180]  turn4:(-135,-45]]

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

%% Calculate velocity 

for i=1:7
    
    data_table=data{i};
    velocity=zeros(height(data_table),1); % velocity of each larvae
    run_probability=zeros(height(data_table),1); % probability of running for each larvae
 
    
    for j=1:height(data_table)
    %for j=1:2
        %predeg=cell2mat(table2array(data_table(j,18)));
        x=cell2mat(table2array(data_table(j,5)));
        y=cell2mat(table2array(data_table(j,6)));
        delta_x=diff(x);
        delta_y=diff(y);
        tsum=table2array(data_table(j,9)); 
        velocity(j)=sum(sqrt(delta_x.*delta_x+delta_y.*delta_y))/tsum; % calculating velocity
        
        run_et=cell2mat(table2array(data_table(j,24)));
        run_probability(j)=sum(run_et)/tsum; % probability of running = running time/total time
        
        
    end
    
     mean_velocity(i)=mean(velocity);
     mean_run_probability(i)=mean(run_probability);
end

save('mean_velocity','mean_velocity')


%% Calculating probability

load('turning_frequency')

% With run
for i=1:7
    
    probability(i,1)=mean_run_probability(i);
    n=sum(turn_fre(i,:));
    probability(i,2)=turn_fre(i,1)/n*(1-mean_run_probability(i));
    probability(i,3)=turn_fre(i,2)/n*(1-mean_run_probability(i));
    probability(i,4)=turn_fre(i,3)/n*(1-mean_run_probability(i));
    probability(i,5)=turn_fre(i,4)/n*(1-mean_run_probability(i));
    
end
save('probability','probability')

% Without run
probability=zeros(7,4);
for i=1:7
    
    % probability(i,1)=mean_run_probability(i);
    n=sum(turn_fre(i,:));
    probability(i,1)=turn_fre(i,1)/n;
    probability(i,2)=turn_fre(i,2)/n;
    probability(i,3)=turn_fre(i,3)/n;
    probability(i,4)=turn_fre(i,4)/n;
    
end


save('probability_without_run','probability')

%% Plot

% figure
% c0 = categorical({'(-45,45]','(45,135]','(-180,-135]&(135,180]','(-135,-45]'});
% c = reordercats(c0,{'(-45,45]','(45,135]','(-180,-135]&(135,180]','(-135,-45]'});
% %b=bar(c,turn_fre');%hold on;
% b = bar(c,turn_size','FaceColor','flat');
% for k = 1:size(turn_size',2)
%     b(k).CData = k;
% end
% 
% legend('10n1GA','10n2GA','10n3GA','10n5EA','10n5EA sucrose','H2O','H2O sucrose');
% 
% % 设置表头，坐标和图例
% Title=title(['Heading Direction vs Turning Size']);
% Xlabel=xlabel('Heading direction');
% Ylabel=ylabel('Turning size');
% 
% % 坐标轴美化
% set(gca, 'Box', 'on', ...
%     'XGrid', 'on', 'YGrid', 'on', ...
%     'TickDir', 'out', 'TickLength', [.015 .015], ...
%     'XMinorTick', 'off', 'YMinorTick', 'off', ...
%     'XColor', [.1 .1 .1],  'YColor', [.1 .1 .1])
% % 字体和字号
% set(gca, 'FontName', 'Helvetica')
% set([Xlabel, Ylabel], 'FontName', 'AvantGarde')
% set(gca, 'FontSize', 9)
% set([Xlabel, Ylabel], 'FontSize', 11)
% set(Title, 'FontSize', 11, 'FontWeight' , 'bold')
% % 背景颜色
% set(gcf,'Color',[1 1 1])

clear all
close all
clc

%%

current_folder=pwd;
addpath(fullfile(current_folder,'..','Saved_analysis'));
% load('autoregulation_final.mat')
load('autoregulation_final_sloped.mat')

% prox=art(find(Z_Edges(art)>-40 & Z_Edges(art)<-20));

%%



mean1 = mean(V_all(:,Cap1)', 1);
stds1 = std(V_all(:,Cap1)', 0, 1);


mean3 = mean(Q_all(:,Cap1)', 1);
stds3 = std(Q_all(:,Cap1)', 0, 1);

mean2 = mean(IP_CaP_ent', 1);
stds2 = std(IP_CaP_ent', 0, 1);



fig1=figure;
% Total width of the figure (in normalized units)
totalWidth = 1;

% Widths of the subplots
width1 = 0.07;  % Width of the first subplot (15%)
width2 = 0.70;  % Width of the second subplot (80%)

% Gap between subplots (5% of the total width)
gap = 0.01;

% Positioning the first subplot (15%)
subplot('Position', [0.1, 0.2, width1, 0.7]); % [left, bottom, width, height]
errorbar([],[],[],'DisplayName','scenario 2','MarkerSize',6,...
    'Marker','diamond',...
    'LineWidth',2,...
    "MarkerEdgeColor","g",'Color',[80, 200, 120]/255)
ylim([0.3 1.7]);  % Replace with your actual limits
ax = gca;
ax.YColor = [80, 200, 120]/255;
ylabel('blood flow (nl/min)');
set(ax,'FontSize',12,'FontWeight','bold','LineWidth',2)


% Turn off the box to remove the top and right borders
box off

% To specifically remove the bottom and right borders instead, you'd modify the XAxis and YAxis properties
ax.XAxis.LineWidth = 0.001;  % Remove the bottom border

% Remove the bottom border by setting the 'Color' property to 'none'
ax.XAxis.Color = 'none';  % This removes the line, ticks, and labels
% Set the rest of your figure properties and display as needed





t=1:1:10;

subplot('Position', [0.1+width1 + gap, 0.2, width2, 0.7]); % Adjusting left position by adding gap

% Plotting the first set of error bars (blue)
yyaxis left;  % Switches to left y-axis
errorbar(t,mean1,stds1,'DisplayName','velocity','MarkerSize',6,...
    'Marker','o',...
    'LineStyle','-',...
    'LineWidth',2,...
    "MarkerEdgeColor","b",'Color',[0 0 1])

hold on
errorbar(t,mean3,stds3,'DisplayName','scenario 2','MarkerSize',6,...
    'Marker','diamond',...
    'LineStyle','-',...
    'LineWidth',2,...
    "MarkerEdgeColor",[80, 200, 120]/255,'Color',[80, 200, 120]/255)

hold on
load('autoregulation_final.mat')


mean1 = mean(V_all(:,Cap1)', 1);
stds1 = zeros(1,10);


mean3 = mean(Q_all(:,Cap1)', 1);
stds3 = zeros(1,10);

errorbar(t,mean1,stds1,'DisplayName','velocity','MarkerSize',6,...
    'Marker','o',...
    'LineStyle','--',...
    'LineWidth',2,...
    "MarkerEdgeColor","b",'Color',[0 0 1])

hold on
errorbar(t,mean3,stds3,'DisplayName','scenario 2','MarkerSize',6,...
    'Marker','diamond',...
    'LineStyle','--',...
    'LineWidth',2,...
    "MarkerEdgeColor",[80, 200, 120]/255,'Color',[80, 200, 120]/255)


% errorbar(t,mean3,stds3,'DisplayName','scenario 2','MarkerSize',6,...
%     'Marker','o',...
%     'LineWidth',2,...
%     "MarkerEdgeColor","g",'Color',[0 1 0])



ylabel('blood flow velocity (mm/s)');  % Label for the left y-axis
ylim([0.3 1.7]);  % Replace with your actual limits
% ylim([1 6])
% Adjusting the left y-axis color to blue
ax = gca;
ax.YColor = 'b';
set(ax,'FontSize',12,'FontWeight','bold','LineWidth',2)

load('autoregulation_final_sloped.mat')

% Plotting the second set of error bars (red)
yyaxis right;  % Switches to right y-axis
errorbar(t,mean2,stds2,'DisplayName','scenario 2','MarkerSize',6,...
    'Marker','o',...
    'LineStyle','-',...
    'LineWidth',2,...
    "MarkerEdgeColor","r",'Color',[1 0 0])
hold on

load('autoregulation_final.mat')

mean2 = mean(IP_CaP_ent', 1);
stds2 = zeros(1,10);

errorbar(t,mean2,stds2,'DisplayName','scenario 2','MarkerSize',6,...
    'Marker','o',...
    'LineStyle','--',...
    'LineWidth',2,...
    "MarkerEdgeColor","r",'Color',[1 0 0])

xlabel('Artery boundary node pressure (mmHg)');  % Label for the right y-axis
ylabel('IP (mmHg)');  % Label for the right y-axis
ylim([20 51]);  % Replace with your actual limits

% Adjusting the right y-axis color to red
ax.YColor = 'r';

grid on


xlim([-1 12])
% xticks(1:11);
xt=40:10:130;
xticklabels(xt);            

xlabel({'ABNP (mmHg)'},'FontWeight','bold','FontSize',12);


% hold(axes1,'off');
set(ax,'FontSize',12,'FontWeight','bold','LineWidth',2,'XTick',[1 2 3 4 5 6 7 8 9 10],'XTickLabel',{'40','50','60','70','80','90','100','110','120','130'})
% grid on                
hRealistic = line(nan, nan, 'Linestyle', '-', 'Color', 'k', 'LineWidth', 2);
hIdeal = line(nan, nan, 'Linestyle', '--', 'Color', 'k', 'LineWidth', 2);
legend([hIdeal, hRealistic], {'monophasic', 'biphasic'}, 'Location', 'northwest', 'TextColor', 'black');



%%
% 
figure_position=[693,758,764,351];
set(fig1, 'Position', figure_position);
% 
% filename = 'Cap_hemo_auto_IP.png'; % Name of the file
% print(gcf, filename, '-dpng', '-r300'); % Save as PNG at 300 DPI
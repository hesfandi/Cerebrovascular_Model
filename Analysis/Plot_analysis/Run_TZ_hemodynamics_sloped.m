%%


clear all
close all
clc


current_folder=pwd;
addpath(fullfile(current_folder,'..','Saved_analysis'));

%%
% load('autoregulation_final.mat')
load('autoregulation_final_sloped.mat')



TZ1 = find(G.Edges.Type == 3);
TZ2 = find(G.Edges.Type == 4);
TZ3 = find(G.Edges.Type == 5);
Cap1=find( G.Edges.Type == 6 | G.Edges.Type == 14 | G.Edges.Type == 0);
Cap2=find( G.Edges.Type == 13);
Cap3=find( G.Edges.Type == 12);
Cap4=find( G.Edges.Type == 11);
Cap=find( G.Edges.Type == 6 | G.Edges.Type == 14 | G.Edges.Type == 0 | G.Edges.Type == 13 | G.Edges.Type == 12 | G.Edges.Type == 11);
TZ=find( G.Edges.Type == 3 | G.Edges.Type == 4 | G.Edges.Type == 5);
sphinc=find(G.Edges.Type == 10);

%
ind4=find( G.Edges.Type == 6 | G.Edges.Type == 14 | G.Edges.Type == 0 );



TZ1_L1=TZ1(G.Edges.ZEdges(TZ1)> -210);
TZ2_L1=TZ2(G.Edges.ZEdges(TZ2)> -210);
TZ3_L1=TZ3( G.Edges.ZEdges(TZ3)>-210);





mean_TZ1 = mean(V_all(:,TZ1)', 1);
std_TZ1 = std(V_all(:,TZ1)', 0, 1);




mean_TZ1_L1 = mean(V_all(:,TZ1_L1)', 1);
std_TZ1_L1 = std(V_all(:,TZ1_L1)', 0, 1);


mean_TZ2 = mean(V_all(:,TZ2)', 1);
std_TZ2 = std(V_all(:,TZ2)', 0, 1);


mean_TZ2_L1 = mean(V_all(:,TZ2_L1)', 1);
std_TZ2_L1 = std(V_all(:,TZ2_L1)', 0, 1);


mean_TZ3 = mean(V_all(:,TZ3)', 1);
std_TZ3 = std(V_all(:,TZ3)', 0, 1);


mean_TZ3_L1 = mean(V_all(:,TZ3_L1)', 1);
std_TZ3_L1 = std(V_all(:,TZ3_L1)', 0, 1);


mean_Q_TZ1 = mean(Q_all(:,TZ1)', 1);
std_Q_TZ1 = std(Q_all(:,TZ1)', 0, 1);



mean_Q_TZ2 = mean(Q_all(:,TZ2)', 1);
std_Q_TZ2 = std(Q_all(:,TZ2)', 0, 1);




mean_Q_TZ3 = mean(Q_all(:,TZ3)', 1);
std_Q_TZ3 = std(Q_all(:,TZ3)', 0, 1);



fig1=figure;
% Total width of the figure (in normalized units)
t=P_BC;

LW=1.5;
% Plotting the second set of error bars (red)
yyaxis right;  % Switches to right y-axis
ax = gca;
errorbar(t,mean_Q_TZ1,std_Q_TZ1,'DisplayName','scenario 2','MarkerSize',8,...
    'Marker','o', 'LineStyle', '-',...
    'LineWidth',LW,...
    "MarkerEdgeColor","r",'Color',[1 0 0])
hold on
errorbar(t,mean_Q_TZ2,std_Q_TZ2,'DisplayName','scenario 2','MarkerSize',8,...
    'Marker','s', 'LineStyle', '-',...
    'LineWidth',LW,...
    "MarkerEdgeColor","r",'Color',[1 0 0])
hold on
errorbar(t,mean_Q_TZ3,std_Q_TZ3,'DisplayName','scenario 2','MarkerSize',8,...
    'Marker','diamond', 'LineStyle', '-',...
    'LineWidth',LW,...
    "MarkerEdgeColor","r",'Color',[1 0 0])

xlabel('ABNP (mmHg)');  % Label for the right y-axis
ylabel('blood flow (nl/min)');  % Label for the right y-axis
ylim([0 7]);  % Replace with your actual limits

% Adjusting the right y-axis color to red
ax.YColor = [1 0 0];




yyaxis left;  % Switches to left y-axis




% Plotting the first set of error bars (blue)
errorbar(t,mean_TZ1,std_TZ1,'DisplayName','TZ1','MarkerSize',8,...
    'Marker','o', 'LineStyle', '-',...
    'LineWidth',LW,...
    "MarkerEdgeColor",[0, 150, 255]/255,'Color',[0, 150, 255]/255)

hold on
plot(t, mean_TZ1_L1, 'DisplayName', 'scenario 2', 'MarkerSize', 8, ...
    'Marker', 'O', 'LineStyle', '--', ...
    'LineWidth', LW, ...
    'MarkerEdgeColor', [0, 150, 255]/255, 'Color', [0, 150, 255]/255);

hold on
errorbar(t,mean_TZ2,std_TZ2,'DisplayName','scenario 2','MarkerSize',8,...
    'Marker','s', 'LineStyle', '-',...
    'LineWidth',LW,...
    "MarkerEdgeColor",[31, 81, 255]/255,'Color',[31, 81, 255]/255)



hold on
errorbar(t,mean_TZ3,std_TZ3,'DisplayName','scenario 2','MarkerSize',8,...
    'Marker','diamond', 'LineStyle', '-',...
    'LineWidth',LW,...
    "MarkerEdgeColor",[0, 0, 139]/255,'Color',[0, 71, 171]/255)



ylabel('blood flow velocity (mm/s)');  % Label for the left y-axis
% ylim([10 40]);  % Replace with your actual limits
ylim([0 10])
xlim([30 140])

% Adjusting the left y-axis color to blue
ax = gca;
ax.YColor = 'b';
set(ax,'FontSize',12,'FontWeight','bold','LineWidth',2)






xlabel({'ABNP (mmHg)'},'FontWeight','bold','FontSize',12);


% hold(axes1,'off');
set(ax,'FontSize',12,'FontWeight','bold','LineWidth',2)
grid on                



color_TZ1 = [0, 150, 255]/255;
color_TZ2 = [31, 81, 255]/255;
color_TZ3 = [0, 0, 139]/255;



% Dummy plots for legend entries
h1 = plot(NaN,NaN, '-o', 'Color', color_TZ1, 'LineWidth', 2);
h2 = plot(NaN,NaN, '-s', 'Color', color_TZ2, 'LineWidth', 2);
h3 = plot(NaN,NaN, '-diamond', 'Color', color_TZ3, 'LineWidth', 2);
h4 = plot(NaN,NaN, '--o', 'Color', color_TZ1, 'LineWidth', 2);  % Dashed black line

% Create the legend
legend([h1, h2, h3, h4], {'TZ1', 'TZ2', 'TZ3', 'Mean(TZ1_{L1})'}, 'NumColumns', 4, 'Location', 'northwest');



figure_position=[979,668,772,339];
set(fig1, 'Position', figure_position);

% filename = 'TZ_hemo_sloped.png'; % Name of the file
% print(gcf, filename, '-dpng', '-r300'); % Save as PNG at 300 DPI

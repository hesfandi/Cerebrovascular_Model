clear all;
close all;
clc;

current_folder=pwd;
addpath(fullfile(current_folder,'..','Saved_analysis'));

load('autoregulation_final.mat') %Flat
% load('autoregulation_final_sloped.mat')

%%
ind4=find( G.Edges.Type == 6 );
ind4=Cap1;
ind_L1=ind4(G.Edges.ZEdges(ind4,1)> -210);
ind_L2=ind4(G.Edges.ZEdges(ind4,1)> -420 & G.Edges.ZEdges(ind4,1)<= -210);
ind_L3=ind4(G.Edges.ZEdges(ind4,1)> -630 & G.Edges.ZEdges(ind4,1)<= -420);
ind_L4=ind4( G.Edges.ZEdges(ind4,1)<= -630);
t=1:4;
mm=[mean(abs(Q_all(1,ind_L1))),mean(abs(Q_all(1,ind_L2))),mean(abs(Q_all(1,ind_L3))),mean(abs(Q_all(1,ind_L4)))];
err=[std(abs(Q_all(1,ind_L1))),std(abs(Q_all(1,ind_L2))),std(abs(Q_all(1,ind_L3))),std(abs(Q_all(1,ind_L4)))];
figure('Color',[1 1 1]);
axes1 = axes;
hold(axes1,'on');
errorbar(t,mm,err,'DisplayName','ABNP = 40 mmHg','MarkerSize',8,...
    'Marker','square',...
    'LineWidth',2,...
    "MarkerEdgeColor",[0 0.4470 0.7410],'Color',[0 0.4470 0.7410])
mm=[mean(abs(Q_all(2,ind_L1))),mean(abs(Q_all(2,ind_L2))),mean(abs(Q_all(2,ind_L3))),mean(abs(Q_all(2,ind_L4)))];
err=[std(abs(Q_all(2,ind_L1))),std(abs(Q_all(2,ind_L2))),std(abs(Q_all(2,ind_L3))),std(abs(Q_all(2,ind_L4)))];
errorbar(t,mm,err,'DisplayName','ABNP = 50 mmHg','MarkerSize',8,...
    'Marker','square',...
    'LineWidth',2,...
    "MarkerEdgeColor",[0.6350 0.0780 0.1840],'Color',[0.6350 0.0780 0.1840])

mm=[mean(abs(Q_all(3,ind_L1))),mean(abs(Q_all(3,ind_L2))),mean(abs(Q_all(3,ind_L3))),mean(abs(Q_all(3,ind_L4)))];
err=[std(abs(Q_all(3,ind_L1))),std(abs(Q_all(3,ind_L2))),std(abs(Q_all(3,ind_L3))),std(abs(Q_all(3,ind_L4)))];
errorbar(t,mm,err,'DisplayName','ABNP = 60 mmHg','MarkerSize',8,...
    'Marker','square',...
    'LineWidth',2,...
    "MarkerEdgeColor",[0, 163, 108]/255,'Color',[0, 163, 108]/255)

mm=[mean(abs(Q_all(4,ind_L1))),mean(abs(Q_all(4,ind_L2))),mean(abs(Q_all(4,ind_L3))),mean(abs(Q_all(4,ind_L4)))];
err=[std(abs(Q_all(4,ind_L1))),std(abs(Q_all(4,ind_L2))),std(abs(Q_all(4,ind_L3))),std(abs(Q_all(4,ind_L4)))];
errorbar(t,mm,err,'DisplayName','ABNP = 70 mmHg','MarkerSize',8,...
    'Marker','square',...
    'LineWidth',2,...
    "MarkerEdgeColor","k",'Color',[0 0 0])

mm=[mean(abs(Q_all(5,ind_L1))),mean(abs(Q_all(5,ind_L2))),mean(abs(Q_all(5,ind_L3))),mean(abs(Q_all(5,ind_L4)))];
err=[std(abs(Q_all(5,ind_L1))),std(abs(Q_all(5,ind_L2))),std(abs(Q_all(5,ind_L3))),std(abs(Q_all(5,ind_L4)))];
errorbar(t,mm,err,'DisplayName','ABNP = 80 mmHg','MarkerSize',8,...
    'Marker','square',...
    'LineWidth',2,...
    "MarkerEdgeColor",[128, 0, 128]/255,'Color',[128, 0, 128]/255)


mm=[mean(abs(Q_all(6,ind_L1))),mean(abs(Q_all(6,ind_L2))),mean(abs(Q_all(6,ind_L3))),mean(abs(Q_all(6,ind_L4)))];
err=[std(abs(Q_all(6,ind_L1))),std(abs(Q_all(6,ind_L2))),std(abs(Q_all(6,ind_L3))),std(abs(Q_all(6,ind_L4)))];
errorbar(t,mm,err,'DisplayName','ABNP = 90 mmHg','MarkerSize',8,...
    'Marker','square',...
    'LineWidth',2,...
    "MarkerEdgeColor",[255, 140, 0]/255,'Color',[255, 140, 0]/255)

mm=[mean(abs(Q_all(8,ind_L1))),mean(abs(Q_all(8,ind_L2))),mean(abs(Q_all(8,ind_L3))),mean(abs(Q_all(8,ind_L4)))];
err=[std(abs(Q_all(8,ind_L1))),std(abs(Q_all(8,ind_L2))),std(abs(Q_all(8,ind_L3))),std(abs(Q_all(8,ind_L4)))];
errorbar(t,mm,err,'DisplayName','ABNP = 110 mmHg','MarkerSize',8,...
    'Marker','square',...
    'LineWidth',2,...
    "MarkerEdgeColor",[245, 66, 188]/255,'Color',[245, 66, 188]/255)

mm=[mean(abs(Q_all(10,ind_L1))),mean(abs(Q_all(10,ind_L2))),mean(abs(Q_all(10,ind_L3))),mean(abs(Q_all(10,ind_L4)))];
err=[std(abs(Q_all(10,ind_L1))),std(abs(Q_all(10,ind_L2))),std(abs(Q_all(10,ind_L3))),std(abs(Q_all(10,ind_L4)))];
errorbar(t,mm,err,'DisplayName','ABNP = 130 mmHg','MarkerSize',8,...
    'Marker','square',...
    'LineWidth',2,...
    "MarkerEdgeColor",[150, 145, 156]/255,'Color',[150, 145, 156]/255)


xlim([0 5])
ylim([0.3 1])

ylabel({'Capillary blood flow(nl/min)'},'FontWeight','bold','FontSize',14);
xlabel('Vascular layers','FontWeight','bold','FontSize',14);
hold(axes1,'off');
set(axes1,'FontSize',14,'FontWeight','bold','LineWidth',1,'XTick',[1 2 3 4],'XTickLabel',{'L1','L2','L3','L4'},'XTickLabelRotation',0)

% Manually define the legend
lgd = legend();  % Correct order and labels

set(lgd,...
    'Position',[0.526511657199937 0.792403781322734 0.236013981637421 0.0997854050392757],'NumColumns',2);


% filename = 'Increase_of_ANBC_sloped.png'; % Name of the file
% print(gcf, filename, '-dpng', '-r500'); % Save as PNG at 300 DPI
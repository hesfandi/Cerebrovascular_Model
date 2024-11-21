clear all
clc
close all

current_folder=pwd;
addpath(fullfile(current_folder,'..','Saved_analysis'));

% load('autoregulation_final.mat')
load('autoregulation_final_sloped.mat')

%% WSS-Pressure

TZ1 = find(G.Edges.Type == 3);
TZ2 = find(G.Edges.Type == 4);
TZ3 = find(G.Edges.Type == 5);
TZ=find( G.Edges.Type == 3 | G.Edges.Type == 4 | G.Edges.Type == 5);

L1_ind=find(H.Edges.ZEdges>=-400);
sphinc_L1=sphinc(ismember(sphinc,L1_ind));
ind4=find( G.Edges.Type == 6 | G.Edges.Type == 11 | G.Edges.Type == 12 );

data1=((WSS(:,art))./WSS(1,art))'-1;

data2=((WSS(:,piart))./WSS(1,piart))'-1;
data3=((WSS(:,TZ))./WSS(1,TZ))'-1;
data4=((WSS(:,ind4))./WSS(1,ind4))'-1;
data5=((WSS(:,sphinc_L1))./WSS(1,sphinc_L1))'-1;


% data1=((WSS(:,art)))';
% 
% data2=((WSS(:,piart)))';
% data3=((WSS(:,TZ)))';
% data4=((WSS(:,ind4)))';
% data5=((WSS(:,sphinc_L1)))';



P_BCMin = min(P_BC);
P_BCMax = max(P_BC);
newP_BC = linspace(P_BCMin, P_BCMax, 10);  % 10 evenly spaced values between xMin and xMax





meanData1 = (mean(data1, 2))'; % Calculate the mean of each column in data1
stdData1 = (std(data1, 0, 2))'; % Calculate the standard deviation of each column in data1


meanData2 = (mean(data2, 2))';
stdData2 = (std(data2, 0, 2))';

meanData3 = (mean(data3, 2))';
stdData3 = (std(data3, 0, 2))';

meanData4 = (mean(data4, 2))';
stdData4 = (std(data4, 0, 2))';

meanData5 = (mean(data5, 2))';
stdData5 = (std(data5, 0, 2))';



fig1=figure;
axes1 = axes;
hold(axes1,'on');
stdshade(100*data2,0.3,'m')
stdshade(100*data1,0.3,'r')
stdshade(100*data5,0.3,[80, 200, 120]/255)
stdshade(100*data3,0.3,'b')
stdshade(100*data4,0.3,'k')


lines = findobj(gcf, 'Type', 'Line');

set(lines(2), 'DisplayName', 'TZs');
set(lines(1), 'DisplayName', 'Caps');
set(lines(4), 'DisplayName', 'PAs');
set(lines(3), 'DisplayName', 'Sphincters(L1-L2)');
set(lines(5), 'DisplayName', 'SAs');
% Create the legend
legend1=legend();
set(legend1,...
    'Position',[0.175698824079275 0.695887451402811 0.453766570107058 0.201298695783336],...
    'NumColumns',1);

% xticks(1:11);
xt=40:10:130;
xlim([1 10])
ylim([0 800])
xticklabels(xt);             % Set the x-tick labels to your custom P_BC values


xlabel('ABNP (mmHg)');
ylabel('\DeltaWSS (% change)');
% title('normalized relative change of WSS to Initial Value in different vascular zones')
hold(axes1,'off');
set(axes1,'FontSize',12,'FontWeight','bold','LineWidth',1)
linesForLegend = lines(5:-1:1);  % Adjust according to how many and which lines you want

% Create a legend for these specific lines
legend(linesForLegend, 'NumColumns', 1);
figure_position=[1208,1031,377,308];
set(fig1, 'Position', figure_position);      

% filename = 'WSS_ABNP_sloped.png'; % Name of the file
% print(gcf, filename, '-dpng', '-r300'); % Save as PNG at 300 DPI
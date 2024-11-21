clear all;
close all;
clc;

current_folder=pwd;
addpath(fullfile(current_folder,'..','Saved_analysis'));

load('autoregulation_final.mat')
% load('autoregulation_final_sloped.mat')

%%
x=6;
y=1;
ind4=find( G.Edges.Type == 6 );
ind_L1=ind4(G.Edges.ZEdges(ind4,1)> -210);
ind_L2=ind4(G.Edges.ZEdges(ind4,1)> -420 & G.Edges.ZEdges(ind4,1)<= -210);
ind_L3=ind4(G.Edges.ZEdges(ind4,1)> -630 & G.Edges.ZEdges(ind4,1)<= -420);
ind_L4=ind4( G.Edges.ZEdges(ind4,1)<= -630);

Q_Cap_L1=(abs(Q_all(1+y:end-x,ind_L1)));
Q_Cap_L1=Q_Cap_L1(:)';
indices = 1:1620;
Q_Cap_L1=Q_Cap_L1(indices);
Q_Cap_L2=(abs(Q_all(1+y:end-x,ind_L2)));
Q_Cap_L2=Q_Cap_L2(:)';
Q_Cap_L2=Q_Cap_L2(indices);
Q_Cap_L3=(abs(Q_all(1+y:end-x,ind_L3)));
Q_Cap_L3=Q_Cap_L3(:)';
Q_Cap_L3=Q_Cap_L3(indices);
Q_Cap_L4=(abs(Q_all(1+y:end-x,ind_L4)));
Q_Cap_L4=Q_Cap_L4(:)';
Q_Cap_L4=Q_Cap_L4(indices);
Q_Cap_tot=[Q_Cap_L1;Q_Cap_L2;Q_Cap_L3;Q_Cap_L4];
%%
M = Q_Cap_tot;
% Calculate the mean and standard deviation for each row
rowMeans = mean(M, 2);  % Mean of each row
rowStdDev = std(M, 0, 2);  % Standard deviation of each row

% Plotting
fig1=figure;

% Plot for Mean
subplot(1, 2, 1);  % This divides the figure into a 1x2 grid, and activates the first element
bar(rowMeans);
xlabel('Vascular layers', 'FontSize', 14, 'FontWeight', 'bold');
ylabel({'Mean capillary blood flow',' (nl/min)'}, 'FontSize', 14, 'FontWeight', 'bold');
% title('ABNP:40-80 mmHg')
% Change xticks here
xticks([1:4]);  % Adjust this as needed
xticklabels({'L_1', 'L_2', 'L_3', 'L_4'}); % Adjust labels as needed
set(gca, 'XTickLabel', get(gca, 'XTickLabel'), 'FontWeight', 'bold','FontSize', 12);  % Make xtick labels bold

% Plot for Standard Deviation
subplot(1, 2, 2);  % Activates the second element of the grid for the next plot
bar(rowStdDev);
xlabel('Vascularl layers', 'FontSize', 14, 'FontWeight', 'bold');
ylabel({'STD capillary blood flow',' (nl/min)'}, 'FontSize', 14, 'FontWeight', 'bold');
% Change xticks here
xticks([1:4]);  % Adjust this as needed
xticklabels({'L_1', 'L_2', 'L_3', 'L_4'}); % Adjust labels as needed
set(gca, 'XTickLabel', get(gca, 'XTickLabel'), 'FontWeight', 'bold','FontSize', 12);  % Make xtick labels bold

% Improve layout
set(gcf, 'Position', [100, 100, 1000, 400]);  % Adjust the size of the figure
figure_position=[839,783,776/2,305];
set(fig1, 'Position', figure_position);


% filename = 'Mean_std_50_70.png'; % Name of the file
% print(gcf, filename, '-dpng', '-r500'); % Save as PNG at 300 DPI




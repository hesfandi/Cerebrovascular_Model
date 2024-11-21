clear all
close all
clc

current_folder=pwd;
addpath(fullfile(current_folder,'..','Saved_analysis'));

%%
% load('FH_analysis.mat')
load('FH_BC70_MTi_03_final.mat')

q_dif1=qL1(2:end);
q_dif2=qL2(2:end);
q_dif1=(q_dif1-qL1(1))/qL1(1);
q_dif2=(q_dif2-qL2(1))/qL2(1);
aa2=[q_dif1;q_dif2];


% Create figure
% Define the figure position and size
figure_position = [625,902,936,437]; % [left, bottom, width, height]

% Create figure
fig = figure;
fig.Position = figure_position;

% Define the position of the first subplot
subplot1_position = [0.06, 0.1, 0.72, 0.8]; % [left, bottom, width, height]
ax1 = subplot('Position', subplot1_position);


% axes1 = axes;

% Create the bar chart with a slightly larger width
hBar = bar(ax1,100*aa2', 'BarWidth', 1);  % Adjust 'BarWidth' as needed

% Get the current position of the axes
originalPosition = get(gca, 'Position');  % [left, bottom, width, height]

% Adjust the bottom value slightly
adjustedPosition = originalPosition;  % Copy the original position
adjustedPosition(2) = adjustedPosition(2) + 0.12;  % Increase the bottom value
adjustedPosition(4) = 0.7;  % Increase the bottom value
% Set the new position of the axes
set(gca, 'Position', adjustedPosition);



% Set the colors of each set of bars (here, just two sets for illustration)
hBar(1).FaceColor = 'r';  % Color for Superficial layer
hBar(2).FaceColor = 'b';  % Color for Deep layer

hold on;

% Custom x-tick labels with multiline where needed
labels = {'SA', 'PA', 'Sphinc', 'TZ', 'Cap', 'SAs+PAs', 'SAs+PAs+Sphinc', 'SAs+PAs +Sphinc+T', 'ALL'};

% Adjust each label as needed for multi-line
labels{7} = sprintf('SAs+PAs\n+Sphinc');  % Multi-row label
labels{8} = sprintf('SAs+PAs\n+Sphinc\n+TZ');  % Multi-row label

% Turn off default x-tick labels
set(gca, 'XTick', 1:length(labels), 'XTickLabel', {});

% Get the position for the x-ticks (assumes bars are centered at 1:length(labels))
xtickPos = 1:length(labels);

% Determine a suitable y-position for the labels (below the axis)
ylimValues = ylim;  % Get the current y-axis limits
yPos = ylimValues(1) - 0.09 * range(ylimValues);  % Position below the x-axis
FZ=11;
% Add each label as a text object
for i = 1:length(labels)
    if (i==7)
          text(xtickPos(i), yPos-0.02, labels{i}, 'HorizontalAlignment', 'center', 'FontSize', FZ,'FontWeight','bold');
    elseif (i==8)
          text(xtickPos(i), yPos-0.04, labels{i}, 'HorizontalAlignment', 'center', 'FontSize', FZ,'FontWeight','bold');
    else
          text(xtickPos(i), yPos, labels{i}, 'HorizontalAlignment', 'center', 'FontSize', FZ,'FontWeight','bold');
    end
    
end

% Customize the plot
ylabel('% change in capillary blood flow');
set(gca, 'YAxisLocation', 'left', 'Box', 'off');
set(gcf, 'Position', [688,914,873,425]);  % Adjust the size of the figure
set(gca,'FontSize',12,'FontWeight','bold','LineWidth',1)
grid on
% Add legend
legend(hBar, {'L1-L2','L3-L4'}, 'Location', 'best','NumColumns',2,'Position',[0.142456272435605 0.8500414202021071 0.23148687203841 0.0680473356028276]);% Ensure all labels and the chart fit within the figure window
% ylim([yPos, ylimValues(2)]);

% Define the position of the second subplot
subplot2_position = [0.85, 0.22, 0.12, 0.57]; % [left, bottom, width, height]
ax2 = subplot('Position', subplot2_position);

FH=aa(:,10)-aa(:,1);
Basal=aa(:,1);
data1 =[Basal,FH];

% Define colors for the stacks
colors = [[128, 128, 128]./255;  % Color for Basal (blue)
          [80, 200, 120]./255];  % Color for FH (red); % Color for CP (orange)
      
% subplot(1, 2, 2);  % Divide the figure into a 1x2 grid, and use the 1st section
% Create the stacked bar chart for the first data set
hBar1 = bar(ax2,data1, 'stacked');
RC=100*(data1(:,2))./data1(:,1);
% Apply the colors to each stack for the first subplot
for i = 1:length(hBar1)
    hBar1(i).FaceColor = 'flat';
    hBar1(i).CData = repmat(colors(i,:), size(data1,1), 1);
end
set(gca,'FontSize',12,'FontWeight','bold','LineWidth',1, 'XTick', 1:2, 'XTickLabel',{'L1-L2','L3-L4'},'XTickLabelRotation',90);
ylabel('Capillary blood flow (nl/min)');
legend('Basal', 'FH','Position',[0.823082758253908 0.82 0.160714283638767 0.091190473494076]);

hold off;
% filename = 'Main_FH.png'; % Name of the file
% print(gcf, filename, '-dpng', '-r600'); % Save as PNG at 300 DPI
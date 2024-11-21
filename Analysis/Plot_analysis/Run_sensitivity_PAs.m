clear all;
clc;
close all;

current_folder=pwd;
addpath(fullfile(current_folder,'..','Saved_analysis'));

% load('autoregulation_final.mat')
load('autoregulation_final_sloped.mat')


%%

WT_150 =(( WT(1:end,8)/WT(1,8))-1)*100;  %
WT_450 = ((WT(1:end,19)/WT(1,19))-1)*100;  
WT_700 = ((WT(1:end,30)/WT(1,30))-1)*100;  

% Plotting
fig1=figure;
plot(P_BC(1:end), WT_150(1:end), 'b-', 'LineWidth', 2);  % Blue line for PA @ 240 um depth
hold on;
plot(P_BC(1:end), WT_450(1:end), 'r-', 'LineWidth', 2);  % Red line for PA @ 450 um depth
hold on;
plot(P_BC(1:end), WT_700(1:end), 'Color', [0.4940 0.1840 0.5560], 'LineWidth', 2);  % Red line for PA @ 450 um depth
% Enhancing the plot for publication
xlabel('ABNP (mmHg)', 'FontSize', 14, 'FontWeight', 'bold');
ylabel({'\DeltaWT (% change)'} , 'FontSize', 14, 'FontWeight', 'bold');
% legend('PA @ 150 \mum depth', 'PA @ 420 \mum depth', 'FontSize', 12, 'FontWeight', 'bold', 'Position', [0.202601980060632 0.76580086951648 0.476793237942181 0.136363632648022]);
legend('PA @ 150 \mum depth', 'PA @ 420 \mum depth','PA @ 700 \mum depth', 'FontSize', 12, 'FontWeight', 'bold', 'Position', [0.22601980060632 0.73580086951648 0.476793237942181 0.136363632648022]);
grid on;  % Optional: add grid lines
ylim([0 100])

xlim([40 130])
% Make all text in the figure bold and size 14
% set(gca, 'XTickLabel', get(gca, 'XTickLabel'), 'FontWeight', 'bold','FontSize', 12);  % Make xtick labels bold
% set(gca, 'YTickLabel', get(gca, 'YTickLabel'), 'FontWeight', 'bold','FontSize', 12);  % Make xtick labels bold
set(gca,'FontSize',12,'FontWeight','bold','LineWidth',1); % gca gets the current axes

% Adjust the figure's size and position on the screen (optional)
set(gcf, 'Position', [100, 100, 800, 600]);


figure_position=[1208,1031,377,308];
set(fig1, 'Position', figure_position);
% filename = 'sensitivity_PA_sloped'; % Name of the file
% print(gcf, filename, '-dpng', '-r500'); % Save as PNG at 300 DPI
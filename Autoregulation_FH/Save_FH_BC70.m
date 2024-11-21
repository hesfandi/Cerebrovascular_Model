clear 
clc
close all

load('Graph_final.mat')

Param=input_Boas();

qL1=[];
qL2=[];


PA_ind=find(H.Edges.Type==2);
cap_ind=find(H.Edges.Type == 6 | H.Edges.Type == 11 | H.Edges.Type == 12);
L1=find(H.Edges.ZEdges>-420);
L2=find(H.Edges.ZEdges<=-420);
Cap_L1=cap_ind(ismember(cap_ind,L1));
Cap_L2=cap_ind(ismember(cap_ind,L2));

Sphinc=find( H.Edges.Type == 10 );


Sphinc_PA_SA=find( H.Edges.Type == 2| H.Edges.Type == 10 | H.Edges.Type == 7);

TZ=find(H.Edges.Type == 3| H.Edges.Type == 4| H.Edges.Type == 5 );

PA=find(H.Edges.Type==2);

SA=find(H.Edges.Type==7);
PA_SA=[PA;SA];
SA_PA_Sphinc_EP=[SA;PA;Sphinc;TZ];

All=[SA;PA;Sphinc;TZ;cap_ind];
BC(1,3)=40;
[~,nodpress1,~,~]=flow_Boas_new_vis(H,Param,BC(:,1),BC(:,2),BC(:,3),BC(:,4),[]); 
seg=(nodpress1(:,H.Edges.EndNodes(:,1)')+nodpress1(:,H.Edges.EndNodes(:,2)'))/2;

H.Edges.ctl=seg'/(seg(19));
BC(1,3)=70;
TF=0.196;
N=H;
H.Edges.D=H.Edges.D-H.Edges.ctl*TF.*H.Edges.D;
G=H;
[q,nodpress1,~,~]=flow_Boas_new_vis(H,Param,BC(:,1),BC(:,2),BC(:,3),BC(:,4),[]); 
seg=(nodpress1(:,H.Edges.EndNodes(:,1)')+nodpress1(:,H.Edges.EndNodes(:,2)'))/2;
ratio=0.70;
qL1=[qL1,mean(abs(q(Cap_L1)))];
qL2=[qL2,mean(abs(q(Cap_L2)))];
Q_t=(qL1+qL2)/2;
q_B1=qL1;
q_B2=qL2;
BC(1,3)=70;
%% only SA dilation
H=G;
H.Edges.D(SA)=N.Edges.D(SA)-(N.Edges.ctl(SA)*TF*ratio-0.0583).*N.Edges.D(SA);
[q1,~,K,vis]=flow_Boas_new_vis(H,Param,BC(:,1),BC(:,2),BC(:,3),BC(:,4),[]); 

qL1=[qL1,mean(abs(q1(Cap_L1)))];
qL2=[qL2,mean(abs(q1(Cap_L2)))];
%% PA 
H=G;
H.Edges.D(PA)=N.Edges.D(PA)-(N.Edges.ctl(PA)*TF*ratio-0.0583).*N.Edges.D(PA);
[q1,~,~,~]=flow_Boas_new_vis(H,Param,BC(:,1),BC(:,2),BC(:,3),BC(:,4),[]); 

qL1=[qL1,mean(abs(q1(Cap_L1)))];
qL2=[qL2,mean(abs(q1(Cap_L2)))];
%% Sphinc
H=G;
H.Edges.D(Sphinc)=N.Edges.D(Sphinc)-(N.Edges.ctl(Sphinc)*TF*ratio-0.0583).*N.Edges.D(Sphinc);
[q1,~,~,~]=flow_Boas_new_vis(H,Param,BC(:,1),BC(:,2),BC(:,3),BC(:,4),[]); 

qL1=[qL1,mean(abs(q1(Cap_L1)))];
qL2=[qL2,mean(abs(q1(Cap_L2)))];

%% EP_Br
H=G;
H.Edges.D(TZ)=N.Edges.D(TZ)-(N.Edges.ctl(TZ)*TF*ratio-0.0583).*N.Edges.D(TZ);
[q1,~,~,~]=flow_Boas_new_vis(H,Param,BC(:,1),BC(:,2),BC(:,3),BC(:,4),[]); 

qL1=[qL1,mean(abs(q1(Cap_L1)))];
qL2=[qL2,mean(abs(q1(Cap_L2)))];

%% CP

H=G;
H.Edges.D(cap_ind)=N.Edges.D(cap_ind)-(N.Edges.ctl(cap_ind)*TF*ratio-0.0583).*N.Edges.D(cap_ind);
[q1,~,~,~]=flow_Boas_new_vis(H,Param,BC(:,1),BC(:,2),BC(:,3),BC(:,4),[]); 

qL1=[qL1,mean(abs(q1(Cap_L1)))];
qL2=[qL2,mean(abs(q1(Cap_L2)))];
%% PA+ SA
H=G;
H.Edges.D(PA_SA)=N.Edges.D(PA_SA)-(N.Edges.ctl(PA_SA)*TF*ratio-0.0583).*N.Edges.D(PA_SA);
[q1,~,~,~]=flow_Boas_new_vis(H,Param,BC(:,1),BC(:,2),BC(:,3),BC(:,4),[]); 

qL1=[qL1,mean(abs(q1(Cap_L1)))];
qL2=[qL2,mean(abs(q1(Cap_L2)))];
%% PA+ SA+ sphinc
H=G;
H.Edges.D(Sphinc_PA_SA)=N.Edges.D(Sphinc_PA_SA)-(N.Edges.ctl(Sphinc_PA_SA)*TF*ratio-0.0583).*N.Edges.D(Sphinc_PA_SA);
[q1,~,~,~]=flow_Boas_new_vis(H,Param,BC(:,1),BC(:,2),BC(:,3),BC(:,4),[]); 

qL1=[qL1,mean(abs(q1(Cap_L1)))];
qL2=[qL2,mean(abs(q1(Cap_L2)))];



%% SA+ PA + sphinc + EP
H=G;
H.Edges.D(SA_PA_Sphinc_EP)=N.Edges.D(SA_PA_Sphinc_EP)-(N.Edges.ctl(SA_PA_Sphinc_EP)*TF*ratio-0.0583).*N.Edges.D(SA_PA_Sphinc_EP);
[q1,~,~,~]=flow_Boas_new_vis(H,Param,BC(:,1),BC(:,2),BC(:,3),BC(:,4),[]); 

qL1=[qL1,mean(abs(q1(Cap_L1)))];
qL2=[qL2,mean(abs(q1(Cap_L2)))];

%% ALL
H=G;
H.Edges.D(SA_PA_Sphinc_EP)=N.Edges.D(SA_PA_Sphinc_EP)-(N.Edges.ctl(SA_PA_Sphinc_EP)*TF*ratio-0.0583).*N.Edges.D(SA_PA_Sphinc_EP);
H.Edges.D(cap_ind)=N.Edges.D(cap_ind)-(N.Edges.ctl(cap_ind)*TF*ratio-0.0194).*N.Edges.D(cap_ind);
[q1,nodpress1,~]=flow_Boas_new(H,Param,BC(:,1),BC(:,2),BC(:,3),BC(:,4),[]); 

qL1=[qL1,mean(abs(q1(Cap_L1)))];
qL2=[qL2,mean(abs(q1(Cap_L2)))];

%%
aa=[qL1;qL2];
q_dif1=qL1(2:end);
q_dif2=qL2(2:end);
q_dif1=q_dif1-qL1(1);
q_dif2=q_dif2-qL2(1);
bar(aa');
xticklabels({'basal','SA','PA','Sphinc','EP','CP','A','A+Sphinc','SA+PA+Sphinc+EP','ALL'});

aa2=[q_dif1;q_dif2];
figure;
bar(aa2');
xticklabels({'SA','PA','Sphinc','EP','CP','A','A+Sphinc','SA+PA+Sphinc+EP','ALL'});


%%
CP=aa(:,10)-aa(:,9);
EP=aa(:,10)-aa(:,8)-CP;
Sphincter=aa(:,10)-aa(:,7)-CP-EP;
Arteriols=aa(:,10)-aa(:,6)-CP-EP-Sphincter;
PAs=aa(:,10)-CP-EP-Sphincter-aa(:,2);
SAs=aa(:,2)-aa(:,1);
Basal=aa(:,1);
data =[Basal,SAs,PAs,Sphincter,EP,CP];
bar(data,'stacked')
%%
% Create the stacked bar chart
hBar = bar(data, 'stacked');

% Define a list of colors for each stack (column)
colors = [[57 106 177]./255;  % Color for Basal (e.g., blue)
          [83 81 84]./255;  % Color for SAs (e.g., orange)
          [204 37 41]./255;  % Color for PAs (e.g., yellow)
          0.4940 0.1840 0.5560;  % Color for Sphincter (e.g., purple)
          0.4660 0.6740 0.1880;  % Color for EP (e.g., green)
          0.3010 0.7450 0.9330]; % Color for CP (e.g., light blue)

% Apply the colors to each stack
for i = 1:length(hBar)
    hBar(i).FaceColor = 'flat';
    hBar(i).CData = repmat(colors(i,:), size(data,1), 1);
end

% Add legend
legend('Basal', 'SAs', 'PAs', 'Sphincter', 'EP', 'CP', 'Location', 'best');

% Add labels and title as needed
xlabel('Groups');
ylabel('Values');
title('Stacked Bar Chart with Custom Colors');
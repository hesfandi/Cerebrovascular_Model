clc,clear all,close all
current_folder=pwd;
addpath(fullfile(current_folder,'..','Cerebrovascular model'));
addpath(fullfile(current_folder,'..','Hemodynamic_analysis'));
addpath(fullfile(current_folder,'..','Utilities'));
load('Graph_final.mat')

% [H,BC]=Cerebrovascularmodel();
BC(1,3)=40;
BC_init=BC;





D=H.Edges.D;
H_f=H;
G=H;

TZ1 = find(G.Edges.Type == 3);
TZ2 = find(G.Edges.Type == 4);
TZ3 = find(G.Edges.Type == 5);
Cap1=find( G.Edges.Type == 6);
Cap2=find( G.Edges.Type == 11);
Cap3=find( G.Edges.Type == 12);

Cap=find( G.Edges.Type == 6 | G.Edges.Type == 11 | G.Edges.Type == 12);
TZ=find( G.Edges.Type == 3 | G.Edges.Type == 4 | G.Edges.Type == 5);
sphinc=find(G.Edges.Type == 10);

%
ind4=Cap1;
ind_L1=ind4(G.Edges.ZEdges(ind4,1)> -210);
ind_L2=ind4(G.Edges.ZEdges(ind4,1)> -420 & G.Edges.ZEdges(ind4,1)<= -210);
ind_L3=ind4(G.Edges.ZEdges(ind4,1)> -630 & G.Edges.ZEdges(ind4,1)<= -420);
ind_L4=ind4( G.Edges.ZEdges(ind4,1)<= -630);



TZ1_L1=TZ1( G.Nodes.Z(G.Edges.EndNodes(TZ1,1))> -250);
TZ2_L1=TZ2( G.Nodes.Z(G.Edges.EndNodes(TZ2,1))> -250);
TZ3_L1=TZ3( G.Nodes.Z(G.Edges.EndNodes(TZ3,1))> -250);
sphinc_L1=sphinc(G.Nodes.Z(G.Edges.EndNodes(sphinc,1))> -600);

%
start_value = 2.4;
end_value = 8;
num_intervals = 15;
x=linspace(2.59,7.8,14);

% Calculate the interval width
interval_width = (end_value - start_value) / num_intervals;

% Calculate the boundaries for each interval
intervals_boundaries = start_value:interval_width:end_value;

% Create the vector f with the start points and the end of the last interval
f = intervals_boundaries;

%
ind5=Cap;
Param=input_Boas();
seg=[];
y=find(H.Edges.Type==2 & H.Edges.ZEdges==0);
first=[1,y(31:end)'];
last=find(H.Edges.Type==2 & H.Edges.ZEdges==-8.196428571428571e+02);
H=G;
consthd=0.4;
H.Edges.hd=ones(length(H.Edges.D),1)*consthd;
X_Edges=(H.Nodes.X(H.Edges.EndNodes(:,1))+H.Nodes.X(H.Edges.EndNodes(:,1)))/2;
PA1=find(H.Edges.Type==2 & H.Edges.ZEdges<-40 & X_Edges<100 );

for i=1:1
    BC(1,3)=40;
    [q1,nodpress,H,visco]=flow_Boas_new_vis(H,Param,BC(:,1),BC(:,2),BC(:,3),BC(:,4),[]); 
    seg=(nodpress(:,H.Edges.EndNodes(:,1)')+nodpress(:,H.Edges.EndNodes(:,2)'))/2;

    DD=(1./(H.Edges.D.^2));
    V=(q1.*DD')*21.2;
    wss=visco.*abs(q1)./((H.Edges.D').^3);
    std(wss(PA1))
    ratio=wss(first)./wss(last);
    diam_cap=H.Edges.D(ind5);
    V_cap=abs(V(ind5));
    D_ind1=find(diam_cap<f(1));
    D_ind2=find(diam_cap<f(2)& diam_cap>f(1));
    D_ind3=find(diam_cap<f(3)& diam_cap>f(2));
    D_ind4=find(diam_cap<f(4)& diam_cap>f(3));
    D_ind5=find(diam_cap<f(5)& diam_cap>f(4));
    D_ind6=find(diam_cap<f(6)& diam_cap>f(5));
    D_ind7=find(diam_cap<f(7)& diam_cap>f(6));
    D_ind8=find(diam_cap<f(8)& diam_cap>f(7));
    D_ind9=find(diam_cap<f(9)& diam_cap>f(8));
    D_ind10=find(diam_cap<f(10)& diam_cap>f(9));
    D_ind11=find(diam_cap<f(11)& diam_cap>f(10));
    D_ind12=find(diam_cap<f(12)& diam_cap>f(11));
    D_ind13=find(diam_cap<f(13)& diam_cap>f(12));
    D_ind14=find(diam_cap<f(14)& diam_cap>f(13));
    D_ind15=find(diam_cap<f(15)& diam_cap>f(14));
    D_ind16=find(diam_cap<f(16)& diam_cap>f(15));
    

end
%     plotcolor(H, abs(V)', 'pressure', [0 6], G.Edges.D/4)

%
%%
t=1:4;
x=mean(abs(q1(Cap1)));
mm=[mean(abs(q1(ind_L1))),mean(abs(q1(ind_L2))),mean(abs(q1(ind_L3))),mean(abs(q1(ind_L4)))];
err=[std(abs(q1(ind_L1))),std(abs(q1(ind_L2))),std(abs(q1(ind_L3))),std(abs(q1(ind_L4)))];
segg=abs((nodpress(:,H.Edges.EndNodes(:,1)')+nodpress(:,H.Edges.EndNodes(:,2)')))/2;
H.Edges.ctl=segg'/(segg(19));
Z_Edges=(H.Nodes.Z(H.Edges.EndNodes(:,1))+H.Nodes.Z(H.Edges.EndNodes(:,1)))/2;
X_Edges=(H.Nodes.X(H.Edges.EndNodes(:,1))+H.Nodes.X(H.Edges.EndNodes(:,1)))/2;
Y_Edges=(H.Nodes.Y(H.Edges.EndNodes(:,1))+H.Nodes.Y(H.Edges.EndNodes(:,1)))/2;
Plot_seg=find( X_Edges<-50 | X_Edges>40 | Y_Edges>200);
G = rmedge(H,Plot_seg);
% plotcolor2(G,G.Edges.ctl, 'Relative contractility', [0.4 1.2], 25*ones(1,length(G.Edges.D)));
% plotcolor2(G,G.Edges.ctl, 'Relative contractility', [0.2 1.2], 2*G.Edges.D);
CubicSplineNetworkNew(G,G.Edges.ctl, []);


%% non-optimized network

[H,BC]=Cerebrovascularmodel_non_optimzed();

G=H;
art = find(G.Edges.Type == 2);
piart=find(G.Edges.Type == 7);
pivein= find(G.Edges.Type == 8);
ven = find(G.Edges.Type == 1);
TZ1 = find(G.Edges.Type == 3);
TZ2 = find(G.Edges.Type == 4);
TZ3 = find(G.Edges.Type == 5);
Cap1=find( G.Edges.Type == 6);
Cap2=find( G.Edges.Type == 11);
Cap3=find( G.Edges.Type == 12);

Cap=find( G.Edges.Type == 6 | G.Edges.Type == 11 | G.Edges.Type == 12);
TZ=find( G.Edges.Type == 3 | G.Edges.Type == 4 | G.Edges.Type == 5);
sphinc=find(G.Edges.Type == 10);

%
ind4=Cap1;
%%
ind_L1=ind4( G.Nodes.Z(G.Edges.EndNodes(ind4,1))> -250);
ind_L2=ind4( G.Nodes.Z(G.Edges.EndNodes(ind4,1))> -500 & G.Nodes.Z(G.Edges.EndNodes(ind4,2))< -250);
ind_L3=ind4( G.Nodes.Z(G.Edges.EndNodes(ind4,1))> -750 & G.Nodes.Z(G.Edges.EndNodes(ind4,2))< -500);
ind_L4=ind4( G.Nodes.Z(G.Edges.EndNodes(ind4,1))> -1000 & G.Nodes.Z(G.Edges.EndNodes(ind4,2))< -800);

Param=input_Boas();

H=G;
consthd=0.372;
H.Edges.hd=ones(length(H.Edges.D),1)*consthd;

BC(1,3)=40;
for i=1:1
%     [H,BC]=Build_Simple_small_Network_deep2();
    [q2,nodpress,H,visco]=flow_Boas_new_vis(H,Param,BC(:,1),BC(:,2),BC(:,3),BC(:,4),[]); 
    seg2=(nodpress(:,H.Edges.EndNodes(:,1)')+nodpress(:,H.Edges.EndNodes(:,2)'))/2;
    DD=(1./(H.Edges.D.^2));
    V2=(q2.*DD')*21.2;
    
end
%     plotcolor(H, abs(V)', 'pressure', [0 6], G.Edges.D/4)

%%


mm2=[mean(abs(q2(ind_L1))),mean(abs(q2(ind_L2))),mean(abs(q2(ind_L3))),mean(abs(q2(ind_L4)))];
err2=[std(abs(q2(ind_L1))),std(abs(q2(ind_L2))),std(abs(q2(ind_L3))),std(abs(q2(ind_L4)))];



%%
figure('Color',[1 1 1]);
axes1 = axes;
hold(axes1,'on');
h1=errorbar(t,mm2,err2,'DisplayName','scenario 2','MarkerSize',8,...
    'Marker','o',...
    'LineWidth',2,...
    "MarkerEdgeColor","b",'Color',[0 0 1]);
h2=errorbar(t,mm,err,'DisplayName','scenario 1','MarkerSize',8,...
    'Marker','square',...
    'LineWidth',2,...
    "MarkerEdgeColor","r",'Color',[1 0 0]);


xlim([0 5])

ylabel({'Capillary blood flow (nl/min)'},'FontWeight','bold','FontSize',14);
xlabel('Vascular layers','FontWeight','bold','FontSize',14);
hold(axes1,'off');
set(axes1,'FontSize',14,'FontWeight','bold','LineWidth',1,'XTick',[1 2 3 4 5],'XTickLabel',{'L1','L2','L3','L4'},'XTickLabelRotation',0)

% Manually define the legend
% lgd = legend([h2, h1], {'scenario 1', 'scenario 2'});  % Correct order and labels
% 
% set(lgd,...
%     'Position',[0.472511657199937 0.792403781322734 0.236013981637421 0.0997854050392757]);
% 
% 
% filename = 'Cortical_depth.png'; % Name of the file
% print(gcf, filename, '-dpng', '-r500'); % Save as PNG at 300 DPI
clc, close all,clear all
load('Graph_final.mat')
current_folder=pwd;
addpath(fullfile(current_folder,'..','Cerebrovascular model'));
addpath(fullfile(current_folder,'..','Hemodynamic_analysis'));
addpath(fullfile(current_folder,'..','Utilities'));
BC_init=BC;
G=H;
art = find(G.Edges.Type == 2);
piart=find(G.Edges.Type == 7);
pivein= find(G.Edges.Type == 8);
ven = find(G.Edges.Type == 1);
TZ1 = find(G.Edges.Type == 3);
TZ2 = find(G.Edges.Type == 4);
TZ3 = find(G.Edges.Type == 5);
Cap1=find( G.Edges.Type == 6 );
Cap2=find( G.Edges.Type == 11);
Cap3=find( G.Edges.Type == 12);
sphinc=find(G.Edges.Type == 10);
Conv_Cap=find( G.Edges.Type == 11 | G.Edges.Type == 12);
Cap=find(G.Edges.Type == 6 |  G.Edges.Type == 11 | G.Edges.Type == 12);
TZ=find(H.Edges.Type == 3 | H.Edges.Type == 4 |H.Edges.Type == 5);

%
ind4=find( G.Edges.Type == 6);

%%
Param=input_Boas();
BC(1,3)=40;
[q,nodpress,~,vis]=flow_Boas_new_vis(H,Param,BC(:,1),BC(:,2),BC(:,3),BC(:,4),[]);
seg=(nodpress(:,H.Edges.EndNodes(:,1)')+nodpress(:,H.Edges.EndNodes(:,2)'))/2;
H.Edges.ctl=seg'/(seg(19));
H.Edges.ctl(Cap)=H.Edges.ctl(Cap);
G=H;



P_BC=[40 50 60 70 80 90,100,110,120,130];

%sloped HRCTF
MT=[0 -0.091 -0.152 -0.196 -0.2272  -0.249 -0.268 -0.282 -0.291 -0.30];

%flat
%MT=[0 -0.091 -0.152 -0.196 -0.2292  -0.257 -0.2815 -0.3022 -0.3195 -0.3355];
%%

WSS=zeros(length(P_BC),length(H.Edges.D));
WT=zeros(length(P_BC),length(H.Edges.D));
V_all=zeros(length(P_BC),length(H.Edges.D));
Q_all=zeros(length(P_BC),length(H.Edges.D));
IP_all=zeros(length(P_BC),length(H.Edges.D));
D_all=zeros(length(P_BC),length(H.Edges.D));
V_cap_mean=zeros(1,length(P_BC));
Q_cap_mean=zeros(1,length(P_BC));
Hema_all=zeros(length(P_BC),length(H.Edges.D));


WSS_S=zeros(length(P_BC),length(H.Edges.D));
WT_S=zeros(length(P_BC),length(H.Edges.D));
V_all_S=zeros(length(P_BC),length(H.Edges.D));
Q_all_S=zeros(length(P_BC),length(H.Edges.D));
IP_all_S=zeros(length(P_BC),length(H.Edges.D));
D_all_S=zeros(length(P_BC),length(H.Edges.D));
V_cap_mean_S=zeros(1,length(P_BC));
Q_cap_mean_S=zeros(1,length(P_BC));
Hema_all_S=zeros(length(P_BC),length(H.Edges.D));


WSS_S0=zeros(length(P_BC),length(H.Edges.D));
WT_S0=zeros(length(P_BC),length(H.Edges.D));
V_all_S0=zeros(length(P_BC),length(H.Edges.D));
Q_all_S0=zeros(length(P_BC),length(H.Edges.D));
IP_all_S0=zeros(length(P_BC),length(H.Edges.D));
D_all_S0=zeros(length(P_BC),length(H.Edges.D));
V_cap_mean_S0=zeros(1,length(P_BC));
Q_cap_mean_S0=zeros(1,length(P_BC));
Hema_all_S0=zeros(length(P_BC),length(H.Edges.D));



WSS_S1=zeros(length(P_BC),length(H.Edges.D));
WT_S1=zeros(length(P_BC),length(H.Edges.D));
V_all_S1=zeros(length(P_BC),length(H.Edges.D));
Q_all_S1=zeros(length(P_BC),length(H.Edges.D));
IP_all_S1=zeros(length(P_BC),length(H.Edges.D));
D_all_S1=zeros(length(P_BC),length(H.Edges.D));
V_cap_mean_S1=zeros(1,length(P_BC));
Q_cap_mean_S1=zeros(1,length(P_BC));
Hema_all_S1=zeros(length(P_BC),length(H.Edges.D));

WSS_S2=zeros(length(P_BC),length(H.Edges.D));
WT_S2=zeros(length(P_BC),length(H.Edges.D));
V_all_S2=zeros(length(P_BC),length(H.Edges.D));
Q_all_S2=zeros(length(P_BC),length(H.Edges.D));
IP_all_S2=zeros(length(P_BC),length(H.Edges.D));
D_all_S2=zeros(length(P_BC),length(H.Edges.D));
V_cap_mean_S2=zeros(1,length(P_BC));
Q_cap_mean_S2=zeros(1,length(P_BC));
Hema_all_S2=zeros(length(P_BC),length(H.Edges.D));

WSS_S3=zeros(length(P_BC),length(H.Edges.D));
WT_S3=zeros(length(P_BC),length(H.Edges.D));
V_all_S3=zeros(length(P_BC),length(H.Edges.D));
Q_all_S3=zeros(length(P_BC),length(H.Edges.D));
IP_all_S3=zeros(length(P_BC),length(H.Edges.D));
D_all_S3=zeros(length(P_BC),length(H.Edges.D));
V_cap_mean_S3=zeros(1,length(P_BC));
Q_cap_mean_S3=zeros(1,length(P_BC));
Hema_all_S3=zeros(length(P_BC),length(H.Edges.D));


WSS_S4=zeros(length(P_BC),length(H.Edges.D));
WT_S4=zeros(length(P_BC),length(H.Edges.D));
V_all_S4=zeros(length(P_BC),length(H.Edges.D));
Q_all_S4=zeros(length(P_BC),length(H.Edges.D));
IP_all_S4=zeros(length(P_BC),length(H.Edges.D));
D_all_S4=zeros(length(P_BC),length(H.Edges.D));
V_cap_mean_S4=zeros(1,length(P_BC));
Q_cap_mean_S4=zeros(1,length(P_BC));
Hema_all_S4=zeros(length(P_BC),length(H.Edges.D));


WSS_S5=zeros(length(P_BC),length(H.Edges.D));
WT_S5=zeros(length(P_BC),length(H.Edges.D));
V_all_S5=zeros(length(P_BC),length(H.Edges.D));
Q_all_S5=zeros(length(P_BC),length(H.Edges.D));
IP_all_S5=zeros(length(P_BC),length(H.Edges.D));
D_all_S5=zeros(length(P_BC),length(H.Edges.D));
Q_cap_mean_S5=zeros(1,length(P_BC));
V_cap_mean_S5=zeros(1,length(P_BC));
Hema_all_S5=zeros(length(P_BC),length(H.Edges.D));


WSS_S6=zeros(length(P_BC),length(H.Edges.D));
WT_S6=zeros(length(P_BC),length(H.Edges.D));
V_all_S6=zeros(length(P_BC),length(H.Edges.D));
Q_all_S6=zeros(length(P_BC),length(H.Edges.D));
IP_all_S6=zeros(length(P_BC),length(H.Edges.D));
D_all_S6=zeros(length(P_BC),length(H.Edges.D));
Q_cap_mean_S6=zeros(1,length(P_BC));
V_cap_mean_S6=zeros(1,length(P_BC));
Hema_all_S6=zeros(length(P_BC),length(H.Edges.D));


WSS_S7=zeros(length(P_BC),length(H.Edges.D));
WT_S7=zeros(length(P_BC),length(H.Edges.D));
V_all_S7=zeros(length(P_BC),length(H.Edges.D));
Q_all_S7=zeros(length(P_BC),length(H.Edges.D));
IP_all_S7=zeros(length(P_BC),length(H.Edges.D));
D_all_S7=zeros(length(P_BC),length(H.Edges.D));
Q_cap_mean_S7=zeros(1,length(P_BC));
V_cap_mean_S7=zeros(1,length(P_BC));
Hema_all_S7=zeros(length(P_BC),length(H.Edges.D));



WSS_S8=zeros(length(P_BC),length(H.Edges.D));
WT_S8=zeros(length(P_BC),length(H.Edges.D));
V_all_S8=zeros(length(P_BC),length(H.Edges.D));
Q_all_S8=zeros(length(P_BC),length(H.Edges.D));
IP_all_S8=zeros(length(P_BC),length(H.Edges.D));
D_all_S8=zeros(length(P_BC),length(H.Edges.D));
V_cap_mean_S8=zeros(1,length(P_BC));
Q_cap_mean_S8=zeros(1,length(P_BC));
Hema_all_S8=zeros(length(P_BC),length(H.Edges.D));



WSS_S9=zeros(length(P_BC),length(H.Edges.D));
WT_S9=zeros(length(P_BC),length(H.Edges.D));
V_all_S9=zeros(length(P_BC),length(H.Edges.D));
Q_all_S9=zeros(length(P_BC),length(H.Edges.D));
IP_all_S9=zeros(length(P_BC),length(H.Edges.D));
D_all_S9=zeros(length(P_BC),length(H.Edges.D));
V_cap_mean_S9=zeros(1,length(P_BC));
Q_cap_mean_S9=zeros(1,length(P_BC));
Hema_all_S9=zeros(length(P_BC),length(H.Edges.D));



WSS_S10=zeros(length(P_BC),length(H.Edges.D));
WT_S10=zeros(length(P_BC),length(H.Edges.D));
V_all_S10=zeros(length(P_BC),length(H.Edges.D));
Q_all_S10=zeros(length(P_BC),length(H.Edges.D));
IP_all_S10=zeros(length(P_BC),length(H.Edges.D));
D_all_S10=zeros(length(P_BC),length(H.Edges.D));
V_cap_mean_S10=zeros(1,length(P_BC));
Q_cap_mean_S10=zeros(1,length(P_BC));
Hema_all_S10=zeros(length(P_BC),length(H.Edges.D));

WSS_S11=zeros(length(P_BC),length(H.Edges.D));
WT_S11=zeros(length(P_BC),length(H.Edges.D));
V_all_S11=zeros(length(P_BC),length(H.Edges.D));
Q_all_S11=zeros(length(P_BC),length(H.Edges.D));
IP_all_S11=zeros(length(P_BC),length(H.Edges.D));
D_all_S11=zeros(length(P_BC),length(H.Edges.D));
V_cap_mean_S11=zeros(1,length(P_BC));
Q_cap_mean_S11=zeros(1,length(P_BC));
Hema_all_S11=zeros(length(P_BC),length(H.Edges.D));
%%
%% all
figure;
for i=1:length(P_BC)
    H.Edges.D=H.Edges.D+MT(i)*(H.Edges.D).*H.Edges.ctl;
    BC(1,3)=P_BC(i);
    [q,nodpress,K,vis]=flow_Boas_new_vis(H,Param,BC(:,1),BC(:,2),BC(:,3),BC(:,4),[]);
    seg=(nodpress(:,H.Edges.EndNodes(:,1)')+nodpress(:,H.Edges.EndNodes(:,2)'))/2;
    WT(i,:)=H.Edges.D'.*seg;
    DD=(1./(H.Edges.D.^2));
    V=(q.*DD')*21.2;
    V_cap_mean(i)=mean(abs(V(Cap1)));
    Q_cap_mean(i)=mean(abs(q(Cap1)));
%     plot(P_BC,Q_cap_mean);
%     hold on
    WSS(i,:)=vis.*32/pi.*abs(q)./((H.Edges.D)').^3;
    V_all(i,:)=abs(V);
    Q_all(i,:)=abs(q);
    IP_all(i,:)=abs(seg);
    D_all(i,:)=H.Edges.D';
    Hema_all(i,:)=K.Edges.hd';
    H.Edges.D=G.Edges.D;
end

%% PAs (S)
ind=[art];
for i=1:length(P_BC)
    H.Edges.D(ind)=H.Edges.D(ind)+MT(i)*(H.Edges.D(ind)).*H.Edges.ctl(ind);
    BC(1,3)=P_BC(i);
    [q,nodpress,K,vis]=flow_Boas_new_vis(H,Param,BC(:,1),BC(:,2),BC(:,3),BC(:,4),[]);
    seg=(nodpress(:,H.Edges.EndNodes(:,1)')+nodpress(:,H.Edges.EndNodes(:,2)'))/2;
    WT_S(i,:)=H.Edges.D'.*seg;
    DD=(1./(H.Edges.D.^2));
    V=(q.*DD')*21.2;
    V_cap_mean_S(i)=mean(abs(V(Cap1)));
    Q_cap_mean_S(i)=mean(abs(q(Cap1)));
    WSS_S(i,:)=vis.*32/pi.*abs(q)./((H.Edges.D)').^3;
    V_all_S(i,:)=abs(V);
    Q_all_S(i,:)=abs(q);
    IP_all_S(i,:)=abs(seg);
    D_all_S(i,:)=H.Edges.D';
    H.Edges.D=G.Edges.D;
    Hema_all_S(i,:)=K.Edges.hd';
end


%% Pials (S0)
ind=[piart];
for i=1:length(P_BC)
    H.Edges.D(ind)=H.Edges.D(ind)+MT(i)*(H.Edges.D(ind)).*H.Edges.ctl(ind);
    BC(1,3)=P_BC(i);
    [q,nodpress,K,vis]=flow_Boas_new_vis(H,Param,BC(:,1),BC(:,2),BC(:,3),BC(:,4),[]);
    seg=(nodpress(:,H.Edges.EndNodes(:,1)')+nodpress(:,H.Edges.EndNodes(:,2)'))/2;
    WT_S1(i,:)=H.Edges.D'.*seg;
    DD=(1./(H.Edges.D.^2));
    V=(q.*DD')*21.2;
    V_cap_mean_S0(i)=mean(abs(V(Cap1)));
    Q_cap_mean_S0(i)=mean(abs(q(Cap1)));
    WSS_S0(i,:)=vis.*32/pi.*abs(q)./((H.Edges.D)').^3;
    V_all_S0(i,:)=abs(V);
    Q_all_S0(i,:)=abs(q);
    IP_all_S0(i,:)=abs(seg);
    D_all_S0(i,:)=H.Edges.D';
    H.Edges.D=G.Edges.D;
    Hema_all_S0(i,:)=K.Edges.hd';
end


%% arteriols (S1)
ind=[piart;art];
for i=1:length(P_BC)
    H.Edges.D(ind)=H.Edges.D(ind)+MT(i)*(H.Edges.D(ind)).*H.Edges.ctl(ind);
    BC(1,3)=P_BC(i);
    [q,nodpress,K,vis]=flow_Boas_new_vis(H,Param,BC(:,1),BC(:,2),BC(:,3),BC(:,4),[]);
    seg=(nodpress(:,H.Edges.EndNodes(:,1)')+nodpress(:,H.Edges.EndNodes(:,2)'))/2;
    WT_S1(i,:)=H.Edges.D'.*seg;
    DD=(1./(H.Edges.D.^2));
    V=(q.*DD')*21.2;
    V_cap_mean_S1(i)=mean(abs(V(Cap1)));
    Q_cap_mean_S1(i)=mean(abs(q(Cap1)));
    WSS_S1(i,:)=vis.*32/pi.*abs(q)./((H.Edges.D)').^3;
    V_all_S1(i,:)=abs(V);
    Q_all_S1(i,:)=abs(q);
    IP_all_S1(i,:)=abs(seg);
    D_all_S1(i,:)=H.Edges.D';
    H.Edges.D=G.Edges.D;
    Hema_all_S1(i,:)=K.Edges.hd';
end


%%

%% arteriols and sphincters (S2)
ind=[piart;art;sphinc];
for i=1:length(P_BC)
    H.Edges.D(ind)=H.Edges.D(ind)+MT(i)*(H.Edges.D(ind)).*H.Edges.ctl(ind);
    BC(1,3)=P_BC(i);
    [q,nodpress,K,vis]=flow_Boas_new_vis(H,Param,BC(:,1),BC(:,2),BC(:,3),BC(:,4),[]);
    seg=(nodpress(:,H.Edges.EndNodes(:,1)')+nodpress(:,H.Edges.EndNodes(:,2)'))/2;
    WT_S2(i,:)=H.Edges.D'.*seg;
    DD=(1./(H.Edges.D.^2));
    V=(q.*DD')*21.2;
    V_cap_mean_S2(i)=mean(abs(V(Cap1)));
    Q_cap_mean_S2(i)=mean(abs(q(Cap1)));
    WSS_S2(i,:)=vis.*32/pi.*abs(q)./((H.Edges.D)').^3;
    V_all_S2(i,:)=abs(V);
    Q_all_S2(i,:)=abs(q);
    IP_all_S2(i,:)=abs(seg);
    D_all_S2(i,:)=H.Edges.D';
    H.Edges.D=G.Edges.D;
    Hema_all_S2(i,:)=K.Edges.hd';
end


%% arteriols and sphincters and TZs (S3)
ind=[piart;art;sphinc;TZ];
for i=1:length(P_BC)
    H.Edges.D(ind)=H.Edges.D(ind)+MT(i)*(H.Edges.D(ind)).*H.Edges.ctl(ind);
    BC(1,3)=P_BC(i);
    [q,nodpress,~,vis]=flow_Boas_new_vis(H,Param,BC(:,1),BC(:,2),BC(:,3),BC(:,4),[]);
    seg=(nodpress(:,H.Edges.EndNodes(:,1)')+nodpress(:,H.Edges.EndNodes(:,2)'))/2;
    WT_S3(i,:)=H.Edges.D'.*seg;
    DD=(1./(H.Edges.D.^2));
    V=(q.*DD')*21.2;
    V_cap_mean_S3(i)=mean(abs(V(Cap1)));
    Q_cap_mean_S3(i)=mean(abs(q(Cap1)));
    WSS_S3(i,:)=vis.*32/pi.*abs(q)./((H.Edges.D)').^3;
    V_all_S3(i,:)=abs(V);
    Q_all_S3(i,:)=abs(q);
    IP_all_S3(i,:)=abs(seg);
    D_all_S3(i,:)=H.Edges.D';
    H.Edges.D=G.Edges.D;
    Hema_all_S3(i,:)=K.Edges.hd';
end

%% +10% miscalibration 

for i=1:length(P_BC)
    H.Edges.D=H.Edges.D+MT(i)*1.1*(H.Edges.D).*H.Edges.ctl;
    BC(1,3)=P_BC(i);
    [q,nodpress,K,vis]=flow_Boas_new_vis(H,Param,BC(:,1),BC(:,2),BC(:,3),BC(:,4),[]);
    seg=(nodpress(:,H.Edges.EndNodes(:,1)')+nodpress(:,H.Edges.EndNodes(:,2)'))/2;
    WT_S4(i,:)=H.Edges.D'.*seg;
    DD=(1./(H.Edges.D.^2));
    V=(q.*DD')*21.2;
    V_cap_mean_S4(i)=mean(abs(V(Cap1)));
    WSS_S4(i,:)=vis.*32/pi.*abs(q)./((H.Edges.D)').^3;
    V_all_S4(i,:)=abs(V);
    Q_all_S4(i,:)=abs(q);
    Q_cap_mean_S4(i)=mean(abs(q(Cap1)));
    IP_all_S4(i,:)=abs(seg);
    D_all_S4(i,:)=H.Edges.D';
    Hema_all_S4(i,:)=K.Edges.hd';
    H.Edges.D=G.Edges.D;
end

%% -10% miscalibration 

for i=1:length(P_BC)
    H.Edges.D=H.Edges.D+MT(i)*0.9*(H.Edges.D).*H.Edges.ctl;
    BC(1,3)=P_BC(i);
    [q,nodpress,K,vis]=flow_Boas_new_vis(H,Param,BC(:,1),BC(:,2),BC(:,3),BC(:,4),[]);
    seg=(nodpress(:,H.Edges.EndNodes(:,1)')+nodpress(:,H.Edges.EndNodes(:,2)'))/2;
    WT_S5(i,:)=H.Edges.D'.*seg;
    DD=(1./(H.Edges.D.^2));
    V=(q.*DD')*21.2;
    V_cap_mean_S5(i)=mean(abs(V(Cap1)));
    Q_cap_mean_S5(i)=mean(abs(q(Cap1)));
    WSS_S5(i,:)=vis.*32/pi.*abs(q)./((H.Edges.D)').^3;
    V_all_S5(i,:)=abs(V);
    Q_all_S5(i,:)=abs(q);
    IP_all_S5(i,:)=abs(seg);
    D_all_S5(i,:)=H.Edges.D';
    Hema_all_S5(i,:)=K.Edges.hd';
    H.Edges.D=G.Edges.D;
end


%% +20% miscalibration (S6)

for i=1:length(P_BC)
    H.Edges.D=H.Edges.D+MT(i)*1.2*(H.Edges.D).*H.Edges.ctl;
    BC(1,3)=P_BC(i);
    [q,nodpress,K,vis]=flow_Boas_new_vis(H,Param,BC(:,1),BC(:,2),BC(:,3),BC(:,4),[]);
    seg=(nodpress(:,H.Edges.EndNodes(:,1)')+nodpress(:,H.Edges.EndNodes(:,2)'))/2;
    WT_S6(i,:)=H.Edges.D'.*seg;
    DD=(1./(H.Edges.D.^2));
    V=(q.*DD')*21.2;
    V_cap_mean_S6(i)=mean(abs(V(Cap1)));
    Q_cap_mean_S6(i)=mean(abs(q(Cap1)));
    WSS_S6(i,:)=vis.*32/pi.*abs(q)./((H.Edges.D)').^3;
    V_all_S6(i,:)=abs(V);
    Q_all_S6(i,:)=abs(q);
    IP_all_S6(i,:)=abs(seg);
    D_all_S6(i,:)=H.Edges.D';
    Hema_all_S6(i,:)=K.Edges.hd';
    H.Edges.D=G.Edges.D;
end

%% -20% miscalibration (S7)

for i=1:length(P_BC)
    H.Edges.D=H.Edges.D+MT(i)*0.8*(H.Edges.D).*H.Edges.ctl;
    BC(1,3)=P_BC(i);
    [q,nodpress,K,vis]=flow_Boas_new_vis(H,Param,BC(:,1),BC(:,2),BC(:,3),BC(:,4),[]);
    seg=(nodpress(:,H.Edges.EndNodes(:,1)')+nodpress(:,H.Edges.EndNodes(:,2)'))/2;
    WT_S7(i,:)=H.Edges.D'.*seg;
    DD=(1./(H.Edges.D.^2));
    V=(q.*DD')*21.2;
    V_cap_mean_S7(i)=mean(abs(V(Cap1)));
    Q_cap_mean_S7(i)=mean(abs(q(Cap1)));
    WSS_S7(i,:)=vis.*32/pi.*abs(q)./((H.Edges.D)').^3;
    V_all_S7(i,:)=abs(V);
    Q_all_S7(i,:)=abs(q);
    IP_all_S7(i,:)=abs(seg);
    D_all_S7(i,:)=H.Edges.D';
    Hema_all_S7(i,:)=K.Edges.hd';
    H.Edges.D=G.Edges.D;
end


%% None (S8)

for i=1:length(P_BC)
    H.Edges.D=H.Edges.D;
    BC(1,3)=P_BC(i);
    [q,nodpress,K,vis]=flow_Boas_new_vis(H,Param,BC(:,1),BC(:,2),BC(:,3),BC(:,4),[]);
    seg=(nodpress(:,H.Edges.EndNodes(:,1)')+nodpress(:,H.Edges.EndNodes(:,2)'))/2;
    WT_S8(i,:)=H.Edges.D'.*seg;
    DD=(1./(H.Edges.D.^2));
    V=(q.*DD')*21.2;
    V_cap_mean_S8(i)=mean(abs(V(Cap1)));
    Q_cap_mean_S8(i)=mean(abs(q(Cap1)));
    WSS_S8(i,:)=vis.*32/pi.*abs(q)./((H.Edges.D)').^3;
    V_all_S8(i,:)=abs(V);
    Q_all_S8(i,:)=abs(q);
    IP_all_S8(i,:)=abs(seg);
    D_all_S8(i,:)=H.Edges.D';
    Hema_all_S8(i,:)=K.Edges.hd';
    H.Edges.D=G.Edges.D;
end


%%
%% TZ (S9)

ind=[TZ];
for i=1:length(P_BC)
    H.Edges.D(ind)=H.Edges.D(ind)+MT(i)*(H.Edges.D(ind)).*H.Edges.ctl(ind);
    BC(1,3)=P_BC(i);
    [q,nodpress,K,vis]=flow_Boas_new_vis(H,Param,BC(:,1),BC(:,2),BC(:,3),BC(:,4),[]);
    seg=(nodpress(:,H.Edges.EndNodes(:,1)')+nodpress(:,H.Edges.EndNodes(:,2)'))/2;
    WT_S9(i,:)=H.Edges.D'.*seg;
    DD=(1./(H.Edges.D.^2));
    V=(q.*DD')*21.2;
    V_cap_mean_S9(i)=mean(abs(V(Cap1)));
    Q_cap_mean_S9(i)=mean(abs(q(Cap1)));
    WSS_S9(i,:)=vis.*32/pi.*abs(q)./((H.Edges.D)').^3;
    V_all_S9(i,:)=abs(V);
    Q_all_S9(i,:)=abs(q);
    IP_all_S9(i,:)=abs(seg);
    D_all_S9(i,:)=H.Edges.D';
    Hema_all_S9(i,:)=K.Edges.hd';
    H.Edges.D=G.Edges.D;
end


%% Cap (S10)

ind=[Cap];
for i=1:length(P_BC)
    H.Edges.D(ind)=H.Edges.D(ind)+MT(i)*(H.Edges.D(ind)).*H.Edges.ctl(ind);
    BC(1,3)=P_BC(i);
    [q,nodpress,K,vis]=flow_Boas_new_vis(H,Param,BC(:,1),BC(:,2),BC(:,3),BC(:,4),[]);
    seg=(nodpress(:,H.Edges.EndNodes(:,1)')+nodpress(:,H.Edges.EndNodes(:,2)'))/2;
    WT_S10(i,:)=H.Edges.D'.*seg;
    DD=(1./(H.Edges.D.^2));
    V=(q.*DD')*21.2;
    V_cap_mean_S10(i)=mean(abs(V(Cap1)));
    Q_cap_mean_S10(i)=mean(abs(q(Cap1)));
    WSS_S10(i,:)=vis.*32/pi.*abs(q)./((H.Edges.D)').^3;
    V_all_S10(i,:)=abs(V);
    Q_all_S10(i,:)=abs(q);
    IP_all_S10(i,:)=abs(seg);
    D_all_S10(i,:)=H.Edges.D';
    Hema_all_S10(i,:)=K.Edges.hd';
    H.Edges.D=G.Edges.D;
end

%% Sphincters (S11)

ind=[sphinc];
for i=1:length(P_BC)
    H.Edges.D(ind)=H.Edges.D(ind)+MT(i)*(H.Edges.D(ind)).*H.Edges.ctl(ind);
    BC(1,3)=P_BC(i);
    [q,nodpress,K,vis]=flow_Boas_new_vis(H,Param,BC(:,1),BC(:,2),BC(:,3),BC(:,4),[]);
    seg=(nodpress(:,H.Edges.EndNodes(:,1)')+nodpress(:,H.Edges.EndNodes(:,2)'))/2;
    WT_S11(i,:)=H.Edges.D'.*seg;
    DD=(1./(H.Edges.D.^2));
    V=(q.*DD')*21.2;
    V_cap_mean_S11(i)=mean(abs(V(Cap1)));
    Q_cap_mean_S11(i)=mean(abs(q(Cap1)));
    WSS_S11(i,:)=vis.*32/pi.*abs(q)./((H.Edges.D)').^3;
    V_all_S11(i,:)=abs(V);
    Q_all_S11(i,:)=abs(q);
    IP_all_S11(i,:)=abs(seg);
    D_all_S11(i,:)=H.Edges.D';
    Hema_all_S11(i,:)=K.Edges.hd';
    H.Edges.D=G.Edges.D;
end
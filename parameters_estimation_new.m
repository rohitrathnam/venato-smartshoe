% PARAMETERS ESTIMATION

clear all
clc
close all

%% data loading --> modify this part 
table = readtable("walking.csv");  %file including gyro and accel data
data = table2array(table); 

%% variables preparation
%Right 
acc_R=data(:,1:3)*9.81; %conversion of acceleration from g to m/s^2
gyr_R=deg2rad(data(:,4:6)); %conversion of angular velocity from deg to rad

%Left  
acc_L=data(:,7:9)*9.81; %conversion of acceleration from g to m/s^2
gyr_L=deg2rad(data(:,10:12)); %conversion of angular velocity from deg to rad

%Time vector
fs =119;  %(write the correct sampling frequence)
time=(1:length(acc_R))/fs;

%% data calibration

load coeff_calibr;

acc_R = MULTIPROD(Cs_acc0,(acc_R(:,1)-a0_acc0')');
acc_L = MULTIPROD(Cs_acc1,(acc_R(:,1)-a0_acc1')');

gyr_R = MULTIPROD(Cs_gyr0,(gyr_R - w0_gyr0')' )';
gyr_L = MULTIPROD(Cs_gyr1,(gyr_L - w0_gyr1')' )';


%% anatomical orientation
acc_L = [acc_L(:,1), acc_L(:,3),acc_L(:,1)]; %V  ML  AP
acc_R = [acc_R(:,1),-acc_R(:,3),acc_R(:,2)]; 
gyr_L = [gyr_L(:,1),gyr_L(:,3),gyr_L(:,1)]; 
gyr_R = [gyr_R(:,1),-gyr_R(:,3),gyr_R(:,2)];


%% orientation of the data in the global reference system 

%Quaternions 
fuse = imufilter('SampleRate',fs,'DecimationFactor',1); %decide decimation factor
[orientation_R,angularVel_R] = fuse(acc_R,gyr_R);
[orientation_L,angularVel_L] = fuse(acc_L,gyr_L);

orient_R = compact(orientation_R);
orient_L = compact(orientation_L);

Acc_gL = quatrotate(orient_L,acc_L);
Acc_gR = quatrotate(orient_R,acc_R);

 % gravity removal
 AgfreeR=Acc_gR+[0,0,-9.81]; 
 AgfreeL=Acc_gL+[0,0,-9.81]; 

%% Gait events estimation

% take into account the mirror orientation of the sensors 
acc_L=[acc_L(:,1),-acc_L(:,2),acc_L(:,3)];
gyr_L=[gyr_L(:,1),gyr_L(:,2),-gyr_L(:,3)];

% IC and FC estimation 
% --> 1xN vectors containing initial and final contacts for both feet
[IC_L, FC_L, IC_R, FC_R] = IC_FC_estimation(acc_L,gyr_L,acc_R,gyr_R,fs);

%% stride duration estimation (TEMPORAL PARAMETERS)

Str_Dur_L=[];
    for i=1:length(IC_L)-1
        Str_Dur_L=[Str_Dur_L abs(IC_L(i)-IC_L(i+1))/128]; 
    end
    
Str_Dur_R=[];
    for i=1:length(IC_R)-1
        Str_Dur_R=[Str_Dur_R abs(IC_R(i)-IC_R(i+1))/128]; 
    end


%% stance phase estimation
stance_L=[];
 for i=1:length(IC_L)
        stance_L=[stance_L abs(FC_L(i)-IC_L(i))/128]; 
 end
    
 stance_R=[];
 for i=1:length(IC_R)
        stance_R=[stance_R abs(FC_R(i)-IC_R(i))/128]; 
    end


%% swing phase estimation

swing_L=[];
 for i=1:length(IC_L)-1
        swing_L=[swing_L abs(IC_L(i+1)-FC_L(i))/128]; 
 end
    
 swing_R=[];
 for i=1:length(IC_R)-1
        swing_R=[swing_R abs(IC_R(i+1)-FC_R(i))/128]; 
 end

 % we can also compute midstance(40%GC) and midswing(75%GC) phases
    
%% Displacement estimation along the direction of progression (SPATIAL PARAMETERS)

% reorientation of the data
acc_L=[acc_L(:,1),-acc_L(:,2),acc_L(:,3)];
gyr_L=[gyr_L(:,1),gyr_L(:,2),-gyr_L(:,3)];

% Disp_estimate is a function used to estimate the integration instants (SP),
% remove the gravity, reorientate along the DoP, apply the inverse
% pendulum and finally estimate velocity (VelDRI) and displacement (DISPL)

[DISPL_L, VelDRI_L, SP_L, Acc_g_L]=Disp_estimate(IC_L,FC_L, AgfreeL,gyr_L,fs);
[DISPL_R, VelDRI_R, SP_R, Acc_g_R]=Disp_estimate(IC_R,FC_R, AgfreeR,gyr_R,fs);


%% Stride length estimation

for i=1:length(SP_R)-1   % right
    SL_R(i)=max(DISPL_R((SP_R(i):SP_R(i+1)-1),1)); 
end

for i=1:length(SP_L)-1  % left
    SL_L(i)=max(DISPL_L((SP_L(i):SP_L(i+1)-1),1));    
end

%% Stride velocity estimation

for i=1:length(SP_R)-1   % right
    SV_R(i)=SL_R(i)/((SP_R(i+1)-SP_R(i))/fs);
end

for i=1:length(SP_L)-1  % left
    SV_L(i)=SL_L(i)/((SP_L(i+1)-SP_L(i))/fs);
end

%% Plot temporal parameters

%plot stride duration 
figure
subplot(121);plot(Str_Dur_L, '*'); title('Stride duration - Left'), ylim([0 5]);
xlabel('stride (#)'), ylabel('stride duration (s)'); 
subplot(122);plot(Str_Dur_R, '*'); title('Stride duration - Right'), ylim([0 5]);
xlabel('stride (#)'), ylabel('stride duration (s)'); 
sgtitle('Stride duration');

%plot stance time
figure
subplot(121);plot(stance_L, '*'); title('Stance duration - Left'), ylim([0 3]);
xlabel('stride (#)'), ylabel('stance duration (s)'); 
subplot(122);plot(stance_R, '*'); title('Stance duration - Right'), ylim([0 3]);
xlabel('stride (#)'), ylabel('stance duration (s)'); 
sgtitle('Stance duration');

%plot swing time 
figure
subplot(121);plot(swing_L, '*'); title('Swing duration - Left'), ylim([0 3]);
xlabel('stride (#)'), ylabel('swing duration (s)'); 
subplot(122);plot(swing_R, '*'); title('Swing duration - Right'), ylim([0 3]);
xlabel('stride (#)'), ylabel('swing duration (s)'); 
sgtitle('Swing duration');

%% Plot spatial parameters

%plot speed and displacement resulting from integration
figure
plot(VelDRI_L(:,1),'b'); hold on; plot(VelDRI_L(:,2),'g'); hold on; plot(VelDRI_L(:,3),'r');
xlabel ('Samples (#)'); ylabel ('Velocity (m/s)'); 
title('Velocity (Left side)'); legend('AP', 'ML', 'V');
figure
plot(DISPL_L(:,1),'b'); hold on; plot(DISPL_L(:,2),'g'); hold on; plot(DISPL_L(:,3),'r'); 
xlabel ('Samples (#)'); ylabel ('Displacement (m)'); 
title('Displacement (Left side)'); legend('AP', 'ML', 'V');
hold off

%plot stride length 
figure
subplot(121);plot(SL_L, '*'); title('Stride lenght - Left'), ylim([0 8]); 
xlabel('stride (#)'), ylabel('Stride lenght (m)'); 
subplot(122);plot(SL_R, '*'); title('Stride lenght - Right'), ylim([0 8]); 
xlabel('stride (#)'), ylabel('Stride lenght (m)'); 

%plot stride velocity 
figure
subplot(121);plot(SV_L, '*'); title('Stride velocity - Left'), ylim([0 8]); 
xlabel('stride (#)'), ylabel('Stride velocity (m)'); 
subplot(122);plot(SV_R, '*'); title('Stride velocity - Right'), ylim([0 8]); 
xlabel('stride (#)'), ylabel('Stride velocity (m)'); 

%% creation of a table with the average of all the parameters 

SV_mean= mean([SV_L SV_R]);
SL_mean= mean([SL_L SL_R]);
Str_Dur_mean= mean([Str_Dur_L Str_Dur_R]);
stance_mean= mean([stance_L stance_R]);
swing_mean= mean([swing_L swing_R]);
SV_mean= mean([SV_L SV_R]);

Tytle = " CLINICAL REPORT ";
subject = "patient: ... ";
velocity = ["Gait velocity (m/s):" SV_mean] ;
stride_t = ["Stride time (s): " Str_Dur_mean ];
stance = ["Stance time (s): " stance_mean];
swing = ["Swing time(s): " swing_mean ];
stride_l = ["Stride lenght (m): " SL_mean ];

A = {Tytle; subject; velocity; stride_t; stance; swing; stride_l};
writecell(A,'Clinical_Report1.txt','Delimiter', '\t');  % in .txt format
%writecell(A,'Clinical_Report1.dat');  % in .dat format
%writecell(A,'Clinical_Report1.xls');  % in .xls format

% SPATIAL PARAMETERS ESTIMATION

clear all
clc
close all

%% data loading 
load('IMU'); %file including gyro and accel data

%% variables preparation
%Right 
acc_R=IMU.Right.acc*9.81; %conversion of acceleration from g to m/s^2
gyr_R=deg2rad(IMU.Right.gyr); %conversion of angular velocity from deg to rad

%Left  
acc_L=IMU.Left.acc*9.81; %conversion of acceleration from g to m/s^2
gyr_L=deg2rad(IMU.Left.gyr); %conversion of angular velocity from deg to rad

%orientation of the data in the local refernce of the sensor

%...
%...

%Time vector
fs=128;  %(write the correct sampling frequence)
time=(1:length(acc_R))/fs; 

%% Gait events estimation

% take into account the mirror orientation of the sensors (???)
acc_L=[acc_L(:,1),-acc_L(:,2),acc_L(:,3)];
gyr_L=[gyr_L(:,1),gyr_L(:,2),-gyr_L(:,3)];

% IC and FC estimation 
% --> 1xN vectors containing initial and final contacts for both feet
[IC_L, FC_L, IC_R, FC_R] = IC_FC_estimation(acc_L,gyr_L,acc_R,gyr_R,fs);

%% Displacement estimation along the direction of progression 

% reorientation of the data
acc_L=[acc_L(:,1),-acc_L(:,2),acc_L(:,3)];
gyr_L=[gyr_L(:,1),gyr_L(:,2),-gyr_L(:,3)];

% Disp_estimate is a function used to estimate the integration instants (SP),
% remove the gravity, reorientate along the DoP, apply the inverse
% pendulum and finally estimate velocity (VelDRI) and displacement (DISPL)

[DISPL_L, VelDRI_L, SP_L, Acc_g_L]=Disp_estimate(IC_L,FC_L,acc_L,gyr_L,orient_L,fs);
[DISPL_R, VelDRI_R, SP_R, Acc_g_R]=Disp_estimate(IC_R,FC_R,acc_R,gyr_R,orient_R,fs);


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

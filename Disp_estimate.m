function [Displ Vel SP Acc]= Disp_estimate(HS,TO,acc,gyr,orient,fs)

%HS=IC --> heel strike
%TO=FC --> toe off

%% definition of the integration instants
% we integrate when we suppose the foot is still(mid-stance instant=40% of stance phase)

SP=round(0.4*(TO-HS))+HS; 

%% Gravity removal

% need of reorentation in a global reference system using orientation quaternions 

%...
%...

% gravity removal
Agfree=Acc_g+[0,0,-9.81]; %no drift during the integration due to the gravity

%% Inverse pendulum 

% we must considered the rotation of the ankle in the boundary conditions of
% the velocity integration since the ankle rotates even if the foot is still.
% linear velocity=angular velocity(SP)*radius --> absolute value of it 
% --> it is used as updating value 

radius=0.6; % insert the correct radius (distance between imu and malleolus center)

V_UPD = abs(gyr(SP,2)*radius)'; %updating value of velocity during integration

%% Mean value removal

% Acc_wm is the acceleration without the mean in the gait cycles 
% where there's no stationarity

Acc_wm = MEAN_VALUE_REMOVAL(Agfree,SP,fs,V_UPD);

% --> MEAN_VALUE_REMOVAL: function given by my teacher, 
% we could use since it's surely helpful to reduce noise, drift etc
% If I have time I'll try to rewrite it on my own in a .mat file 
% but for now we can just use this one  

% ( given the stationarity of the path, an expected value at the end of the stride 
% can be defined and it coincides with the value at the end of the previous step:
% -> the difference between the speed values at the extremes of the stride 
% is calculated, both with and without removing the mean value
% -> then we choose the condition that allows to minimize the difference
% This removes the low f components that cause drift )

%% Reorentation along the DoP

[~, ~, ~, Acc, ~, ~]=REORIENTATION_ANKLE(Acc_wm,SP,HS,gyr,fs,V_UPD);

% This function calculates the rotation matrix in order to maximize
% the average speed along the AP direction (antero-posterior):
% 1. defines a vector of angles from -90° to +90°
% 2. rotates accelerations
% 3. integrates them to get speed
% 4. the angle of the direction of progression of a stride is what
%    maximizes the mean linear speed along the AP direction
% 5. rotate by the angle found

% --> Acc is a nx3 matrix containing the antero-posterior acceleration 

%% Speed estimation 

Vel=[];
for i=1:length(SP)-1
    driSignal=[];
    driSignal(:,1) = DRIntegrate(Acc((SP(i):SP(i+1)),1), fs, V_UPD(i), V_UPD(i+1)); %AP
    driSignal(:,2) = DRIntegrate(Acc(SP(i):SP(i+1),2), fs, 0, 0);   %ML
    driSignal(:,3) = DRIntegrate(Acc((SP(i):SP(i+1)),3), fs, 0, 0); %V
    Vel=[Vel; driSignal];
end

%% Displacement estimation 

Displ=[];

SP=SP-SP(1)+1;
for i=1:length(SP)-1
    driSignal=[];
    driSignal(:,1) = sintegrate(Vel((SP(i):SP(i+1)),1), fs, 3, 0); %AP 
    driSignal(:,2) = sintegrate(Vel((SP(i):SP(i+1)),2), fs, 3, 0); %ML
    driSignal(:,3) = sintegrate(Vel((SP(i):SP(i+1)),3), fs, 3, 0); %V
    Displ=[Displ; driSignal];
end


end

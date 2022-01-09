
%Stancin & Tomazic's calibration for GYROSCOPE

clear all
close all
clc

%% load data
load gyroscopeAcquisition.mat

%% constant variables
nCycle = 100;  % define the number of cycle done by the gyroscope 
angleTot = 360*nCycle; % the total amount of angle spanned

%% ideal average angular velocity --> [deg/s]
velId_X = angleTot/(tx(end)-tx(1)); % ideal angular velocity x
velId_Y = angleTot/(ty(end)-ty(1)); % ideal angular velocity y
velId_Z = angleTot/(tz(end)-tz(1)); % ideal angular velocity z

W = diag([velId_X,velId_Y ,velId_Z ]); % 3 x 3 ideal diagonal matrix (non-null elements with ideal angular velocity for x,y,z on the diagonal)

%% measured average angular velocity
wMeanx = mean(gyrx)'; % measured angular velocity (1x3)
wMeany = mean(gyry)'; % measured angular velocity (1x3)
wMeanz = mean(gyrz)'; % measured angular velocity (1x3)

Ws = rad2deg([wMeanx wMeany wMeanz]) ; % 3 x 3 matrix with measured angular velocities. 

%% compute W0 and Cs
w0 = mean(gyroSt)' ;
W0 = repmat(w0,1,3); % 3 x 3 bias (repetition of w0 as column vector: [w0(1) w0(1) w0(1); w0(2) w0(2) w0(2); w0(3) w0(3) w0(3)])

Cs = W*inv(Ws-W0) ; % formula for obtaining the scaling matrix

%% application of the calibration coefficients
% Cs --> 3x3
% w0 --> 1x3
% gyrx --> Nx3
% gyrx_post --> Nx3

gyroSt_post = MULTIPROD(Cs,(gyroSt - w0')')';
gyrx_post = MULTIPROD(Cs,(gyrx - w0')' )';
gyry_post = MULTIPROD(Cs,(gyry - w0')' )';
gyrz_post = MULTIPROD(Cs,(gyrz - w0')' )';

% %% possible improvement evaluation 
% 
% % integrate the angular velocity pre-calibration
% intWx_pre = rad2deg(abs(cumtrapz(tx,gyrx(:,1)))); %integral of gyrx over tx ---> absolute value ---> from rad 2 deg
% intWy_pre = rad2deg(abs(cumtrapz(ty,gyry(:,2)))); %integral of gyry over ty ---> absolute value ---> from rad 2 deg
% intWz_pre = rad2deg(abs(cumtrapz(tz,gyrz(:,3)))); %integral of gyrz over tz ---> absolute value ---> from rad 2 deg
% 
% % integrate the angular velocity post-calibration
% intWx_post = rad2deg(abs(cumtrapz(tx,gyrx_post(:,1)))); %integral of gyrx over tx ---> absolute value ---> from rad 2 deg
% intWy_post = rad2deg(abs(cumtrapz(ty,gyry_post(:,2)))); %integral of gyry over ty ---> absolute value ---> from rad 2 deg
% intWz_post = rad2deg(abs(cumtrapz(tz,gyrz_post(:,3)))); %integral of gyrz over tz ---> absolute value ---> from rad 2 deg
% 
% 
% % compute angular errors pre and post-calibration
% err_x_pre = round(intWx_pre - 36000,2); err_y_pre = round(intWy_pre - 36000,2); err_z_pre = round(intWz_pre - 36000,2);
% err_x_post = round(intWx_post - 36000,2); err_y_post = round(intWy_post - 36000,2); err_z_post = round(intWz_post - 36000,2);
% 
% 
% % integrate the angular velocity of the static acquisition pre-calibration
% intWstx_pre = rad2deg(abs(cumtrapz(tSt,gyroSt(:,1)))); %integral of gyroSt(:,1) over tSt ---> absolute value ---> from rad 2 deg
% intWsty_pre = rad2deg(abs(cumtrapz(tSt,gyroSt(:,2)))); %integral of gyroSt(:,2) over tSt ---> absolute value ---> from rad 2 deg
% intWstz_pre = rad2deg(abs(cumtrapz(tSt,gyroSt(:,3)))); %integral of gyroSt(:,3) over tSt ---> absolute value ---> from rad 2 deg
% 
% % integrate the angular velocity of the static acquisition post-calibration
% intWstx_post = rad2deg(abs(cumtrapz(tSt,gyroSt_post(:,1)))); %integral of gyroSt_post(:,1) over tSt ---> absolute value ---> from rad 2 deg
% intWsty_post = rad2deg(abs(cumtrapz(tSt,gyroSt_post(:,2)))); %integral of gyroSt_post(:,2) over tSt ---> absolute value ---> from rad 2 deg
% intWstz_post = rad2deg(abs(cumtrapz(tSt,gyroSt_post(:,3)))); %integral of gyroSt_post(:,3) over tSt ---> absolute value ---> from rad 2 deg
% 


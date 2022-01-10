%Stancin & Tomazic's calibration for ACCELEROMETER

clear all
close all
clc

%% load the data
%load acc_acquisition0.mat %six static acquisitions --> right IMU 
load acc_acquisition1.mat %six static acquisitions --> left IMU 

% define the gravity norm (m/s^2)
g=9.81; % [m/s^2] gravity norm
xp=xp.*g; yp=yp.*g; zp=zp.*g; 
xn=xn.*g; yn=yn.*g; zn=zn.*g; 

% plot 
fs=119; % sampling 
subplot(231); plot(xp); ylim([-20 20]); xlim([0 length(zn)]); title('xp');
subplot(232); plot(yp); ylim([-20 20]); xlim([0 length(zn)]); title('yp');
subplot(233); plot(zp); ylim([-20 20]); xlim([0 length(zn)]); title('zp');
subplot(234); plot(xn); ylim([-20 20]); xlim([0 length(zn)]); title('xn');
subplot(235); plot(yn); ylim([-20 20]); xlim([0 length(zn)]); title('yn');
subplot(236); plot(zn); ylim([-20 20]); xlim([0 length(zn)]); title('zn');
sgtitle('acceleration before calibration [m/s^2]'); 

%% Compute Cs and a0
% compute the average value of the accelerometer measurements for each direction

xp_mean = mean(xp)'/g; xn_mean = mean(xn)'/g;  %mean, transposition, normalization
yp_mean = mean(yp)'/g; yn_mean = mean(yn)'/g;
zp_mean = mean(zp)'/g; zn_mean = mean(zn)'/g;

% Asn and Asp matrixes creation 

Asp = [xp_mean yp_mean zp_mean];  
Asn = [xn_mean yn_mean zn_mean];

% computation of calibration coefficients
Cs = (inv(Asp-Asn))*2;  % scaling matrix
A0 = (Asp+Asn)/2;       % offset matrix
a0 = A0*g*ones(3,1)/3;  % offset vector, expressed in m/s^{2} 

%% Application of the calibration coefficients 

xp_post = MULTIPROD(Cs,(xp-a0')');
xn_post = MULTIPROD(Cs,(xn-a0')');
yp_post = MULTIPROD(Cs,(yp-a0')');
yn_post = MULTIPROD(Cs,(yn-a0')');
zp_post = MULTIPROD(Cs,(zp-a0')');
zn_post = MULTIPROD(Cs,(zn-a0')');

%% improvement evaluation

% xp
norm_xp_pre = mean(vecnorm(xp')); %norm of measurements in each sampling istant
e_xp_pre = round(((norm_xp_pre - g)/g*100),2); %computation of the average percentage relative error of the measurement norm before and after calibration
norm_xp_post = mean(vecnorm(xp_post)); e_xp_post = round(((norm_xp_post - g)/g*100),2) ;
%disp([e_xp_pre e_xp_post])
disp(['xp-acc: acceleration error before the calibration amounts to ' num2str(e_xp_pre) ' %'])
disp(['xp-acc: acceleration error after the calibration amounts to ' num2str(e_xp_post) ' %'])

% xn
norm_xn_pre = mean(vecnorm(xn')); e_xn_pre = round(((norm_xn_pre - g)/g*100),2);
norm_xn_post = mean(vecnorm(xn_post)); e_xn_post = round(((norm_xn_post - g)/g*100),2);
%disp([e_xn_pre e_xn_post])
disp(['xn-acc: acceleration error before the calibration amounts to ' num2str(e_xn_pre) ' %'])
disp(['xn-acc: acceleration error after the calibration amounts to ' num2str(e_xn_post) ' %'])

% yp
norm_yp_pre = mean(vecnorm(yp')); e_yp_pre = round(((norm_yp_pre - g)/g*100),2);
norm_yp_post = mean(vecnorm(yp_post)); e_yp_post = round(((norm_yp_post - g)/g*100),2);
%disp([e_yp_pre e_yp_post])
disp(['yp-acc: acceleration error before the calibration amounts to ' num2str(e_yp_pre) ' %'])
disp(['yp-acc: acceleration error after the calibration amounts to ' num2str(e_yp_post) ' %'])

% yn
norm_yn_pre  = mean(vecnorm(yn')); e_yn_pre = round(((norm_yn_pre - g)/g*100),2);
norm_yn_post =mean(vecnorm(yn_post)); e_yn_post = round(((norm_yn_post - g)/g*100 ),2);
%disp([e_yn_pre e_yn_post])
disp(['yn-acc: acceleration error before the calibration amounts to ' num2str(e_yn_pre) ' %'])
disp(['yn-acc: acceleration error after the calibration amounts to ' num2str(e_yn_post) ' %'])

% zp
norm_zp_pre = mean(vecnorm(zp')); e_zp_pre = round(((norm_zp_pre - g)/g*100),2);
norm_zp_post = mean(vecnorm(zp_post)); e_zp_post = round(((norm_zp_post - g)/g*100 ),2);
%disp([e_zp_pre e_zp_post])
disp(['zp-acc: acceleration error before the calibration amounts to ' num2str(e_zp_pre) ' %'])
disp(['zp-acc: acceleration error after the calibration amounts to ' num2str(e_zp_post) ' %'])

% zn
norm_zn_pre = mean(vecnorm(zn')); e_zn_pre = round(((norm_zn_pre - g)/g*100),2); 
norm_zn_post = mean(vecnorm(zn_post)); e_zn_post = round(((norm_zn_post - g)/g*100 ),2);
%disp([e_zn_pre e_zn_post])
disp(['zn-acc: acceleration error before the calibration amounts to ' num2str(e_zn_pre) ' %'])
disp(['zn-acc: acceleration error after the calibration amounts to ' num2str(e_zn_post) ' %'])

% plot 
figure
subplot(231); plot(xp_post'); ylim([-20 20]); xlim([0 length(zn)]); title('xp');
subplot(232); plot(yp_post'); ylim([-20 20]); xlim([0 length(zn)]); title('yp');
subplot(233); plot(zp_post'); ylim([-20 20]); xlim([0 length(zn)]); title('zp');
subplot(234); plot(xn_post'); ylim([-20 20]); xlim([0 length(zn)]); title('xn');
subplot(235); plot(yn_post'); ylim([-20 20]); xlim([0 length(zn)]); title('yn');
subplot(236); plot(zn_post'); ylim([-20 20]); xlim([0 length(zn)]); title('zn');
sgtitle('acceleration after calibration [m/s^2]');

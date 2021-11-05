
clear all;
close all;
clc

%% Initializing the Arduino
a = ble("Arduino IMU");

%This is the characteristic for net acceleration
char_netaccel = characteristic(a,"7DE3F257-A014-42D8-8B8D-E4A75DB3B930","2104");

%This is the characteristic for X
char_AccelX = characteristic(a,"7DE3F257-A014-42D8-8B8D-E4A75DB3B930","2101");
%This is the characteristic for Y
char_AccelY = characteristic(a,"7DE3F257-A014-42D8-8B8D-E4A75DB3B930","2102");
%This is the characteristic for Z
char_AccelZ = characteristic(a,"7DE3F257-A014-42D8-8B8D-E4A75DB3B930","2103");



while(1)
    
    netAccel = char_netaccel.read("latest");
    disp(netAccel)

end    
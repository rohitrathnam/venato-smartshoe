
clear all;
close all;
clc

%% Initializing the Arduino or whatever the name is
a = ble("Arduino");

%This is the characteristic for net acceleration
char_netaccel = characteristic(a,"7DE3F257-A014-42D8-8B8D-E4A75DB3B930","2104");

%This is the characteristic for X
char_AccelX = characteristic(a,"7DE3F257-A014-42D8-8B8D-E4A75DB3B930","2101");
%This is the characteristic for Y
char_AccelY = characteristic(a,"7DE3F257-A014-42D8-8B8D-E4A75DB3B930","2102");
%This is the characteristic for Z
char_AccelZ = characteristic(a,"7DE3F257-A014-42D8-8B8D-E4A75DB3B930","2103");



while(1)
    
    %% Acceleration in X-Axis
    datax = read(char_AccelX);
    varX = single(datax);
    accelx = swapbytes(typecast(uint8(varX(5:8)),'single'));

    %% Acceleration in Y-Axis
    datay = read(char_AccelY);
    varY = single(datay);
    accely = swapbytes(typecast(uint8(varY(5:8)),'single'));

    %% Acceleration in Z-Axis
    dataz = read(char_AccelZ);
    varZ = single(dataz);
    accelz = swapbytes(typecast(uint8(varZ(5:8)),'single'));

    %% Net Acceleration
    data_net = read(char_netaccel);
    varNet= single(data_net);
    accelNet = swapbytes(typecast(uint8(varNet(5:8)),'single'));

    fprintf('Acceleration in X: %d\n', accelx);
    fprintf('Acceleration in Y: %d\n', accely);
    fprintf('Acceleration in Z: %d\n', accelz);
    fprintf('Net Acceleration: %d\n\n', accelNet);

end    

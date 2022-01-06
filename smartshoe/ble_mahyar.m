
clear all;
close all;
clc

%% Initializing the Arduino
a = ble("Arduino");

% characteristics for IMU 1
char_AccelX1 = characteristic(a,"7DE3F257-A014-42D8-8B8D-E4A75DB3B930","1101");
char_AccelY1 = characteristic(a,"7DE3F257-A014-42D8-8B8D-E4A75DB3B930","1102");
char_AccelZ1 = characteristic(a,"7DE3F257-A014-42D8-8B8D-E4A75DB3B930","1103");
char_GyroX1 = characteristic(a,"7DE3F257-A014-42D8-8B8D-E4A75DB3B930","1104");
char_GyroY1 = characteristic(a,"7DE3F257-A014-42D8-8B8D-E4A75DB3B930","1105");
char_GyroZ1 = characteristic(a,"7DE3F257-A014-42D8-8B8D-E4A75DB3B930","1106");

% characteristics for IMU 2
char_AccelX2 = characteristic(a,"6E7306BD-4D4B-47A2-A4A7-E5B9F0976C76","2101");
char_AccelY2 = characteristic(a,"6E7306BD-4D4B-47A2-A4A7-E5B9F0976C76","2102");
char_AccelZ2 = characteristic(a,"6E7306BD-4D4B-47A2-A4A7-E5B9F0976C76","2103");
char_GyroX2 = characteristic(a,"6E7306BD-4D4B-47A2-A4A7-E5B9F0976C76","2104");
char_GyroY2 = characteristic(a,"6E7306BD-4D4B-47A2-A4A7-E5B9F0976C76","2105");
char_GyroZ2 = characteristic(a,"6E7306BD-4D4B-47A2-A4A7-E5B9F0976C76","2106");

% characteristics for Pressure sensor
P0 = characteristic(a,"FD534505-F6B8-489A-8B89-A28862F4F950","3101");
P1 = characteristic(a,"FD534505-F6B8-489A-8B89-A28862F4F950","3102");
P2 = characteristic(a,"FD534505-F6B8-489A-8B89-A28862F4F950","3103");
P3 = characteristic(a,"FD534505-F6B8-489A-8B89-A28862F4F950","3104");
P6 = characteristic(a,"FD534505-F6B8-489A-8B89-A28862F4F950","3105");





while(1)

    %% Acceleration IMU 1 in X-Axis
    datax1 = read(char_AccelX1);
    varX1 = single(datax1);
    accelx1 = swapbytes(typecast(uint8(varX1(5:8)),'single'));

    %% Acceleration IMU 1 in Y-Axis
    datay1 = read(char_AccelY1);
    varY1 = single(datay1);
    accely1 = swapbytes(typecast(uint8(varY1(5:8)),'single'));

    %% Acceleration IMU 1 in Z-Axis
    dataz1 = read(char_AccelZ1);
    varZ1 = single(dataz1);
    accelz1 = swapbytes(typecast(uint8(varZ1(5:8)),'single'));

    %% Acceleration IMU 2 in X-Axis
    datax2 = read(char_AccelX2);
    varX2 = single(datax2);
    accelx2 = swapbytes(typecast(uint8(varX2(5:8)),'single'));

    %% Acceleration IMU 2 in Y-Axis
    datay2 = read(char_AccelY2);
    varY2 = single(datay2);
    accely2 = swapbytes(typecast(uint8(varY2(5:8)),'single'));

    %% Acceleration IMU 2 in Z-Axis
    dataz2 = read(char_AccelZ2);
    varZ2 = single(dataz2);
    accelz2 = swapbytes(typecast(uint8(varZ2(5:8)),'single'));

    %% Gyro IMU 1 in X-Axis
    datgx1 = read(char_GyroX1);
    varGX1 = single(datgx1);
    gyrox1 = swapbytes(typecast(uint8(varGX1(5:8)),'single'));

    %% Gyro IMU 1 in Y-Axis
    datgy1 = read(char_GyroY1);
    varGY1 = single(datagy1);
    gyroy1 = swapbytes(typecast(uint8(varGY1(5:8)),'single'));

    %% Gyro IMU 1 in Z-Axis
    datgz1 = read(char_GyroZ1);
    varGZ1 = single(datgz1);
    gyroz1 = swapbytes(typecast(uint8(varGZ1(5:8)),'single'));

    %% Gyro IMU 2 in X-Axis
    datgx2 = read(char_GyroX2);
    varGX2 = single(datgx2);
    gyrox2 = swapbytes(typecast(uint8(varGX2(5:8)),'single'));

    %% Gyro IMU 2 in Y-Axis
    datgy2 = read(char_GyroY2);
    vargY2 = single(datgy2);
    gyroy2 = swapbytes(typecast(uint8(vargY2(5:8)),'single'));

    %% Gyro IMU 2 in Z-Axis
    datgz2 = read(char_GyroZ2);
    vargZ2 = single(dataz2);
    gyroz2 = swapbytes(typecast(uint8(vargZ2(5:8)),'single'));

    %% Pressure Data
    p0 = read(P0);
    var0 = single(p0);
    presssure0 = swapbytes(typecast(uint8(var0(5:8)),'single'));

    p1 = read(P1);
    var1 = single(p1);
    presssure1 = swapbytes(typecast(uint8(var1(5:8)),'single'));
    
    p2 = read(P2);
    var2 = single(p2);
    presssure2 = swapbytes(typecast(uint8(var2(5:8)),'single'));
    
    p3 = read(P3);
    var3 = single(p3);
    presssure3 = swapbytes(typecast(uint8(var3(5:8)),'single'));
    
    p6 = read(P6);
    var6 = single(p6);
    presssure6 = swapbytes(typecast(uint8(var6(5:8)),'single'));


    fprintf('Acceleration IMU1 in X: %d\n', accelx1);
    fprintf('Acceleration IMU1 in Y: %d\n', accely1);
    fprintf('Acceleration IMU1 in Z: %d\n', accelz1);

    fprintf('Angle IMU1 in X: %d\n', gyrox1);
    fprintf('Angle IMU1 in Y: %d\n', gyroy1);
    fprintf('Angle IMU1 in Z: %d\n', gyroy1);


    fprintf('Acceleration IMU1 in X: %d\n', accelx2);
    fprintf('Acceleration IMU1 in Y: %d\n', accely2);
    fprintf('Acceleration IMU1 in Z: %d\n', accelz2);


    fprintf('Angle IMU1 in X: %d\n', gyrox2);
    fprintf('Angle IMU1 in Y: %d\n', gyroy2);
    fprintf('Angle IMU1 in Z: %d\n', gyroy2);

    fprintf('Pressure A0: %d\n', p0);
    fprintf('Pressure A1: %d\n', p1);
    fprintf('Pressure A2: %d\n', p2);
    fprintf('Pressure A3: %d\n', p3);
    fprintf('Pressure A6: %d\n', p6);


    
    
end    
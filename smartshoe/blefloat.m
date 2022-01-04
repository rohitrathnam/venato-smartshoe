clc
clear all; 
%% Initializing the Arduino or whatever the name is
a = ble("Arduino");
maxrange = 100;
%This is the characteristic for net acceleration
shoedata = characteristic(a,"7DE3F257-A014-42D8-8B8D-E4A75DB3B930","1101");

dataset = zeros(maxrange7, 17);
for idx=0:maxrange-1
    newdata = read(shoedata); 
    for j=1:7
        for i=1:17
            dataset(idx7+j, i) = typecast(uint8(newdata(4i-3:4i)),'single');
        end 
    end 

end
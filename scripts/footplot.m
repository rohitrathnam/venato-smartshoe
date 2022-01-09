% Put the data in a variable data of size [n x 5]

foot = imread('foot1.png');
standingoffsets = [330, 280, 400, 480, 350];

[n,m] = size(data);
fsrlog = zeros(n,m);

for i=1:n
    fsrlog(i, :) = data(i,:)-standingoffsets;
end

%%
close all
t = linspace(0,2*pi,100);
r = [10,20,10,30,50];
x = zeros(5,100);
y = zeros(5,100);

% back in, toe, front in, back out, front out
locx = [140,130,130,200,250];
locy = [470,50,170,470,200];

minval = min(fsrlog, [], 'all');
maxval = max(fsrlog, [], 'all');
rmax = 60;
rmin = 10;

for idx = 1:200
    
    imshow(foot);
    hold on;

    for i=1:5
        r(i) = ((fsrlog(idx,i) - minval)*(rmax - rmin))/(maxval - minval) + rmin;
        x(i,:) = r(i)*cos(t) + locx(i);
        y(i,:) = r(i)*sin(t) + locy(i);
        if fsrlog(idx,i) > 0
            plot(x(i,:),y(i,:),'r');
        else
            plot(x(i,:),y(i,:),'b');
        end
    end

    plot(locx,locy,'r*');
    hold off;
    pause(.1);
end
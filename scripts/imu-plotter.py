import serial
import codecs
import time

import matplotlib.pyplot as plt
import numpy as np

size = 500
x_vec1 = np.linspace(0,1,size+1)[0:-1]
y_vec1 = np.zeros(len(x_vec1))
line1 = []
x_vec2 = np.linspace(0,1,size+1)[0:-1]
y_vec2 = np.zeros(len(x_vec2))
line2 = []
x_vec3 = np.linspace(0,1,size+1)[0:-1]
y_vec3 = np.zeros(len(x_vec3))
line3 = []

def live_plotter(x_vec,y1_data,line,title,ylabel):
    if line==[]:
        # this is the call to matplotlib that allows dynamic plotting
        plt.ion()
        fig = plt.figure(figsize=(5,5))
        ax = fig.add_subplot(111)
        # create a variable for the line so we can later update it
        line, = ax.plot(x_vec,y1_data,'-o',alpha=0.8)        
        #update plot label/title and range
        plt.ylim(-5,5)
        plt.ylabel(ylabel)
        plt.title(title)
        plt.show()
    
    # after the figure, axis, and line are created, we only need to update the y-data
    line.set_ydata(y1_data)
    # adjust limits if new data goes beyond bounds
    if np.min(y1_data)<=line.axes.get_ylim()[0] or np.max(y1_data)>=line.axes.get_ylim()[1]:
        plt.ylim([np.min(y1_data)-np.std(y1_data),np.max(y1_data)+np.std(y1_data)])
    # this pauses the data so the figure/axis can catch up - the amount of pause can be altered above
    plt.pause(0.01)
    
    # return line so we can update it again in the next iteration
    return line

# configure the serial connections (the parameters differs on the device you are connecting to)
ser = serial.Serial(
    port='/dev/ttyACM0',
    baudrate=115200,
    parity=serial.PARITY_ODD,
    stopbits=serial.STOPBITS_TWO,
    bytesize=serial.SEVENBITS
)

ser.isOpen()

while 1:
    ax = np.zeros((1,))
    ay = np.zeros((1,))
    az = np.zeros((1,))
    while (ax.shape[0] < 100):
        ax.shape[0]
        # time.sleep(0.01)
        raw_str = ser.readline()
        data_raw = codecs.decode(raw_str, 'unicode_escape')
        data = data_raw[:-2].split('\t')
        res = [float(ele) for ele in data]
        # print(res)
        ax = np.append(ax, res[0])
        ay = np.append(ay, res[1])
        az = np.append(az, res[2])
    y_vec1 = np.append(y_vec1, ax)
    if(y_vec1.shape[0]>100):
        y_vec1 = y_vec1[-100:]
    x_vec1 = np.linspace(0,1,y_vec1.shape[0])
    line1 = live_plotter(x_vec1,y_vec1,line1,'Ax','g')
    
    y_vec2 = np.append(y_vec2, ay)
    if(y_vec2.shape[0]>100):
        y_vec2 = y_vec2[-100:]
    x_vec2 = np.linspace(0,1,y_vec2.shape[0])
    line2 = live_plotter(x_vec2,y_vec2,line2,'Ay','g')
    
    y_vec3 = np.append(y_vec3, az)
    if(y_vec3.shape[0]>100):
        y_vec3 = y_vec3[-100:]
    x_vec3 = np.linspace(0,1,y_vec3.shape[0])
    line3 = live_plotter(x_vec3,y_vec3,line3,'Az','g')



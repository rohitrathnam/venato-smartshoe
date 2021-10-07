
from numpy.lib.function_base import average
from scipy import signal
import matplotlib.pyplot as plt
import numpy as np
import serial.tools.list_ports
import serial
import collections
from matplotlib.animation import FuncAnimation


serialInst = serial.Serial()
ports_list = []
portsavl = serial.tools.list_ports.comports()

for port in portsavl:
    ports_list.append(str(port))
    print(str(port))

portval = input("Select the port: ")

serialInst.baudrate = 9600
serialInst.port = portval
serialInst.open()

# can increase this to see more samples on graph
data_amount = 19

# Filter requirements.

fs = 119.0      # sample rate, Hz
cutoff = 3      # desired cutoff frequency of the filter, Hz z
nyq = 0.5 * fs  # Nyquist Frequency
order = 5       # sin wave can be approx represented as quadratic
normal_cutoff = cutoff / nyq

step_count = 0
sampled = [0]*data_amount

# Get the filter coefficients 
b, a = signal.butter(order, normal_cutoff, btype='low', analog=False)

## Setup the graph
#set the size of the deque object
datalist = collections.deque([0]*data_amount,data_amount)
#configure the graph itself
fig, ax = plt.subplots()
line, = ax.plot([0,]*data_amount)
#size of the y axis is set here
ax.set_ylim(-4,4)

plt.show()

def update(val):
    # update curve
    line.set_ydata(val)
    # redraw canvas while idle
    fig.canvas.draw_idle()

while True:
    # Value inside range decides how many data points need to be received  before graph update
    # 119Hz / 5 = approx 24Hz refresh rate for the graph
    for i in range(5):
        raw_data = serialInst.readline()
        ddata = raw_data.decode('utf')
        valData = np.double(ddata)
    
        sampled.append(valData)
        sampled.pop(0)
        print(i)
    # print(len(sampled))
  
    # for sample in sampled:
    #     if sample > 0.8:
    #         step_count += 1
    #         print(step_count)

    # y returns an array of size 19
    y = signal.filtfilt(b, a, sampled)

    # update puts it on the graph
    update(y)


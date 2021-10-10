
from math import isnan
from re import T, X, split
from matplotlib import colors
from matplotlib import animation
from numpy.lib import RankWarning
from numpy.lib.function_base import average
from scipy import signal
import matplotlib.pyplot as plt
import numpy as np
import scipy
from scipy.signal import spline
import serial.tools.list_ports
import serial
import collections
import csv


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


step_count = 0


while True:
    # Value inside range decides how many data points need to be received  before graph update
    # 119Hz / 5 = approx 24Hz refresh rate for the graph
    for i in range(5):
        raw_data = serialInst.readline()
        valData = np.float32(raw_data)
        
    
        sampled.append(valData)
        sampled.pop(0)
        # print(i) 

    
  


    # y returns an array of size 19
    y = signal.filtfilt(b, a, sampled) 
    peaks = signal.find_peaks(y, height=0)

    if peaks[0] == 0:
        print(step_count)

    else:
        min_val = np.min(y)
        max_val = np.max(y)

        avg = (min_val + max_val)/2

        index = peaks[0]

        if y[index] > avg:
            step_count += 1
            print(step_count)

            



from numpy.lib.function_base import average
from scipy import signal
import matplotlib.pyplot as plt
import numpy as np
import serial.tools.list_ports
import serial
from matplotlib.animation import FuncAnimation


serialInst = serial.Serial()
ports_list = []
portsavl = serial.tools.list_ports.comports()

for port in portsavl:
    ports_list.append(str(port))
    print(str(port))

val = input("Select the port: ")

serialInst.baudrate = 9600
serialInst.port = str(val)
serialInst.open()


# Filter requirements.

fs = 119.0      # sample rate, Hz
cutoff = 3      # desired cutoff frequency of the filter, Hz z
nyq = 0.5 * fs  # Nyquist Frequency
order = 2       # sin wave can be approx represented as quadratic


def butter_lowpass_filter(data, cutoff, fs, order):
    normal_cutoff = cutoff / nyq
    # Get the filter coefficients 
    b, a = signal.butter(order, normal_cutoff, btype='low', analog=False)
    y = signal.filtfilt(b, a, data)
    return y



step_count = 0



       
sampled = [0]*18

while True:

    

    raw_data = serialInst.readline()
    ddata = raw_data.decode('utf')
    valData = np.double(ddata)

    
    sampled.append(valData)
    sampled.pop(0)
        
        




    # for sample in sampled:
    #     if sample > 0.8:
    #         step_count += 1
    #         print(step_count)
            


  

    a = butter_lowpass_filter(np.array(sampled), cutoff, fs, order)    


    

        
    
    
    
    
    



    


        
    
    

        

        
    


    



import numpy as np
from numpy import sin,pi
import matplotlib.pyplot as plt

x = np.linspace(0,1.0,4096)

lut = sin(2*pi*x)*750+750

with open('readme.txt', 'w') as f:
    for i,val in enumerate(lut):
        #if i % 20:
        f.write(str(i))
        f.write('=>')
        f.write(str(val))
        f.write(',\n')
            #print(i, end=' => ')
            #print(val,end=',')
            #print('')
        #else:
            #print(i, end=' => ')
            #print(val,end=',')
            #print('')

plt.plot(x,lut)
plt.show()
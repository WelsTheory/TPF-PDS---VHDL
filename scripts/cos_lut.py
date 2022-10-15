import numpy as np
from numpy import cos,pi
import matplotlib.pyplot as plt

x = np.linspace(0,1.0,4096)

lut = cos(2*pi*x)*750+750

with open('cos_lut.txt', 'w') as f:
    for i,val in enumerate(lut):
        f.write(str(i))
        f.write('=>')
        f.write(str(val))
        f.write(',\n')

plt.plot(x,lut)
plt.show()
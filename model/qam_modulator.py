import commpy.modulation as mod
import numpy as np
import matplotlib.pyplot as plt

t = np.arange(0, 100, 0.1)
a = np.sin(t)

f = np.arange(0, 10, 1)

f = [0, 1, 2, 3]

output = []

for t0 in range(0, len(t)):
    if t0 < 250:
        if f[0] == 1:
            output.append(a[t0] * (2))
        if f[0] == 2:
            output.append(a[t0] * (-2))
        if f[0] == 3:
            output.append(a[t0] * (-1))
        if f[0] == 0:
            output.append(a[t0] * (1))
    if t0 < 500 and t0 >= 250:
        if f[1] == 1:
            output.append(a[t0] * (2))
        if f[1] == 2:
            output.append(a[t0] * (-2))
        if f[1] == 3:
            output.append(a[t0] * (-1))
        if f[1] == 0:
            output.append(a[t0] * (1))
    if t0 < 750 and t0 >= 500:
        if f[2] == 1:
            output.append(a[t0] * (2))
        if f[2] == 2:
            output.append(a[t0] * (-2))
        if f[2] == 3:
            output.append(a[t0] * (-1))
        if f[2] == 0:
            output.append(a[t0] * (1))
    if t0 >= 750:
        if f[3] == 1:
            output.append(a[t0] * (2))
        if f[3] == 2:
            output.append(a[t0] * (-2))
        if f[3] == 3:
            output.append(a[t0] * (-1))
        if f[3] == 0:
            output.append(a[t0] * (1))



# for t0 in range(0, len(t)):
#     if t0 < 250:
#         output.append((modulated_output[0] * a[t0]) + (modulated_output[0] * b[t0]))
#     if t0 < 500 and t0 >= 250:
#         output.append((modulated_output[1] * a[t0]) + (modulated_output[1] * b[t0]))
#     if t0 < 750 and t0 >= 500:
#         output.append((modulated_output[2] * a[t0]) + (modulated_output[2] * b[t0]))
#     if t0 >= 750: 
#         output.append((modulated_output[3] * a[t0]) + (modulated_output[3] * b[t0]))

plt.plot(t,output,color="blue",linewidth=0.8)
plt.title('Senal Portadora')
plt.xlabel('tiempo');
plt.ylabel('amplitud');
plt.grid(True)
plt.show()

# plt.plot(t,output2,color="blue",linewidth=0.8)
# plt.title('Senal Portadora')
# plt.xlabel('tiempo');
# plt.ylabel('amplitud');
# plt.grid(True)
# plt.show()
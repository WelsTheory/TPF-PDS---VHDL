import matplotlib.pyplot as plt
import numpy as np
import scipy.special as sp
import scipy.fftpack as fourier
import pylab as pl
from math import pi
from math import log10



np.seterr(divide = 'ignore') 

#Vm = float(input('Ingrese el valor de amplitud de la moduladora: '))
Vm = 2.0
#Fm = int(input('Ingrese el valor de frecuencia de la moduladora: '))
Fm =200
#Vc = float(input('Ingrese el valor de amplitud de la portadora: '))
Vc = 1.0
#Fc = int(input('Ingrese el valor de frecuencia de la portadora: '))
Fc = 2000
#kf = float(input('Ingrese el factor de sensibilidad de frecuencia: '))
kf = 400.0
#n = float(input('ingrese el numero de periodos: '))
n = 4.0
#print()



#VARIABLES DEL PROGRAMA

Z = 50               #IMPEDANCIA CARACTERISTICA DE LA PORTADORA
delta_f = kf * Vm    #DESVIACION DE FRECUENCIA
beta = delta_f / Fm  #INDICE DE MODULACION FM


Fs = 50000           #Frecuencia de muestreo
x = 0                #SE INICIALIZA VARIABLE DE TRABAJO EN CERO
n0 = []              #VECTOR VACIO PARA INGRESO DE DATOS RESULTANTES
bessel = []          #VECTOR VACIO PARA INGRESO DE DATOS RESULTANTES
f = np.arange(0,10,1)#vector de trabajo


#ECUACIONES PARA HALLAR BESSEL
for i in range (0,len(f)):
    x = round(sp.jv(i,beta),2)  #FUNCION BESSEL DE LIBRERIA
    bessel.append(x)            #VECTOR BESSEL LLENO
    
n_positivos = bessel[1:11];     #COMPONENTES POSITIVOS DE BESSEL
n_negativos = np.flip(n_positivos);#COMPONENTE NEGATIVO BESSEL CAMBIO POS
n0.append(bessel[0]);           #POSICION CENTRAL DEL VECTOR

jn = np.concatenate((n_negativos,n0,n_positivos))#UNE LOS VECTORES ANTERIORES

nB = 4      #NUMERO N PRESENTES EN BESSEL TEORIA
BWb = 2*Fm*nB #ANCHO DE BANDA POR BESSEL TEORIA
BWc = 2*(delta_f*Vm) #ANCHO DE BANDA POR CARSON TEORIA




#VALORES PARA LAS FRECUENCIAS
f_ns = []       #VECTOR VACIO
f_ps = []       #VECTOR VACIO
F0 = []         #VECTOR VACIO
F0.append(Fc)   #FIJAR EN EL VECTOR F0 LA Fc COMO POSICION CENTRAL


for f_inicial in range(0, len(f)):       #CALCULO PARA EL VALOR DEL VECTOR F

    if f_inicial  == 0:     #CONDICIONAL FRECUENCIAS NEGATIVAS
        f_1 = Fc - Fm;
        f_inicial = f_1;
        
    else:
        f_1 = f_1 - Fm;
        f_inicial = f_1;
        
    f_ns.append(f_inicial); #LLENA EL VECTOR CON LOS RESULTADOS ANTERIORES
    
finv_ns = np.flip(f_ns);    #CAMBIA LAS POSICIONES DENTRO DEL VECTOR



for f_final in range(0,len(f)):     #PARA LOS VALORES DEL VECTOR f

    if f_final == 0:        #CONDICIONAL PARA FRECUENCIAS NEGATIVAS
        f_1 = Fc + Fm;
        f_final = f_1;
    else:
        f_1 = f_1 + Fm;
        f_final = f_1;
        
    f_ps.append(f_final);   #LLENA EL VECTOR DE LOS RESULTADOS ANTERIORES
    
finv_ps = np.flip(f_ps);    #CAMBIA LAS POSICIONES DENTRO DEL VECTOR
Fn = np.concatenate((finv_ns,F0,f_ps)) #UNIR COMPONENTES DE FRECUENCIA

t = np.arange(0,n*1/Fm,1/Fs)

#HALLAR Vc * Jn
f_VcJn = []     #VECTOR INICIAL VACIO
VcJn = 0        #INICIALIZACION EN CERO
VcJn = np.round(abs((jn*Vc)/(np.sqrt(2))),2)    #MULTIPLICAR jn*Vc EN VALOR ABS
f_VcJn.append(VcJn) #LLENA EL VECTOR CON EL CALCULKO ANTERIOR



#HALLAR VALORES EN dB DE Jn*Vc
f_VndB = []     #VECTOR INICIAL VACIO
VndB = 0        #INICIALIZACION EN CERO
VndB = np.round(abs((20 * np.log10(VcJn))),2)
f_VndB.append(VndB)


#HALLAR POTENCIA EN WATTS 
f_PnW = []      #VECTOR INICIAL VACIO
PnW = 0         #INICIALIZACION EN CERO
PnW = abs(((jn*Vc)**2)/100) #FORMULA DE POTENCIA
f_PnW.append(PnW)       #LLENA EL VECTOR DEL CALCULO ANTERIOR


#HALLAR LA POTENCIA EN dBm
f_PndBm = []    #VECTOR INICIAL VACIO
PndBm = 0       #INICIALIZACION EN CERO
PndBm = np.round(abs((10*np.log10(PnW*1000))),2)    #POTENCIA EN dB
f_PndBm.append(PndBm)   #LLENA EL VECTOR CON EL CALCULO ANTERIOR


#CALCULO DE ECUACIONES DE MODULACION

Vportadora = Vc*np.cos(2*pi*Fc*t);   #CALCULO DE SENAL PORTADORA
Vmoduladora = Vm*np.sin(2*pi*Fm*t);  #CALCULO DE SENAL MODULADORA
Vfm = Vc*np.cos(2*pi*Fc*t+beta*np.sin(2*pi*Fm*t));


#CALCULO DE ESPECTROS DE SENAL MODULADA
gk = fourier.fft(Vfm)                             # Calculamos la FFT
M_gk = abs(gk)                                  # Calculamos la Magnitud de la FFT
F = Fs*np.arange(0, len(Vfm))/len(Vfm)              # Definimos el Vector de Frecuencias





#FORMULAS RESULTANTES
print('RESULTADOS MODULACION FM')
print()
print('{:^10} {:^10} {:^10} {:^10}'.format('delta_f','beta','BWb','BWc'))
print('{:^10} {:^10} {:^10} {:^10}'.format(delta_f,beta,BWb,BWc))
print()
print('{:^10} {:^9} {:^9} {:^9} {:^9}'.format('Jn','Fn','Vc*Jn','Vn(dB)','Vn(dBm)'))
for formatted in map('{:^10} {:^10} {:^9} {:^10} {:^10}'.format,jn,Fn,VcJn,VndB,PndBm):
    print(formatted)
print()
print("La ecuacion portadora es:")
print("Vc(t)=",Vc,"cos(2pi)",Fc,"t)")
print("La ecuacion moduladora es:")
print("Vm(t)=",Vm,"sen(2pi)",Fm,"t)")
print("La ecuacion general de FM es:")
print("Vfm(t)=",Vc,"cos[2pi",Fc,"t + ",beta,"sen(2pi)",Fm,"t)]")
print()

fig = plt.figure()
fig,plt.subplot(1,1,1)
plt.plot(t,Vportadora,color="blue",linewidth=0.8)
plt.title('Senal Portadora')
plt.xlabel('tiempo');
plt.ylabel('amplitud');
plt.grid(True)
plt.show()


fig1 = plt.figure()
fig1,plt.subplot(1,1,1)
plt.plot(t,Vmoduladora,color="black",linewidth=0.8)
plt.title('Senal Moduladora')
plt.xlabel('tiempo');
plt.ylabel('amplitud');
plt.grid(True)
plt.show()

fig2 = plt.figure()
fig2,plt.subplot(1,1,1)
plt.plot(t,Vfm,color="red",linewidth=0.8)
plt.title('Modulacion en frecuencia')
plt.xlabel('tiempo');
plt.ylabel('amplitud');
plt.grid(True)
plt.show()


plt.plot(F, M_gk)
plt.xlabel('Frecuencia (Hz)', fontsize='14')
plt.ylabel('Amplitud FFT', fontsize='14')
plt.show()
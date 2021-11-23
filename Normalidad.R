
#***************PRUEBA DE NORMALIDAD*******************

install.packages("stats")
library(stats)
install.packages("nortest")
library(nortest)

#************************************************
#           IMPORTACIÓN DE LA MATRIZ
#************************************************

#1.- Lectura de la matriz
BD3<-read.csv("BD3_penguins.csv")

#2.- Determinar el numero de observaciones 
length(BD3$Largo_pico_mm)

#3.- Visualización de la distribución de la variable 
hist(BD3$Largo_pico_mm)

#***********************************************
#        CREACIÓN DE LA MATRIZ <50
#------------------------------------------------
#Variable: Masa_corporal_g

#1.- visualizamos el nombre de las variables para identificar 
#el número de la columna.

colnames(BD3)

#2.- Se seleccionan de las filas 4 ala 36 de la columna 7
peso<-BD3[4:36,7]

#3.- Se visualiza la variable 
peso

#*************************************************
#             KOLMOGOROV-SMIRNOV 
#-------------------------------------------------

#NOTA: Se aplica si tenemos mas de 50 observaciones 

#H0: la variable tiene una distribucion normal
#Ha: La variable tiene una distribucion diferente a lo normal

# Interpretación:
# p-valor >0.05 No rechazo Ho
#         <0.05 rechazo Ho

#1.-Exploración de la variable 
hist(BD3$Largo_pico_mm)

#2.- Aplicación de la prueba de hipótesis 
lillie.test(BD3$Largo_pico_mm)

# 3.- Interpretación
#p.valor= 0.0002714, es menor a 0.05. por lo tanto, RECHAZO H0.
# Los datos siguen una distribución diferente a la normal.

#*************************************************
#                   SHAPIRO WILKS
#-------------------------------------------------

#NOTA: Se aplica sí tenemos MENOS de 50 observaciones

#Ho: La variable tiene distribución normal
#Ha: La variable tiene una distribución deferente a lo normal 

#Interpretación:
#p.valor >0.05 No rechazo Ho
#        <0.05 rechazo Ho

#1.- Exploración de la variable 
hist(peso)
length(peso)

#2.- Prueba de hipótesis 
shapiro.test(peso)

#3.- Interpretación 
#p-valor: 0.1157, es mayor que 0.05. Por lo tanto. NO se rechaza Ho,
#eso quiere decir que los datos siguen una distribución normal.

 

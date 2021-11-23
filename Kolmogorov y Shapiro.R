
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

#*********************************************
#*#         Importación de la Matriz 
#*#*******************************************
# 1.- Seleccionamos las filas de la especie Gentoo

BD3$Especies
gentoo<-BD3[153:277,]

#*********************************************
#              PRUEBA DE NORMALIDAD
#----------------------------------------------
#2.- Realizamos la prueba de normalidad de Kolmogorov-Smirnov

lillie.test(gentoo$Largo_pico_mm)

#3.- Interpretación:
#Ho: La variable tiene distribución normal.
#Ha: La variable tiene una distribución diferente a la normal.

#////////////////////////////////////////////
#                   PEARSON
#           PEARSON PARA 2 VARIABLES
#******************************************

# Se implementa para datos cuantitativos con distribución normal.

#Se parte de la hipótesis:

#Ho: (p=0) Las variables NO guardan una relación lineal entre ellas. 
#Ha: (p=/0) Las variables guardan una relación lineal entre ellas.


#NOTA: Revisar el valor de la correlación

#//////////////////////////////////////////////
#         PEARSON PARA MUCHAS VARIABLES
#++++++++++++++++++++++++++++++++++++++++++++++++++

#Se instalará la paquetería corrplot y se activará

install.packages("corrplot")

library( corrplot )

#1.- Preparación de la matriz.

#Se seleccionan sólo las variables numéricas.
 
gentoo2 <- gentoo [, 4 : 7 ] 

# 2.- Cálculo de la matriz de correlaciones.

cor_group <- round (cor ( gentoo2 ), 2 )

# 3.- Visualización de los resultados.

head(cor_group)

# 4.- Generación del gráfico de forma completa.

corrplot(cor_group, method = c("number"), type="full")

#4.1.- Generación del gráfico del cuadrante inferior

corrplot(cor_group, method = c("number"), type="lower")

#4.2.- Generación del gráfico del cuadrante superior

corrplot(cor_group, method = c("number"), type="upper")

# 5.- Cálculo del p-valor con nivel del confianza de 0.95,
# y alfa=0.05

cor.mtest(gentoo2, conf.level=0.95)

# 6.- Generación del gráfico con diagrama de dispersión, coeficiente
# de correlación, nivel de significancia e histograma.

install.packages("PerformanceAnalytics")

library(PerformanceAnalytics)

chart.Correlation(gentoo2, histogram = T, method= "pearson", pch=18)

chart.Correlation(gentoo2, histogram = F, method= "pearson", pch=18)

#------------------------------------------------------
#                 Rho - Spearman
#------------------------------------------------------

# Se implementa cuando los datos tiene una distribución DIFERENTE a la Normal.

# Se parte de la hipótesis:

# Ho: (p=0) Las variables NO guardan una relación lineal entre ellas.
# Ha: (p=/0) Las variables guardan una relación lineal entre ellas.

#-----------------------------------------------------
#                Matriz de datos.
#-----------------------------------------------------

# 1.- Creación de la matriz.

# 1.1.- Generación de calificaciones ficticias para las asignaturas
# de matemáticas, español, historia y geografía.

set.seed(5)
mate<-sample(5:10, size= 45, replace=TRUE)
espa<-sample(5:10, size= 45, replace = TRUE)
hist<-sample(5:10, size= 45, replace= TRUE)
geogr<-sample(5:10, size= 45, replace= TRUE)

# 1.2.- Unir la matriz con las diferentes asignaturas
calif_2<-data.frame(mate, espa, hist, geogr)

# 1.3.- Explorar la matriz calif_2
View(calif_2)
str(calif_2)

# 1.4.- Sacar una copia de la matriz generada.
calif_3<-calif_2


#1.5.- Codificar la matriz de integer a numeric

calif_3$mate<-as.numeric(calif_3$mate)
calif_3$espa<-as.numeric(calif_3$espa)
calif_3$hist<-as.numeric(calif_3$hist)
calif_3$geogr<-as.numeric(calif_3$geogr)

# 1.6.- Verificación de los cambios 
View(calif_3)
str(calif_3)

#----------------------------------------------------
#           PRUEBA DE NORMALIDAD 
#----------------------------------------------------
shapiro.test(calif_3$mate)
shapiro.test(calif_3$espa)


#----------------------------------------------------
#            RHO DE SPEARMAN PARA 2 VARIABLES 
#----------------------------------------------------

#1.- Realizar el cálculo de Rho.
spearman<-cor.test(calif_3$mate,calif_3$espa, method = "spearman")

#2.- Visualizar el resultado
spearman

#3.- Interpretación de los resultados (Anota la interpretación)
#Se obtuvo una Rho de 0.1884, lo que significa que las variables no guardan
#correlación lineal.


#----------------------------------------------------
#            Rho de SPEARMAN PARA MUCHAS VARIABLES 
#----------------------------------------------------



# 2.- Generación del gráfico de dispersión, histograma, correlaciones 
# y significancia. 

chart.Correlation(calif_3, histogram = T, method= "spearman", pch=18)



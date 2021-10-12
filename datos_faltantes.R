
#**************************************************
# Busqueda de datos perdidos con el paquete "MICE"
#**************************************************

#a) Instalacion de paquete con dependencias 
install.packages ("mice", dependencies = TRUE)

#b) Se abrira libreria 
library(mice)

#c) Usamos la función md.pattern()
md.pattern(iris)

#d) exportamos el grafico (azul) y se guarda en la carpeta de R
#que se encuentra en el escritorio.



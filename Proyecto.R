#----------------------------------------------------------------------------
#                            GRAFICO DE NUBE  
#/////////////////////////////////////////////////////////////////////////

# Una nube de palabras (también conocida como nube de etiquetas o de texto),
# es una representación visual sobre la regularidad en la que se repiten las 
# palabras, es utilizada principalmente para resaltar la manera en la que se
# repiten ciertos terminos, cuantas mas veces una palabra clave está presente en 
# un conjunto de datos, esa palabra aparecera mas grande y mas remarcada.

# Resumen:
# El presente scrip contiene el tratamiento de un texto literario dirijido a 
# niños pequeños llamado "Los tres cerditos".

#DATOS:
# La siguiente información se obtuvo de:

#Artmann, P. (2020). Cuento de los tres cerditos. juegos educativos para niños. 
#Recuperado 23 de noviembre de 2021, de https://arbolabc.com/cuentos-clasicos-
#infantiles/los-tres-cochinitos

# 1.- se necesita instalar los presentes paquetes:

install.packages("tm")
install.packages("NLP")
install.packages("SnowballC")
install.packages("wordcloud")
install.packages("RColorBrewer")

# 2.- cargamos las librerias correspondientes
library(tm)
library(NLP)
library(SnowballC)
library(RColorBrewer)
library(wordcloud)

# Cuento " Los tres cerditos"
#nuestro texto lo guardamos en bloc de notas en formato txt.

texto <- readLines("Cuento.txt")

texto = iconv(texto, to="ASCII//TRANSLIT")

texto = Corpus(VectorSource(texto))

##########LIMPIAMOS NUESTRO TEXTO CON EL COMANDO tm_map ##############

# 1.- Todos los datos en minuscula (A=a)

discurso=tm_map(texto,tolower)

# 2.- Quitamos los espacios en blanco

discurso =tm_map(discurso, stripWhitespace)

# 3.- Quitamos la puntuacion

discurso = tm_map(discurso, removePunctuation)

# 4.- Quitamos los numeros

discurso = tm_map(discurso, removeNumbers)

# 5.- Mostramos palabras vacias y genericas

stopwords("spanish")

# 6.-Quitamos palabras genericas

discurso=tm_map(discurso, removeWords,stopwords("spanish"))


# ++++++++++++ DATA FRAME DE PALABRAS CON SU FRECUENCIA +++++++++++++++++++++

# 1.- Creamos matriz de letras
letras= TermDocumentMatrix(discurso)
findFreqTerms(letras, lowfreq=5)
matrix=as.matrix(letras)

# 2.- Lo ordenamos y sumamos las letras de nuestra matriz
vector <- sort(rowSums(matrix),decreasing=TRUE) 

# 3.- Creamos la data con las palabras y su frecuencia
dataletras <- data.frame(word= names(vector),frequencia=vector) 

# 4.- Lo nombra y le da formato de data.frame


# Metodología de análisis:

# Realizamos un análisis de texto para poder visualizar la frecuencia con la que
#se repite cierto numero de terminos, esto a traves de la limpieza de texto y 
# creación de una matriz de letras, logrando graficar dichos datos de manera clara
# y precisa.


#************** GRAFICAMOS FRECUENCIA DE LAS PALABRAS*************************

barplot(dataletras[1:10,]$freq, las = 2, names.arg = dataletras[1:10,]$word,
        col ="blue", main ="PALABRAS MAS FRECUENTES", ylab = "Frecuencia de palabras")

#Resultados:

# A través del tratamiento de los datos pudimos notar que la palabra con mayor
# frecuencia es Lobo con 14 veces, al contrario de las palabras Feroz y entrar 
# que solo se repiten en 7 ocasiones.

#/////////////// GRAFICAMOS LA NUBE DE PALABRAS //////////////////////////////

wordcloud(words = dataletras$word, freq = dataletras$freq, min.freq = 2,
          max.words=100)

# 1.- En el centro la palabra mas importante, 
wordcloud(words = dataletras$word, freq = dataletras$freq, min.freq = 2,
          max.words=100, random.order=FALSE, rot.per=0.2, 
          colors=brewer.pal(8, "Dark2"))

#Referencia:

# Graficar NUBE de PALABRAS con R Studio. (2019, 30 diciembre). YouTube. 
#Recuperado 23 de noviembre de 2021, de https://www.youtube.com/watch?v=
#tihnYJhZCHs



  

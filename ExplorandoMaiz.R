rm(list=ls())

maiz<- read.table ("..\\meta\\maizteocintle_SNP50k_meta_extended.txt", header=T, sep= "\t" )

# Para conocer el tipo de objeto que es "maiz"
class(maiz)

# Para ver las primers l�neas de "maiz"
head(maiz)

# Para conocer el n�mero de filas y que ser�an el n�mero de muestras
nrow(maiz)

# Para saber cu�ntos estados tienen muestras
length(levels(maiz$Estado))
#tambi�n funciona
nlevels(maiz$Estado)

# Para saber el n�mero de muestras recolectadas antes de 1980
a�o<-(maiz$A�.o._de_colecta)
x<-a�o<1980
sum(x, na.rm=T)

# Para saber cu�ntas muestras hay por raza
table(maiz$Raza)

# Promedio de altitud de muestras
mean (maiz$Altitud, na.rm=T)

# Altitud min y max de recolecci�n de muestras
min(maiz$Altitud, na.rm=T)
max(maiz$Altitud, na.rm=T)

# Para crear un nuevo data.frame con los datos de Olotillo 
olot<-subset(maiz, Raza=="Olotillo")
class(olot)

# Para crear un nuevo df con los datos de Reventador, Jala y Ancho
grupito<-data.frame(maiz, maiz$Raza==c("Reventador", "Jala", "Ancho"))
dim(grupito)

# Escribir la matriz anterior en un archivo submat.csv en meta
write.csv(grupito, "..//submat.csv")

  

# Este script usa genomas completos de referencia para aplicar la simulación de la digestión

# Importante! Activar los siguientes comandos quitando el signo de gato para instalar bioconductor y sus dependencias
#source("https://bioconductor.org/biocLite.R")
#biocLite() ###instala los paquetes n?cleo
#biocLite(c("zlibbioc","ShortRead","Biostrings")) ### Nota: este comando instala los paquetes de bioconductor
#install.packages(c("SimRAD", repos=c("http://rstudio.org/_packages", "http://cran.rstudio.com"))) ### Tambi�n se puede usar este Comando para instalar SimRAD o cualquier paquete de R


# Comando para borrar los objetos cargados al ambiente de R
rm (list= ls ())

# Para cargar el paquete SimRAD y los paquetes asociados
library(SimRAD)



# Determinar los sitios de restricci?n. Comandos para crear los objetos que contengan los sitios de corte de alguna enzima de restricci?n
### Enzima PstI: sitios de corte 5' y 3'
cs_5p1 <- "TGCA"
cs_3p1 <- "ACGT"

# Loop para simular la digestión de múltiples archivos

## Indicar de la ubicación del directorio donde están las muestras
path="../ProyectoFinal_ERA/"

## Crear un objeto con los archivos .fasta en esa ubicación
file.names<-dir(path, pattern= ".fasta")

## Crear objetos vacíos para crear los resultados de la digestión
referencia <- 0
Treponema<-0
for (i in file.names){
  ## Indicar el wd de los archivos de las especies
  setwd("../ProyectoFinal_ERA/")
  
  ## Aplicar la función ref.DNA.seq para trabajar las secuencias y guardarla en el objeto referencia
  referencia<-ref.DNAseq(FASTA.file=i, subselect.contigs =T, prop.contigs = 0.1)
  
  ## Aplicar la función para digerir las secuecias (insilico.digest) y que se guarde en el mismo objeto con los sitios de corte
  referencia<-insilico.digest(referencia, cs_5p1, cs_3p1, verbose=TRUE)
  
  ## Convertir el objeto referencia a un objeto DNAStringSet para poder exportarlo como archivo fasta
  Treponema<-DNAStringSet(x = referencia)
  
  ## Ir al directorio destino para guardar las secuencias del objeto "Treponema"
  setwd("./digeridos_SimRAD/")
  
  ## Escribir el objeto Treponema como archivo fasta
  writeXStringSet(Treponema,i, append=FALSE, compress=T, compression_level=NA, format="fasta")
  
  ## Ir al directorio bin del script para seguir iterando las funciones para cada especie
  setwd("../../bin")
}


library(msa)

data1<-readDNAStringSet(filepath=".\\digeridos_SimRAD\\T.azotonutricium.fasta", format = "fasta")
data2<-readDNAStringSet(filepath=".\\digeridos_SimRAD\\T.brennaborense.fasta", format = "fasta")
data3<-readDNAStringSet(filepath=".\\digeridos_SimRAD\\T.caldarium.fasta", format = "fasta")
data4<-readDNAStringSet(filepath=".\\digeridos_SimRAD\\T.denticola.fasta", format = "fasta")
data5<-readDNAStringSet(filepath=".\\digeridos_SimRAD\\T.pallidum.fasta", format = "fasta")
data6<-readDNAStringSet(filepath=".\\digeridos_SimRAD\\T.paraluiscuniculi.fasta", format = "fasta")
data7<-readDNAStringSet(filepath=".\\digeridos_SimRAD\\T.pedis.fasta", format = "fasta")
data8<-readDNAStringSet(filepath=".\\digeridos_SimRAD\\T.primitia.fasta", format = "fasta")
data9<-readDNAStringSet(filepath=".\\digeridos_SimRAD\\T.putidum.fasta", format = "fasta")
data10<-readDNAStringSet(filepath=".\\digeridos_SimRAD\\T.succinifasciens.fasta", format = "fasta")

datos<- c(data1, data2, data3, data4, data5, data6, data7, data8, data9, data10)

class(datos)

alin<- msa(datos)


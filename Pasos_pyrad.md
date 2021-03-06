#Crear un contenedor en ubuntu con un volumen 
ruta=C:\Users\Erandi\Desktop\Bioinformatica #cambiar ruta
docker run -v $ruta:/data -it ubuntu /bin/bash 
####Actualizar la versión de ubuntu del contenedor
`apt-get update #para actualizar los paquetes`

`apt-get upgrade #para instalar la última versión de los paquetes`
####Librería necesaria para instalar conda y modificar archivos
`apt-get install wget curl bzip2 nano`
####Hasta acá hemos puesto listo el contenedor...
##Instalación de conda según instrucciones de http://ipyrad.readthedocs.io/installation.html
`wget https://repo.continuum.io/miniconda/Miniconda-latest-Linux-x86_64.sh`

`bash Miniconda-latest-Linux-x86_64.sh`

`source ~/.bashrc`
##Para instalar ipyrad
conda update conda                 ## updates conda
conda install -c ipyrad ipyrad     ## installs the latest release

#Pasos preliminares para trabajar secuencias de ejemplo
####Bajar las secuencias de ejemplo en el volumen, y trabajarlas y guardarlas ahí. Comandos de http://ipyrad.readthedocs.io/tutorial_intro_cli.html
    curl -LkO https://github.com/dereneaton/ipyrad/raw/master/tests/ipsimdata.tar.gz
    tar -xvzf ipsimdata.tar.gz
####Para ver los datos
ls ipsimdata/
#para descomprimir los archivos
gunzip -c ./ipsimdata/rad_example_R1_.fastq.gz | head -n 12
####NOTA: Usa archivos fastq
###Crear archivo de instrucciones y parámetros
    ipyrad -n iptest
######OUTPUT: New file params-iptest.txt created in [nombre del volumen]
###Modificar el archivo params-iptest.txt para guardar la ruta donde se añadirán los archivos con nano
nano params-iptest.txt 
###Modificar las líneas de params-iptest.txt con las rutas:
    ./ipsimdata/rad_example_R1_.fastq.gz   ## [2] [raw_fastq_path]: Location of raw non-demultiplexed fastq files
    ./ipsimdata/rad_example_barcodes.txt   ## [3] [barcodes_path]: Location of barcodes file
####Ahora sí podemos empezar a trabajar...

#Paso 1. Demultiplexar o desagrupar las secuencias de acuerdo a los adaptadores

    ipyrad -p params-iptest.txt -s 1
####Diferentes comandos para ver los resultados
    ls iptest_fastqs
    ipyrad -p params-iptest.txt -r #este da un resumen
    cat ./iptest_fastqs/s1_demultiplex_stats.txt

#Paso 2. Filtrar las secuencias por calidad
###También sirve para detectar los adaptadores. El default es 0 para la calidad por base.

    ipyrad -p params-iptest.txt -s 2
####Crear un directorio nuevo para guardar los nuevos agrupamientos de secuencias dentro de las muestras
    iptest_clust_[depende de los datos, el default es 0.85]/

#Paso 3. Agrupamiento de las secuencias de cada muestra por valor de calidad en
    ipyrad -p params-iptest.txt -s 3
####Resultados

    ipyrad -p params-iptest.txt -r #este da un resumen
####Imprime las primeras 28 lineas de resultados. 0.85 es el número por default, pero depende de las muestras

    gunzip -c iptest_clust_0.85/1A_0.clustS.gz | head -n 28

#Paso 4. Estimar heterocigocidad y tasa de error 

    ipyrad -p params-iptest.txt -s 4

#Paso 5. Llamar la secuencia concenso basada en el paso 4

    ipyrad -p params-iptest.txt -s 5
####Ver los resultados

    gunzip -c iptest_consens/1A_0.consens.gz | head 

#Paso 6. Agrupar las secuencias entre muestras

    ipyrad -p params-iptest.txt -s 6
#####Se crea un archivo iptest_test.hdf5

#Paso 7. Filtrar los datos por máximo número de indels, heterocigocidad, snp's por locus y el número mínimo de muestras por locus
    ipyrad -p params-iptest.txt -s 7
#####Se creará un directorio nuevo "iptest_outfiles" con los resultados en varios formatos
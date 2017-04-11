### Avances 1

##### 1.- Tipo de análisis:

Desarrollo de una filogenia con datos RAD simulados y ensamblados con pyrad.

##### 2.- Datos que se utilizarán:

Genomas completos de al menos 5 especies del género Treponema, de éstos, la mayoría fueron generados por grupos de trabajo diferentes.

##### Pasos a seguir:

1. Búsqueda y descarga de genomas completos en NCBI, con el buscador de genomas, en [https://www.ncbi.nlm.nih.gov/genome/browse/]("Buscador de genomas de NCBI")

2. En R y con el paquete SimRAD, realizaré una simulación de RAD's con una enzima de restricción: PstI (corte 5' TGCA 3'). Se aplicará el método de RADseq "original".

3. Esos fragmentos se exportarán a un archivo tipo fasta, y se buscará su compresión.

4. Conversión de los archivos a fastq (formato para leer en pyrad)

5. Ensamblaje de los fragmentos en pyrad. Este programa de correrá desde un contenedor Docker.

6. Desarrollo de una filogenia en RaxML. 
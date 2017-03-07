#! /bin/bash
#En la PowerShell:
#descargo la aplicación de blast
docker pull biocontainers/blast
#corro la aplicación de blast con la herramienta de blastp para proteínas
docker run biocontainers/blast blastp -help
#ejecuto mi contenedor con bioconatiners con un volumen cargado
docker exec -it a0b09e5c8008 bash #(docker run -v C:\Users\Erandi\Desktop\Bioinformatica:/data -it biocontainers/bioconatiners /bin/bash) 
#dentro de mi contenedor, descargo la secuencia de interés
wget http://www.uniprot.org/uniprot/P04156.fasta
#descargo las secuencias con qué comparar
curl -O ftp://ftp.ncbi.nih.gov/refseq/D_rerio/mRNA_Prot/zebrafish.1.protein.faa.gz
#descomprimo las secuencias con qué comparar
gunzip zebrafish.1.protein.faa.gz
#salgo de mi contenedor con volumen
exit
#en la PowerShell, preparo el directorio donde guardaré la base de datos de las secuencias
docker run -v C:\Users\Erandi\Desktop\Bioinformatica:/data/ biocontainers/blast makeblastdb -in zebrafish.1.protein.faa -dbtype prot
#corro docker y la herramienta de blast en biocontainers con los datos a comparar con blast
docker run -v C:\Users\Erandi\Desktop\Bioinformatica:/data/ biocontainers/blast blastp -query P04156.fasta -db zebrafish.1.protein.faa -out results.txt
#fin




#Time series analysis
#Variazione delle temperature in Groenlandia nel tempo ----> Time series analysis
# Dati di Emanuela Cosma 
# Primo pacchetto raster

setwd("C:/lab/greenland") # Windows
library(raster)
#utilizziamo la working directory greenland
# install.packages("raster")

#stack: insieme di dati multitemporali, in questo caso raster.
#importiamo i 4 strati separati che rappresentano la stima della temperatura che deriva dal programma Copernicus, consieriamo i primi 10 giorni di giugno nel 2000 2005 2010 2015
#la funzione per caricare singoli dati non si chiama piu brick ma raster. All'interno del pacchetto raster c'è una funzione che si chiama raster:
lst_2000 <- raster("lst_2000.tif")jj

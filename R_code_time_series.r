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

#mi mancava "rgdal" e la ho installata in windows

lst_2000 <- raster("lst_2000.tif")
plot(lst_2000)

lst_2005 <- raster("lst_2005.tif")
plot(lst_2005)

lst_2010 <- raster("lst_2010.tif")
plot(lst_2010)

lst_2015 <- raster("lst_2015.tif")
plot(lst_2015)

# Adesso non abbiamo piu un sensore che riporta la riflettanza, ma che riporta le temperature: passiamo da una scala decimale ad una scala intera attraverso il bits
#Digitals numbers: numeri interi-----> Shannon
#1 bit è uno spazio di informazione con 2 valori possibili, una mappa con 2 bit di informazione ha 4 colori possibili associati a numeri, 3 bit----> 8 valori associabili a colori.
#gran parte delle immagini sono a 8bit--->256 valori; 2^9 (9 bit)---> 512 valori; 2^10(10 bit)---> 1024, 2^16 (16 bit)---> 65535

#dall'immagine plottata maggiore sarà il digital numbers e maggiore sarà il valore di temperatura.

#plottiamo tutte le 4 immagini
par(mfrow=c(2,2))
plot(lst_2000)
plot(lst_2005)
plot(lst_2010)
plot(lst_2015)

#importare le immagini insieme con la funzione lapply, quindi invece che prendere il singolo file lst e portarlo dentro R tramite la funzione raster, possiamo fare una lista lst e applicare a tutti la funzione raster e portarli dentro R.
#viene fatta una list.files: crea una lista di files che R utilizzera per applicare la funzione lapply.

rlist <- list.files(pattern="lst") #list file crea una lista
rlist #lista di tutti i file che hanno al loro interno la parola lst in comune
import <- lapply(rlist,raster) #li importo tramite lapply
import

#sostanzialmete 


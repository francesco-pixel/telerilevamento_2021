DAY 14/10

#R_Code_Copernicus
#Visualizzazione dei dati copernicus
library(raster)

install.packages("ncdf4")
library("ncdf4")
#libreria per leggere netCDF

setwd("C:/lab/") 

#Diamo un nome al nostro dataset, lo carichiamo  usando la funzione raster per caricare  un singolo strato, mettiamo tra virgolette il nome del file copiato e incollato includendo l'estensione .nc
albedo <- raster("c_gls_ALBH_202006130000_GLOBE_PROBAV_V1.5.1.nc")
albedo #vediamo tutte le info del dataset

#adesso possiamo plottare la prima immagine, non montiamo in RGB ma decidiamo noi la scala di colori da utilizzare.

plot(test)

ext <- c(6, 20, 35, 50)
testc <- crop(test, ext)
plot(testc)


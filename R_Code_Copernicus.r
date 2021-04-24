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
cl <- colorRampPalette(c('black','grey','yellow','red'))(100)


plot(albedo,col=cl)
#dunque vediamo la quantità e la superficie doce viene riflessa più energia solare (la parte del deserto riflette maggiormente)

#ggplot2 ci permette di abbellire i grafici

#ora applichiamo la funzione aggregate per aggregare i pixel
albedores <- aggregate(albedo, fact=50)
#prendo pixel piu grandi, trasformando l'immagine con un minor numero di pixel per un determinato fattore
albedores

plot(albedores)
#noto come la variabile sia più veloce da visualizzare

#Data la variabile molto pesante, adesso la ricampioniamo  per un fattore 100 diminuendo la dimensione di 10000 volte il dato originale (100x100) e rifaccio il plot di albedores:
#ricampionamento bilineare:

albedores <- aggregate(albedo, fact=100)
plot(albedores, col=cl)






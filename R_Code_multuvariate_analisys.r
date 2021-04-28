#sensore atex dove ci sono centinaia di bande e di  icrosensori, possiamo compattare il dataset tramite analisi multivariata e vederlo in due dimensioni.

#Concetto di variabilità di un sistema 

#Asse componente principale 


setwd("C:/lab/") # Windows


library(raster)
library(RStoolbox)
#il satellite landsat ha varie bande, usiamo le 7 bande disponibili. se l'immagine ha sette bande. la funzione raster carica solo un set per volta mentre con brick li carichiamo tutti.

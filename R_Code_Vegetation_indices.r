#R_Code_Vegetation_indices.r


library(raster)
setwd("C:/lab/")
#carichiamo le due immagini

defor1 <- brick("defor1.jpg")
defor2 <- brick("defor2.jpg")


#facciamo il plot RGB

# b1 = NIR, b2 = red, b3 = green

par(mfrow=c(2,1))
plotRGB(defor1, r=1, g=2, b=3, stretch="lin")
plotRGB(defor2, r=1, g=2, b=3, stretch="lin")


#plot e vediamo le loro multitemporalità, in queste due immagini vi è la stessa zona perchè, il corso del fiume è lo stesso quindi è la stessa zona. tutta la parte rossa è vegetazione quella chiara è suolo agricolo.


#adesso calcoleremo l'indice di vegetazione e lo applicheremo alle due immagini per fare un analisi temporale.


#DAY 30/04


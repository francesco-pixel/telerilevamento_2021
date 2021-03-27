# il mio primo codice in R per il telerilevamento!

setwd("C:/lab/")

# install.packages("raster")
library(raster)

p224r63_2011 <- brick("p224r63_2011_masked.grd")
# Attraverso la funzione brick ho importato l'intera immagine! successivamento digitanto il nome dell'immagine ho visualizzato tutte le sue informazioni.

plot(p224r63_2011)
# ho fatto il primo plot con sette bande con dei dati satellitari!!

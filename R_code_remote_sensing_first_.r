# il mio primo codice in R per il telerilevamento!

setwd("C:/lab/")

# install.packages("raster")
library(raster)

p224r63_2011 <- brick("p224r63_2011_masked.grd")
# Attraverso la funzione brick ho importato l'intera immagine! 

p224r63_2011 
# successivamento digitando il nome dell'immagine ho visualizzato tutte le sue informazioni (tipo di file, risoluzione, informazioni sui sistemi di riferimento etc)

plot(p224r63_2011)
# ho fatto il primo plot con sette bande con dei dati satellitari!!

#stabiliamo adesso un differente range di colori sa nero a grigio chiaro, inserendo una C davanti alla parentesi ad indicare una serie di elementi (colori). il 100 indica il  numero di livelli
cl <- colorRampPalette(c('black','grey','light grey'))(100)

# plotto il colore con il primo argomento che è l'immagine mentre il secondo argimento sara il colore che daremo ad ogni singola banda
plot(p224r63_2011, col=cl)

#vediamo che nell'infrarosso c'è molta riflettanza. 

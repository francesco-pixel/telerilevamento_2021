5/01
#R_code_land_cover.r

# R code analisi multitemporale di variazione della land cover
setwd("C:/lab/")


library(raster)
install.packages("RStoolbox") 
library(RStoolbox)#per la classificazione

install.packages("ggplot2")
library(ggplot2) 

#carichiamo la prima immagine
defor1 <- brick("defor1.jpg") 

plotRGB(defor1, r=1, g=2, b=3, stretch="Lin")
#all'interno di ggplot ci sono funzioni potenti per plottare immagini----> funzioni con gg
#funzione ggRGB, essa ha bisogno dell' immagine , delle componenti RGB e stretch.
ggRGB(defor1, r=1, g=2, b=3, stretch="Lin") #otteniamo un plot con le coordinate spaziali (plot migliore)
#carico adesso la seconda immagine ed effettuo le stesse operazioni.

defor2 <- brick("defor2.jpg")
plotRGB(defor2, r=1, g=2, b=3, stretch="Lin")
ggRGB(defor2, r=1, g=2, b=3, stretch="Lin")

#mettiamo le immagine plotRGB accanto con parmfrow
par(mfrow=c(1,2))
plotRGB(defor1, r=1, g=2, b=3, stretch="Lin")
plotRGB(defor2, r=1, g=2, b=3, stretch="Lin")


#per mettere le immagini accanto o incolonnate non usiamo parmfrow come per plotRGB ma con ggplot si fa  con la funzione grid
#per farlo installiamo gridExtra
#multiframewith ggplot2 andgridExtra
install.packages("gridExtra")
library(gridExtra)

#usiamo adesso la funzione grid.arrange che mette insieme vari pezzi dentro il grafico
p1 <- ggRGB(defor1, r=1, g=2, b=3, stretch="Lin")
p2 <- ggRGB(defor2, r=1, g=2, b=3, stretch="Lin")
grid.arrange(p1, p2, nrow=2)
#immagini disposte su due righe

#utilizzzeremo ggplot per vedere la diminuzione nella foresta amazzonica e la plotteremo visualizzando il cambiamento




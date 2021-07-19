5/05
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


DAY 7/05
#differenza tra vegetazione e uso del suolo (copertura). la vegetazione è piu particolareggiata con le singole specie dominanti. 
#per la vegetaazione abbiamo bisogno di sensori iperspettrali e quindi molte bande per distinguere le specie.

#facciamo l'unsupervised(non viene supervisionata da noi inizialmente) classification 
# classificazione non supervisionata
d1c <- unsuperClass(defor1, nClasses=2) #immmagine e numero di classi
d1c #due valori
#abbiamo d1c che è il modello e la mappa che abbiamo creato e lo plotiamo
plot(d1c$map)
#classe 1 agricola
#classe due non agricola
#creiamo la seconda mappa 

d2c <- unsuperClass(defor2, nClasses=2) #immmagine e numero di classi
d2c #due valori
plot(d2c$map)

#facciamo una classificazione a 3 classi per riuscire ad identificare il fiume
d2c3 <- unsuperClass(defor2, nClasses=3) #immmagine e numero di classi
d2c3 #due valori
plot(d2c3$map)
#la parte agricola è stata distinta in due parti
#quanta foresta è stata persa? effettuiamo dei calcoli. calcoliamo la frequenza dei pixel delle classi con la funzione 
#frequenza delle due classi:
freq(d1c$map) #la classe n1 vs n2

#valori riguardo le aree aperte =    307841 pixel
#valori riguardo la foresta =  33451 pixel

#facciamo la proporzione tra questi due valori

s1 <-  307841 + 33451
s1

prop1 <- freq(d1c$map) / s1
prop1
#[1,] 2.930042e-06 0.90198715 #foresta
[2,] 5.860085e-06 0.09801285 #agricolo

#proporzioni nella seconda immagine
s2 <- 342726
prop2 <- freq(d2c$map) / s2
prop2
[1,] 2.917783e-06 0.5224261 #foresta
[2,] 5.835565e-06 0.4775739 #agricolo

#costruiamo un dataframe con righe e colonne
cover <- c("Agriculture","Forest")
percent_1992 <- c(9.8,90.2)
percent_2006 <- c(47.7,52.2)

#funzione per creare un dataframe
percentages <- data.frame(cover,percent_1992,percent_2006)
percentages
#facciamo un grafico con ggplot

library(ggplot2)
#p1<-ggplot(output, aes(x=cover, y=before, color=cover)) + geom_bar(stat="identity", fill="white")  
ggplot(percentages, aes(x=cover, y=percent_1992, color=cover)) + geom_bar(stat="identity", fill="white")
#geometria a barre #dati originati identity #color: quali oggetti discriminare #fill: di che colore voglio le barre all'interno
#vediamo nel grafico la parte agricola  molto bassa e foresta molto alta. la legenda = cover
#facciamo la stessa operazione per il plot del 2006
ggplot(percentages, aes(x=cover, y=percent_2006, color=cover)) + geom_bar(stat="identity", fill="white")

#le due barre adesso sono simili
#grid.arrange mette insieme i plot grafici in una pagina, associamo i plot ad un  nome (p1,p2) e poi li plottiamo insieme con grid.arrange
p1 <- ggplot(percentages, aes(x=cover, y=percent_1992, color=cover)) + geom_bar(stat="identity", fill="white")
p2 <- ggplot(percentages, aes(x=cover, y=percent_2006, color=cover)) + geom_bar(stat="identity", fill="white")
grid.arrange(p1, p2, nrow=1)

#vediamo il plot con i valori, vediamo le differenze tra il 1992 e il 2006 nello stesso grafico. siamo passati da un immagine satellitare ad un grafico che ci mostra i cambiamenti multitemporali.

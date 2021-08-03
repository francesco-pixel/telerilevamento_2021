#R_code_project_exam.r
#Analisi della land cover del Fiume del Missisipi


#R_code variazione della land cover nella parte superiore del bacino idrografico del Fiume Missisipi 
#Durante la prima metà del 1993, il Midwest statunitense ha subito piogge insolitamente forti. Gran parte degli Stati Uniti nella parte superiore del bacino
#idrografico del fiume Mississippi ricevettero più di 1,5 volte le loro precipitazioni medie nei primi sei mesi dell'anno.#
#Questa coppia di immagini mostra l'area intorno a St. Louis, Missouri, nell'agosto 1991 e nel 1993. 
#L'immagine del 1993 è stata catturata leggermente dopo il picco dei livelli dell'acqua in questa parte del fiume Mississippi.
#Questa immagine a falsi colori è stata creata combinando lunghezze d'onda infrarosse,
#infrarosse vicine all'infrarosso e verdi di luce osservate dallo strumento Thematic Mapper (TM) a bordo del satellite Landsat
#L'acqua appare blu scuro, la vegetazione sana è verde, i campi nudi e il terreno appena esposto sono rosa e il cemento è grigio. 
#Inoltre, il diffuso cambiamento della copertura del suolo lungo fiumi e torrenti ha modificato drasticamente i sistemi naturali di controllo
#Sensori:
#Landsat 5 - TM

# 14 agosto 1991
# 19 agosto 1993


##Utilizzo gli algoritmi di classificazione delle immagini e faccio un analisi multitemporale della variazione della copertura del suolo, successivamente calcolo alcuni parametri.


setwd("C:/lab/")


library(raster)


install.packages("RStoolbox") 
library(RStoolbox)#per la classificazione dell immagini

install.packages("ggplot2")
library(ggplot2) #per effettuare dei plottaggi dettagliati
#installo anche gridExtra per effettuare piu plottaggi insieme c

install.packages("gridExtra")
library(gridExtra)

#metto a confronto due immagini gia processate che hanno perso il proprio sistema di riferimento originale e faccio un analisi multitemporale

#carico la prima immagine con la funzione brick
stlouis91 <- brick("stlouis91.jpg") 

stlouis91
#vediamo tutte le informazioni del dato tra cui crs che è il sistema di riferimento ed è uguale ad NA perche non ha più sistema di riferimento perche è stata scaricata dall'earth obs.

plotRGB(stlouis91, r=1, g=2, b=3, stretch="Lin")
#all'interno di ggplot ci sono funzioni potenti per plottare immagini----> funzioni con gg
#funzione ggRGB, essa ha bisogno dell' immagine , delle componenti RGB e stretch.
#faccio un ggplot
ggRGB(stlouis91, r=1, g=2, b=3, stretch="Lin") #otteniamo un plot con le coordinate spaziali (plot migliore)


#carico adesso la seconda immagine ed effettuo le stesse operazioni.

stlouis93 <- brick("stlouis93.jpg")
plotRGB(stlouis93, r=1, g=2, b=3, stretch="Lin")
ggRGB(stlouis93, r=1, g=2, b=3, stretch="Lin")

#metto le immagine plotRGB accanto con la funzione parmfrow e le metto a confronto
par(mfrow=c(1,2))
plotRGB(stlouis91, r=1, g=2, b=3, stretch="Lin")
plotRGB(stlouis93, r=1, g=2, b=3, stretch="Lin")








#usiamo adesso la funzione grid.arrange che mette insieme vari pezzi dentro il grafico
p1 <- ggRGB(stlouis91, r=1, g=2, b=3, stretch="Lin")
p2 <- ggRGB(stlouis93, r=1, g=2, b=3, stretch="Lin")
grid.arrange(p1, p2, nrow=2)
#immagini disposte su due righe




#facciamo l'unsupervised classification (non viene supervisionata da noi) 
# classificazione non supervisionata
st1 <- unsuperClass(stlouis91, nClasses=2) #immmagine e numero di classi
st1c #due valori
#abbiamo d1c che è il modello e la mappa che abbiamo creato e lo plotiamo
plot(d1c$map)
#classe 1 agricola
#classe due non agricola














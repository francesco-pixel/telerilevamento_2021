#R_code_project_exam.r
#Analisi della land cover del Fiume del Missisipi


#R_code variazione della land cover nella parte superiore del bacino idrografico del Fiume Missisipi 
#Durante la prima metà del 1993, il Midwest statunitense ha subito piogge insolitamente forti. Gran parte degli Stati Uniti nella parte superiore del bacino
#idrografico del fiume Mississippi ricevettero più di 1,5 volte le loro precipitazioni medie nei primi sei mesi dell'anno.#
#Questa coppia di immagini mostra l'area intorno a St. Louis, Missouri, nell'agosto 1991 e nel 1993. 
#L'immagine del 1993 è stata catturata leggermente dopo il picco dei livelli dell'acqua in questa parte del fiume Mississippi.
#Questa immagine a falsi colori è stata creata combinando lunghezze d'onda infrarosse,
#infrarosse vicine all'infrarosso e verdi di luce osservate dallo strumento Thematic Mapper (TM) a bordo del satellite Landsat
#L'acqua appare blu scuro, la vegetazione sana è verde, i campi nudi e il terreno appena esposto sono rosa. 
#Inoltre, il diffuso cambiamento della copertura del suolo lungo fiumi e torrenti ha modificato drasticamente i sistemi naturali di controllo

#NASA images created by Jesse Allen, Earth Observatory, using data provided courtesy of the Landsat Project Science Office.
#Sensori:
#Landsat 5 - TM

# figure 1: 14 agosto 1991
# figure 2: 19 agosto 1993


##Utilizzo gli algoritmi di classificazione delle immagini e faccio un analisi multitemporale della variazione della copertura del suolo, successivamente calcolo alcuni parametri.


setwd("C:/lab/")


library(raster)


install.packages("RStoolbox") 
library(RStoolbox)#per la classificazione dell immagini

install.packages("ggplot2")
library(ggplot2) #per effettuare dei plottaggi dettagliati
#installo anche gridExtra per effettuare piu plottaggi insieme 

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


#Faccio una classificazione  

#facciamo l'unsupervised classification (non viene supervisionata da noi) 
# classificazione non supervisionata
st1 <- unsuperClass(stlouis91, nSamples=10000, nClasses=3) 

#immmagine e numero di classi, utilizza 10000 pixel random e fa una classificazione in 3 classi

st1 #due valori
# st1  è il modello e poi ho la mappa che ho creato che lego con il dollaro ottenendo la mappa
plot(st1$map)
#Vedo una classe in bianco data dall'acqua,
#grazie ai diversi valri di riflettanza osserviamo diversi colori  che danno diverse classi 

#classe  agricola e vegetazione sana, non lavorata e senza poderi
#classe 1 suolo esposto in rosa
#classe 2 vegetazione sana
#classe 3 acqua fiume

#classifico la seconda immagine del 1993
st2 <- unsuperClass(stlouis93, nSamples=10000, nClasses=3) 

st2
plot(st2$map)

#classe 1 suolo esposto in rosa
#classe 2 vegetazione sana
#classe 3 acqua fiume

#mettendo a confronto le due mappe posso calcolare lincremento di acqua che ha avuto il fiume Missisipi ed i suoi affluenti





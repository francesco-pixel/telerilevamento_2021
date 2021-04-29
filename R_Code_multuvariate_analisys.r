#DAT 23/04

#sensore atex dove ci sono centinaia di bande e di  icrosensori, possiamo compattare il dataset tramite analisi multivariata e vederlo in due dimensioni.

#Concetto di variabilità di un sistema 

#Asse componente principale 


setwd("C:/lab/") # Windows


library(raster)
library(RStoolbox)
#il satellite landsat ha varie bande, usiamo le 7 bande disponibili. se l'immagine ha sette bande. la funzione raster carica solo un set per volta mentre con brick li carichiamo tutti.
# R_code_multivariate_analysis.r



p224r63_2011 <- brick("p224r63_2011_masked.grd") 
plot(p224r63_2011)
p224r63_2011 #7 livelli, risoluzione 30 metri.

#adesso facciamo un plot della banda 1 vs la banda 2
 
plot(p224r63_2011$B1_sre, p224r63_2011$B2_sre, col="red", pch=19, cex=2)  
#le informazioni su un punto sulle x è molto simile alle informazioni di un punto sulle y

#pch è il point charter 19 ed aumento la dimens. dei punti.
#se noi volessimo farlo per tutte le bande e usiamo la funzione pairs, per plottare tutte le correlazioni possibili tra tutte le variabili possibili e vedere a coppie come sono correlate le variabili tra di loro.

pairs(p224r63_2011)
#è possibile osservare ciò che si correla al meglio, vengono cosi messe in relazione a due a due tutte le variabili, le variabili sono le bande.
#sulla parte alte della nostra matrice si osserva l'indice della bicorrelazione di pearson varia tra -1 e 1. se siamo ben correlati l'indice si aggira ad 1 viceversa va a -1
#notiamo che queste bande il molti casi sono ben correlate tra di loro
#quindi possiamo usare l'analisi multivariate per compattare il nostro sistema in un numero differenti di bande conservando la stessa informazione.

#DAY 28/04
#la PCA è molto impattante, di conseguenza ricampioniamo il nostro dato rendendolo piu leggero attraverso la funzione aggregate.
#abbiamo 30 pixel di risoluzione. possiamo aggregare i pixel per un fattore 10 in modo tale da avere un'immagine meno pesante. attualmente 31 mln di pixel.
#diminuiamo la risulizone tramite aggregate
#aggreghiamo le celle, ricampionamento:resampling
p224r63_2011res <- aggregate(p224r63_2011, fact=10) #aggreghiamo di un fattore 10, diminuendo la risolzione da 30m a 300m aumentando la grandezza del pixel diminuiamo la risoluzione

#adesso per vederlo facciamo un pannello con 2 immagini e lo plottiamo
par(mfrow=c(2,1))
    
    
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="lin") #dato originale con tanti pixel
plotRGB(p224r63_2011res, r=4, g=3, b=2, stretch="lin") 
#quella sopra 30x30
#quella sotto pixel 300x300m #quindi quella ricampionata

#raster PCA: prende il pacchetto dei dati e li compatta in un numero minore di bande
p224r63_2011res_pca <- rasterPCA(p224r63_2011res)

#quindi abbiamo preso l'immagine originale abbiamo fatto la PCA e generato una nuova immagine , creato una mappa in uscita e un modello 
#la funzione summary ci da un sommario del nostro modello e visualizzarlo

summary(p224r63_2011res_pca$model) 

#facciamo il plot totale


plot(p224r63_2011res_pca$map) 

p224r63_2011res_pca


#la prima componente con molta informazione mentre l'ultima la 7 non ha molta info. la prima presenta molta variabilità


#plottiamo in rgb tutta l'immagine con le 3 componenti principali

plotRGB(p224r63_2011res_pca$map, r=4, g=3, b=2, stretch="lin") 
#immagine risultante dall'analisi delle 3 componenti principali





        
 

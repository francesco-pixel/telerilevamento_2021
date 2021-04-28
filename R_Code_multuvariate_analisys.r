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


 

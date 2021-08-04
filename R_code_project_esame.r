#R_code_project_exam.r
#Analisi della land cover del Fiume Missisipi


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

st1 #tre valori
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

#mettendo a confronto le due mappe posso calcolare l'incremento di acqua che ha avuto il fiume Missisipi, il Missouri ed il illinois river.
#calcolo la frequenza dei pixel di una certa classe chiedendomi quanti pixel ho delle corrisettive 3 classi e come sono state modificate dal 1991 al 1993 a causa delle intense piogge

#utilizzo la funzione freq per calcolare la frequeza dei pixel della mappa generata
freq(st1$map)
#value   count
#[1,]     1 7357344 pixel
#[2,]     2 5193331 pixel
#[3,]     3  409325 pixel

#calcolo la proporzione fra le tre classi di pixel nel 1991:

somma1 <- 7357344 + 5193331 + 409325
somma1

#faccio la proporzione facendo fre/somma valori (in %)
prop1 <- freq(st1$map) / somma1
prop1 #1991
#prop. 56.769630 suolo esposto
#prop. 40.071998 vegetazione sana
#prop. 3.158372 acqua river


 #utilizzo la funzione freq per calcolare la frequeza dei pixel della mappa generata
freq(st2$map)
#     value   count
#[1,]     1 7906266
#[2,]     2 3606231
#[3,]     3 1447503




#calcolo la proporzione per l'anno 1993
somma2 <- 7906266 + 3606231 + 1447503
somma2

#faccio la proporzione facendo freq/somma valori (in %)
prop2 <- freq(st2$map) / somma2
prop2 #1993

            value     count
#prop1. 61.00514 suolo esposto
#prop2. 27.82586 vegetazione sana
#prop3. 11.16900 acqua river

#adesso genero un dataset contenente i fattori e cioe delle variabili categoriche: suolo nudo, vegetazione sana e acqua con i rispettivi valori in % del 1991 e del 1993

#costruisco il mio dataframe


cover <- c("suolo esposto", "vegetazione sana", "acqua")
percent_1991 <- c(56.76, 40.07, 3.15)
percent_1993 <- c(61.00, 27.82, 11.16)

#con la funzione data.frame creo una tabella

percent <- data.frame(cover, percent_1991, percent_1993)
percent

# cover percent_1991 percent_1993
# 1 suolo esposto, vegetazione sana, acqua        56.76        61.00
# 2 suolo esposto, vegetazione sana, acqua        40.07        27.82
# 3 suolo esposto, vegetazione sana, acqua         3.15        11.16


#con la funzione ggplot faccio due buon  grafici e li metto a confronto 

g91 <- ggplot(percent, aes(x=cover, y=percent_1991, color=cover)) + geom_bar(stat="identity", fill="grey")

g93 <- ggplot(percent, aes(x=cover, y=percent_1993, color=cover)) + geom_bar(stat="identity", fill="grey")
#tra il 1991 e il 1993 notiamo un netto incremento di acqua 
#metto i due grafici a confronto con la funzione grid.arrange



grid.arrange(g91, g93, nrow=2)
#in questa zona della terra tra il 1991 e il 1993 notiamo un netto incremento di acqua con esondazioni da parte dei fiumi, vi è anche una diminuzione della vegetazione sana.
#ho analizzato un cambiamento multitemporale nell'area del Missisipi data da eventi metereologici intensi.





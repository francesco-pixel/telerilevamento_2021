#R_code_spectral_signatures.r

#impronte digitali di immagini satellitari, ad esempio ogni roccia o minerale ha la propria capacità di riflettere la luce, atttraverso un sensore quindi è possibile distinguere una roccia o minerale da un altro.
library(raster)
library(ggplot2)
library(rgdal) #libreria 
library(ggplot2) #per fare dei plot piu efficienti

setwd("C:/lab/") 

defor2 <- brick("defor2.jpg")
plotRGB(defor2, r=1, g=2, b=3, stretch="Lin")
defor2
#3 bande, defor2.1, defor2.2, defor2.3 che corrissondono a NIR, RED E GREEN


defor2 <- brick("defor2.jpg")

#primo plot dell'immagine 
#la funzione per creare le fir e spettrali si chiama click

click(defor2, id=T, xy=T, cell=T, type="p", pch=16, cex=4, col="orange") 
#vediamo tutte le varie informazioni cliccando su un punto dell'immagine e i vari valori r b g

# x     y   cell defor2.1 defor2.2 defor2.3
1 176.5 216.5 187314      186        9       29
      x     y  cell defor2.1 defor2.2 defor2.3
1 177.5 358.5 85501      172      172      160


#creiamo un dataframe er le linee spettrali, creiamo una tabella con  colonne (banda, foresta e acqua e vediamo i rispettivi valori di riflettanza)
#definiamo le colonne del dataset

band <- c(1,2,3)
forest <- c(186,9,29)
water <- c(172,172,160)

#mettiamo questi dati in una tabella dataframe

tabelspectral <- data.frame(band, forest, water)

#plottaggio tramite ggplot,  definendo l'asse x con un solo parametro 
#geom_line connette le osservazioni con il dato definito sulla x , lo abbiamo definito con ggplot dicendo che sulla x abbiamo le tre bande sulla quale calcoleremo le riflettanze.

ggplot(tabelspectral, aes(x=band)) +
geom_line(aes(y=forest), color="green") +
geom_line(aes(y=water), color="blue") +
labs(x="band", y="reflectance")

#sulla y avremo i valori di riflettanza 
#osseriamo nel grafico  il valore della riflettanza di un singolp pixel nelle tre bande, tanta riflettanza nell banda 1, bassa nella 2 e una un po piu alta nel 3 che è up verde
#dopo aver aggiunto i valori di riflettanza dell'acqua vediamo che quest'ultima ha un comportamento opposto rispetto alla vegetazione.
#aggiungiamo la funzione labs 


##############analisi multitemporale 

defor1 <- brick("defor1.jpg")


plotRGB(defor1, r=1, g=2, b=3, stretch="Lin")
#creiamo lo spectral signatures del defore 1  e clicchiamo 5 punti casuali

click(defor1, id=T, xy=T, cell=T, type="p", pch=16, cex=4, col="orange")

#    x     y  cell defor1.1 defor1.2 defor1.3
#1 74.5 403.5 52911      213       27       51
#     x     y  cell defor1.1 defor1.2 defor1.3
#1 93.5 391.5 61498      213       23       49
#     x     y  cell defor1.1 defor1.2 defor1.3
#1 93.5 366.5 79348      223       18       35
#     x     y   cell defor1.1 defor1.2 defor1.3
#1 93.5 322.5 110764      215       20       34
#     x     y  cell defor1.1 defor1.2 defor1.3
#1 49.5 352.5 89300      164       18       31

#facciamo la stessa cosa per defor2

plotRGB(defor2, r=1, g=2, b=3, stretch="Lin")

click(defor2, id=T, xy=T, cell=T, type="p", pch=16, cex=4, col="orange")

#     x     y  cell defor2.1 defor2.2 defor2.3
#1 36.5 393.5 60265      151       25       28
#     x     y  cell defor2.1 defor2.2 defor2.3
#1 58.5 419.5 41645      206       14       29
#     x     y  cell defor2.1 defor2.2 defor2.3
#1 80.5 401.5 54573      202        5       22
#     x     y  cell defor2.1 defor2.2 defor2.3
#1 78.5 368.5 78232      201        8       27
#     x     y  cell defor2.1 defor2.2 defor2.3
#1 48.5 344.5 95410      170      106      106

#definiamo le colonne del dataset con il dataframe 

band <- c(1,2,3)
time1 <- c(213,27,51)
time2 <- c(151,25,28)

#vediamo nella stessa zona cosa sia successo 

tabelspectral <- data.frame(band, time1, time2)

#ora con ggplot plottermo queste due curve 
ggplot(tabelspectral, aes(x=band)) +
geom_line(aes(y=forest), color="red") +
geom_line(aes(y=water), color="gray") +
labs(x="band", y="reflectance")
#abbiamo il pixel rosso del primo periodo che  è vegetato e l'altissima riflettanza dell'infrarosso, e vediamo il pixel del secondo momento, l'nfrarosso è ancora alto perche siamo ancora in una zona perchè non è ancora suolo nudo  

# a questo possiamo aggiungere un secondo pixel con time1p2 e ci metto i valori del secondo pixel del primo periodo e i valori rime2p2 del secondo periodo 

band <- c(1,2,3)
time1 <- c(213,27,51)
time1p2 <- c(213,23,49)
time2 <- c(151,25,28)
time2p2 <- c(206,14,29)


#abbiamo aggiunto i secondi pixel e aggiungiamo un 'altra linea anche a ggplot




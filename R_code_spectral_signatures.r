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
#osseriamo nel grafico  il valore della riflettanza di un singolo pixel nelle tre bande, tanta riflettanza nell banda 1, bassa nella 2 e una un po piu alta nel 3 che è up verde
#dopo aver aggiunto i valori di riflettanza dell'acqua vediamo che quest'ultima ha un comportamento opposto rispetto alla vegetazione.
#aggiungiamo la funzione labs 


##############analisi multitemporale 

defor1 <- brick("defor1.jpg")


plotRGB(defor1, r=1, g=2, b=3, stretch="Lin")
#creiamo lo spectral signatures del defore 1  e clicchiamo 5 punti casuali per osservare le differenze e riportiamo commentando i valori ottenuti 

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

#facciamo la stessa cosa per defor2 e riportiamo i valori ottenuti 

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

#definiamo le colonne del dataset e costruiamo il dataframe 

band <- c(1,2,3)
time1 <- c(213,27,51)
time2 <- c(151,25,28)

#vediamo nella stessa zona cosa sia successo 

tabelspectral <- data.frame(band, time1, time2)

#ora con ggplot plottermo queste due curve 
ggplot(tabelspectral, aes(x=band)) +
geom_line(aes(y=time1), color="red") +
geom_line(aes(y=time2), color="gray") +
labs(x="band", y="reflectance")
#abbiamo il pixel rosso del primo periodo che  è vegetato e l'altissima riflettanza dell'infrarosso, e vediamo il pixel del secondo momento, l'nfrarosso è ancora alto perche siamo ancora in una zona perchè non è ancora suolo nudo  

# a questo possiamo aggiungere un secondo pixel con time1p2 e ci metto i valori del secondo pixel del primo periodo e i valori rime2p2 del secondo periodo 

band <- c(1,2,3)
time1 <- c(213,27,51)
time1p2 <- c(213,23,49)
time2 <- c(151,25,28)
time2p2 <- c(206,14,29)


#abbiamo aggiunto i secondi pixel e aggiungiamo un 'altra linea anche a ggplot

ggplot(tabelspectral, aes(x=band)) +
geom_line(aes(y=time1), color="red", inetype="dotted") +
geom_line(aes(y=time1p2), color="red", linetype="dotted") +
geom_line(aes(y=time2), color="gray", linetype="dotted") +
geom_line(aes(y=time2p2), color="gray", linetype="dotted") +
labs(x="band", y="reflectance")


#linetype per differenziare le diverse linee ottenute 
#le formazioni ricavate si differenziano molto, la riflettanza nelle  bande si comporta in maniera differente, differenti firme e parabole, riesco ad indentificare e vedere differenziazioni tra le varie classi

#####################################################################################

#cerchiamo un'altra immagine da earth observatory
#pennacchi di fumo causati da incendi in North America

smokeo <- brick("NA.jpg")


plotRGB(smokeo, 1,2,3, stretch="hist") #hist per osservare pure le sottili differenze 
#utilizzo la funzione click su questa immagine 

click(smokeo, id=T, xy=T, cell=T, type="p", pch=16, cex=4, col="orange")

#
#       x      y    cell NA..1 NA..2 NA..3
#1 1489.5 3890.5 6200266   239   169    73
#       x      y    cell NA..1 NA..2 NA..3
#1 1892.5 3402.5 8849533   152   178   179
#      x      y    cell NA..1 NA..2 NA..3
#1 2705.5 3873.5 6293758    79    25     0
#Error in graphics::locator(1, type, ...) : 
#  graphics device closed during call to locator or identify


#creiamo la tabella e il nosto dataframe e differenziamo i tre diversi strati smoke a diversa intensità 

band <- c(1,2,3)
strato1 <- c(239,169,73)
strato2 <- c(152,178,179)
strato3 <- c( 79,25,0) #ho beccato un valore di riflettanza 0!

#creo il mio dataframe che chiamero smokespectrals
smokespectral <- data.frame(band, strato1, strato2, strato3)
#posso osservare il mio dataset digitando smokespectral

# band strato1 strato2 strato3
#1    1     239     152      79
#2    2     169     178      25
#3    3      73     179       0

#plot spectral signature 


ggplot(smokespectral, aes(x=band)) +
geom_line(aes(y=strato1), color="red", inetype="dotted") +
geom_line(aes(y=strato2), color="blue", linetype="dotted") +
geom_line(aes(y=strato3), color="black", linetype="dotted") +
labs(x="band", y="reflectance")
#le tre formazioni ricavate si differenziano molto, la riflettanza nelle tre bande si comporta in maniera differente, la banda nera ha una riflettanza piu bassa, differenti firme e parabole, riesco ad indentificare e vedere differenziazioni tra le varie classi
 













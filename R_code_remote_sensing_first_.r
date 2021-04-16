# il mio primo codice in R per il telerilevamento!
# seleziono la cartella di riferimento lab

setwd("C:/lab/") #windows

# install.packages("raster")
library(raster)
#importo i dati con la funzione brick

p224r63_2011 <- brick("p224r63_2011_masked.grd")
# Attraverso la funzione brick ho importato l'intera immagine! (immagine p224 ovverso stiamo seguendo il percorso sinusoide p224, incrociandolo con la riga 63, così troveremo l'immagine landsat di interesse---> parakana)

p224r63_2011 
# successivamento digitando il nome dell'immagine ho visualizzato tutte le sue informazioni (tipo di file, risoluzione, informazioni sui sistemi di riferimento etc)

plot(p224r63_2011)
# ho fatto il primo plot con sette bande con dei dati satellitari!!

#stabiliamo adesso un differente range di colori sa nero a grigio chiaro, inserendo una C davanti alla parentesi ad indicare una serie di elementi (colori). il 100 indica il  numero di livelli
cl <- colorRampPalette(c('black','grey','light grey'))(100)

# plotto il colore con il primo argomento che è l'immagine mentre il secondo argimento sara il colore che daremo ad ogni singola banda
plot(p224r63_2011, col=cl)

#vediamo che nell'infrarosso c'è molta riflettanza. 

#adesso provo ad osservare la riflettanza con dei diversi colori:
cl <- colorRampPalette(c('yellow','grey','pink','white','green','red','orange','blue'))(100)

plot(p224r63_2011, col=cl)

# le analisi multitemporali sia geologiche che non...sono molto interessanti! cosa succede in varie aree del mondo nel tempo?----> https://earthobservatory.nasa.gov/
# è importante conoscere il sistema di riferimento, e cioè da dove partiamo per poter calcolare le coordinate ricercate. Latitudine e longitudine non sono coordinate assolute ma dipendono dal sistema di riferimento.
# sistema di riferimento WGS84 WORLD GEODETIC STSTEM 1984, ellissoide di riferimento per le coordinate.


# adesso passeremo dalla terra in 3D alla terra in 2D portando la terra dall'ellissoide al piano attraverso la suddivisione in fusi----mercator project UTM, INOLTRE POSSIAMO PASSARE DA UN SISTEMA DI RIFERIMENTO ALL'ALTRO PARTENDO DA UN SISTEMA DI RIFERIMENTO GIA DEFINITO.
# ADESSO VEDREMO COME LAVORARE SULLE SINGOLA BANDE DI IMMAGINI DA SATELLITE E COME PLOTTARE PIU BANDE INSIEME. 



# DAY 3 
# BANDE LANDSAT

# B1: blu
# B2: verde
# B3: rosso
# B4: infrarosso vicino
# B5: infrarosso medio
# B6: infrarosso termico
# B7: infrarosso medio


dev.off()
# Tale comando ripulisce la finestra grafica in modo tale da riportare le impostazioni grafiche a 0

#il simbolo che mi permette di legare la banda 1 all'immagine totale è $
plot(p224r63_2011$B1_sre)
plot(p224r63_2011$B1_sre, col=cl)

# utilizzero la funzione par che serve per effettuare un settaggio dei parametri grafici di un grafico che voglio creare.
#faremo un multiframe MF (immagine accanto ad un altra) in una riga e due colonne tramite la funzione par utilizzando il vettore c o array in righe e colonne
par(mfrow=c(2,1)) #due righe e una colonna, cosi utilizziamo bene lo spazio, è possibile metterle anche su una riga e due colonne. se mettiamo col al posto di frow mettendo prima il numero di colonne.
plot(p224r63_2011$B1_sre)
plot(p224r63_2011$B2_sre)

 # plot di 4 righe e 1 colonna:

par(mfrow=c(4,1))
plot(p224r63_2011$B1_sre)
plot(p224r63_2011$B2_sre)
plot(p224r63_2011$B3_sre)
plot(p224r63_2011$B4_sre)
#impostiamo le bande con 2 righe e 2 colonne
par(mfrow=c(2,2))
plot(p224r63_2011$B1_sre)
plot(p224r63_2011$B2_sre)
plot(p224r63_2011$B3_sre)
plot(p224r63_2011$B4_sre)

# facciamo una prima color.palette per il blue e poi plotto la mia immagine con la c.palette che ho inventato per il blue
par(mfrow=c(2,2))
clb <- colorRampPalette(c('darkblue','blue','light blue'))(100)
plot(p224r63_2011$B1_sre, col=clb)

#aggiungiamo quella del verde
clg <- colorRampPalette(c('darkgreen','green','light green'))(100)
plot(p224r63_2011$B2_sre, col=clg)
#adesso aggiungo la banda del rosso
clr <- colorRampPalette(c('darkred','red','pink'))(100)
plot(p224r63_2011$B3_sre, col=clr)

#aggiungo la banda dell'infrarosso
clnir <- colorRampPalette(c('red','orange','yellow'))(100)
plot(p224r63_2011$B4_sre, col=clnir)

#con la funzione par è possibile plottare più immagini insieme (es.plottaccio ghiacciai, vegetazione, diversità ecc)

DAY4 


# adesso lavorerò e capirò cosa è un plotter in RGB
#seleziono la cartella di riferimento lab

setwd("C:/lab/") #windows
# install.packages("raster")
library(raster)
#importo i dati con la funzione brick
p224r63_2011 <- brick("p224r63_2011_masked.grd")
# BANDE LANDSAT

# B1: blu
# B2: verde
# B3: rosso
# B4: infrarosso vicino
# B5: infrarosso medio
# B6: infrarosso termico
# B7: infrarosso medio

#uno schema RGB: ogni display utilizza questi 3 colori principali reed green blue. 
#RGB ci permette di associare solo 3 bande  su 7---> questo schema ci permette di vedere come se avessimo solamente colori naturali.
# Poi plotto in RGB, associamoo ogni singola banda ad una componente dello schema RGB
# Poi utilizzo l'argomento stretch, prendendo la riflettanza delle singole bande e le stiriamo in modo tale che non vi sia schiacciamento verso una sola parte del colore.
#ricordiamo la riflettanza: rapporto energia riflessa su energia totale. va da 0 a 1 applicando uno strecth lineare.


#schema RGB in colori naturali, immagine a colori naturali. Usiamo il numero del layer perchè chi ha pensato il comando ha utilizzato i numeri invece del nome delle bande.
plotRGB(p224r63_2011, r=3, g=2, b=1, stretch="Lin") 

#Adesso utilizziamo gli altri colori, togliamo la banda del blu e facciamo uno scatto di 1. si ha la banda n.4 dell'infrarosso che è la piu riflettente montandolo sulla componente red RGB:
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="Lin")
# Quindi le nostre percezioni dipendono dai nostri sensori. La vegetazione risulta essere rossa perche abbiamo montato l'infrarosso nel red e la vegetazione nel rosso aveva un'altissima riflettanza. (vale anche per i minerali)
#vediamo cosa succede se spostiamo la banda dell'infrarosso (ad esempio sulla green):
plotRGB(p224r63_2011, r=3, g=4, b=2, stretch="Lin")
#quindi cambiando la banda vediamo processi ecologici che prima non vedevamo (componente di ombre, campi, H2O ecc)
#infine montiamo l'infrarosso  (banda 4) nel blu:
plotRGB(p224r63_2011, r=3, g=2, b=4, stretch="Lin")
#facciamo par e plottiamo le 4 immagini (multiframe):
#esercizio
pdf("primo_pdf_con_R.pdf")
par(mfrow=c(2,2))
plotRGB(p224r63_2011, r=3, g=2, b=1, stretch="Lin") 
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="Lin")
plotRGB(p224r63_2011, r=3, g=4, b=2, stretch="Lin")
plotRGB(p224r63_2011, r=3, g=2, b=4, stretch="Lin")
dev.off()
#quindi abbiamo aperto un pannello vuoto 2 riche per 2 colonne e inserito le 4 immagini. usando i colori naturali gran parte delle sfumature del paesaggio vengono perse, per vederle dobbiamp utilizzare l'infrarosso vicino.
#è possibile vedere le sorgenti con questo metofo nel telerilevamento?
#funzione per fare un pdf dalla nostra immagine:
#pdf("primo_pdf.pdf")

#finora abbiamo fatto uno stretch lineare ma si puo fare anche curvilineo hisogram strech e grazie all'immagine ricavata riusciamo a vedere all'interno della foresta e aree piu umide e differenziarle e grazie all'immagine satellitare possimo evidenziare alcune cose che ad occhio nudo non potremmo:
plotRGB(p224r63_2011, r=3, g=4, b=2, stretch="Lin")
plotRGB(p224r63_2011, r=3, g=4, b=2, stretch="hist") 

#pssiamo fare un parmfrow 
par(mfrow=c(3,1


#R code completo

#SOMMARIO
#----------------------------------------

#1. Remote sensing first code 
#2. R code time series
#3. R code Copernicus




#1. Remote sensing first code 
#------------------------------------------------------------------
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

#possiamo fare un parmfrow , siamo partiti da un immagine di come lo vedrebbe l'occhio umano fino ad arrivare ad un immagine con uno strech per histogrammi che individua tutte le differenti componenti all'interno della foresta in modomvia via piu dettagliato. I colori vengono fuori dai livelli sovrapposti (colori effettivi).
par(mfrow=c(3,1))
plotRGB(p224r63_2011, r=3, g=2, b=1, stretch="Lin")
plotRGB(p224r63_2011, r=3, g=4, b=2, stretch="Lin")
plotRGB(p224r63_2011, r=3, g=4, b=2, stretch="hist")

#day 5 Analisi delle componenti principali, Rstoolbox
#ho un valore elevato sulla componente rossa, intermedio sulla componente blu e basso sulla componente verde. quindi il colore non lo decidiamo noi ma il softwewre in funzione delle bande che abbiamo montato in RGB.
#il colore della vegetazione cambierà in funzione di questo quindi non siamo piu noi in condizione di fare una leggenda ma in RGB lo stabilirà il softwere.
#importiamo il file 1988

#set multitemporale
p224r63_1988 <- brick("p224r63_2011_masked.grd") #importo il mio file del 1988 con un salto temporale, questa è la stessa immagine del 2011 ma presa nel 1988 con valori di pixel differenti. 
p224r63_1988

#plottiamo l'intera immagine e visualizziamo le singole bande
plot(p224r63_1988) 
#associamo a ogni componente dello schema RGB e varie bande e facciamo la funzione plotRGB e usiamo la funzione strech per vedere un'immagine più bella:

# B1: blu
# B2: verde
# B3: rosso
# B4: infrarosso vicino
# B5: infrarosso medio
# B6: infrarosso termico
# B7: infrarosso medio

#plot di colori naturali:
plotRGB(p224r63_1988, r=3, g=2, b=1, stretch="Lin") #questa è la condizione del 1988
#Adesso plotto l'infrarosso facendo scattare tutti i numeri di uno:
plotRGB(p224r63_1988, r=4, g=3, b=2, stretch="Lin")

#plottiamo le due immagini, sia quella del 1988 che quella del 2011 per notare le differenze con la funzione par, usando sia la funzione lineare che che histogram :
pdf("secondo_pdf_multitemp.pdf")
par(mfrow=c(2,2))
plotRGB(p224r63_1988, r=4, g=3, b=2, stretch="Lin")
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="Lin")
plotRGB(p224r63_1988, r=4, g=3, b=2, stretch="hist")
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="hist")
dev.off()
#si osserva che nel 1988 si ha una soglia graduale di vegetazione ad impatto di cambiamento umano sul territorio, mentre nel 2011 si ha un passaggio netto tra la foresta pluviale e l'impatto umano.
#poi creiamo un pdf da salvare nella cartella lab

#nota: la funzione pdftk prende tutti i pdf nella cartella e li unisce in un unico file di output

#Adesso abbandoniamo il lavoro sulla foresta tropicale e passiamo a lavorare in un altro archivio in Groenlandia. Fine del codice.

#-------------------------------------------------------------------------------------------
#2. R code time series

#Time series analysis
#Variazione delle temperature in Groenlandia nel tempo ----> Time series analysis
# Dati di Emanuela Cosma 
# Primo pacchetto raster

setwd("C:/lab/greenland") # Windows
library(raster)



#utilizziamo la working directory greenland
# install.packages("rasterVis")
install.packages("rasterVis")
library(rasterVis)
#rastervis è un metodo di visualizzazione per i dati raster

#stack: insieme di dati multitemporali, in questo caso raster.

#importiamo i 4 strati separati che rappresentano la stima della temperatura che deriva dal programma Copernicus, consieriamo i primi 10 giorni di giugno nel 2000 2005 2010 2015
#la funzione per caricare singoli dati non si chiama piu brick ma raster. All'interno del pacchetto raster c'è una funzione che si chiama raster:

#mi mancava "rgdal" e la ho installata in windows

lst_2000 <- raster("lst_2000.tif")
plot(lst_2000)

lst_2005 <- raster("lst_2005.tif")
plot(lst_2005)

lst_2010 <- raster("lst_2010.tif")
plot(lst_2010)

lst_2015 <- raster("lst_2015.tif")
plot(lst_2015)

# Adesso non abbiamo piu un sensore che riporta la riflettanza, ma che riporta le temperature: passiamo da una scala decimale ad una scala intera attraverso il bits
#Digitals numbers: numeri interi-----> Shannon
#1 bit è uno spazio di informazione con 2 valori possibili, una mappa con 2 bit di informazione ha 4 colori possibili associati a numeri, 3 bit----> 8 valori associabili a colori.
#gran parte delle immagini sono a 8bit--->256 valori; 2^9 (9 bit)---> 512 valori; 2^10(10 bit)---> 1024, 2^16 (16 bit)---> 65535

#dall'immagine plottata maggiore sarà il digital numbers e maggiore sarà il valore di temperatura.

#plottiamo tutte le 4 immagini
par(mfrow=c(2,2))
plot(lst_2000)
plot(lst_2005)
plot(lst_2010)
plot(lst_2015)

#importare le immagini insieme con la funzione lapply, quindi invece che prendere il singolo file lst e portarlo dentro R tramite la funzione raster, possiamo fare una lista lst e applicare a tutti la funzione raster e portarli dentro R.
#viene fatta una list.files: crea una lista di files che R utilizzera per applicare la funzione lapply.

rlist <- list.files(pattern="lst") #list file crea una lista
rlist #lista di tutti i file che hanno al loro interno la parola lst in comune
#pattern è la scritta che hanno in comu e i file
import <- lapply(rlist,raster) #li importo tramite lapply
import

#dopo aver importato la lista dentro R quindi abbiamo i singoli file e a questo punto possiamo raggruppare tutti i file insieme e gli diamo un nome tramite la funzione stack:
#stack mi passa dai singoli file che io ho importato ad un unico grande file, per fare delle operazioni di plottaggio contemporaneamente
TGr <- stack(import)
plot(TGr)

#quindi abbiamo i vari livelli separati e abbiamo creato le condizioni di un immagine a tante bande

#sovrapposizione di immagini tutte insieme:
plotRGB(TGr, 1, 2, 3, stretch="Lin")

plotRGB(TGr, 2, 3, 4, stretch="Lin") 
plotRGB(TGr, 4, 3, 2, stretch="Lin") 
#plot rgb con dei valori di immagine da satellite sovrapposte che riguardano la temperatura

#DAY
library(rasterVis)

setwd("C:/lab/greenland") # Windows
rlist <- list.files(pattern="lst") #list file crea una lista
rlist
import <- lapply(rlist,raster) #li importo tramite lapply
import
TGr <- stack(import)

#Con la funzione levelplot usiamo il blocco intero e una singola legenda e plottiamo tutto insieme. la useremo con i dati di Copernicus
levelplot(TGr)

levelplot(TGr$lst_2000)
#immagine a 16 bit, vediamo i valori di T medi di ogni colonna, unendo i punti di ogni colonna vedremo che dove abbiamo il ghiaccio avremo dati più bassi.
#in questo caso stiamo utilizzando delle immagini singole quindi possiamo utilizzare la color palette a differenza di immagini RGB
cl <- colorRampPalette(c("blue","light blue","pink","red"))(100) 
#possiamo cambiare i colori e riplottiamo il levelplot e con l'argomento col.regions (argomento per cambiare colore)
levelplot(TGr, col.regions=cl) #abbiamo fatto un plot con nuovi colori e vediamo in modo multitemporale come varia la Temperatura dal 2000 al 2015, la gamma di colori si vede bene.

#adesso cambiamo il level plot nominando in modo diverso gli attributi
levelplot(TGr,col.regions=cl, names.attr=c("July 2000","July 2005", "July 2010", "July 2015")) #abbiamo ridenominato i layer 
# adesso gli diamo un nome e otteniamo il grafico finale
levelplot(TGr,col.regions=cl, main="LST variation in time",
          names.attr=c("July 2000","July 2005", "July 2010", "July 2015"))

#adesso utilizziamo i dati sullo scioglimento

#il ghiaccio non assorbe me microonde quindi in funzione di quanto ghiaccio c'è possiamo fare una stima sulla quantita di ghiaccio persa in groenlandia dal 1978 ad oggi

#melt, scarichiamo i dati,  e facciamo una lista meltlist e applichiamo la funzione lapply alla lista fatta e applichiamo la funzione raster.

meltlist <- list.files(pattern="melt")
#applico alla lista che ho appena nominato (meltlist) la mia funzione raster:
melt_import <- lapply(meltlist,raster)
#infine facciamo lo stack raggruppando tutti i file che ho appena importato e li metto insieme con la funzione stack:
melt <- stack(melt_import)
melt
#abbiamo fatto un rasterstack
#adesso faccio il levelplot con i dati melte ottengo i valori di scioglimento dei ghiacci, piu alti sono i valori maggiore è lo scioglimento.
#fra il primo anno e l'ultimo si vede una bella differenza 
#adesso facciamo algebra applicata a delle matrici, possiamo fare una sottrazione tra le due immagini e notare le differenze.

#sottrazione tra primo dato e secondo, gli assegnamo un nome:
#questi due file sono dentro il file piu grande melt quindi dobbiamo legarli tramite $
melt_amount <- melt$X2007annual_melt - melt$X1979annual_melt
#faccio la color e palette dove avro valori piu bassi in blu e in rosso i piu alti
clb <- colorRampPalette(c("blue","white","red"))(100)
#plottiamo e vediamo le differenze tra i due anni
plot(melt_amount, col=clb)

levelplot(melt_amount, col.regions=clb)
#vediamo un'impressione generale e vediamo un picco di melt. Abbiamo visto come utilizzare e visualizzare i dati di differenza tra le due immagini.


#DAY 14/04
#copernicus e dataset anche per l'esame: dati vegetazione,energia, ciclo dell'acqua (temperatura, water level ecc), Criosphere(estensione ghiaccio ecc)
#metadato: descrizione dato che andiamo ad utilizzare
#USGS sito dove scaricare tutti i dati
#installo il pacchetto knitr

install.packages("knitr")

#-------------------------------------------------------------------------------------------
#3. R code Copernicus











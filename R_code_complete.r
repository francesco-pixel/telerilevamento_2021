#R code completo

#SOMMARIO
#----------------------------------------

#1. Remote sensing first code 
#2. R code time series
#3. R code Copernicus
#4. R code Knitr
#5. R code multivariate analysis
#6. R code classification
#7. R code ggplot2


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


DAY 14/10

#R_Code_Copernicus
#Visualizzazione dei dati copernicus
library(raster)

install.packages("ncdf4")
library("ncdf4")
#libreria per leggere netCDF

setwd("C:/lab/") 

#Diamo un nome al nostro dataset, lo carichiamo  usando la funzione raster per caricare  un singolo strato, mettiamo tra virgolette il nome del file copiato e incollato includendo l'estensione .nc
albedo <- raster("c_gls_ALBH_202006130000_GLOBE_PROBAV_V1.5.1.nc")
albedo #vediamo tutte le info del dataset

#adesso possiamo plottare la prima immagine, non montiamo in RGB ma decidiamo noi la scala di colori da utilizzare.
cl <- colorRampPalette(c('black','grey','yellow','red'))(100)


plot(albedo,col=cl)
#dunque vediamo la quantità e la superficie doce viene riflessa più energia solare (la parte del deserto riflette maggiormente)

#ggplot2 ci permette di abbellire i grafici

#ora applichiamo la funzione aggregate per aggregare i pixel
albedores <- aggregate(albedo, fact=50)
#prendo pixel piu grandi, trasformando l'immagine con un minor numero di pixel per un determinato fattore
albedores

plot(albedores)
#noto come la variabile sia più veloce da visualizzare

#Data la variabile molto pesante, adesso la ricampioniamo  per un fattore 100 diminuendo la dimensione di 10000 volte il dato originale (100x100) e rifaccio il plot di albedores:
#ricampionamento bilineare:

albedores <- aggregate(albedo, fact=100)
plot(albedores, col=cl)




#day 16/04
generiamo il codice che utilizzeremo dentro knitr 

#-------------------------------------------------------------------------------------------
#4. R code Knitr

#day 16/04

setwd("C:/lab/") 


generiamo il codice che utilizzeremo dentro knitr 
# all'interno di R abbiamo il pacchetto knitr. e questo pacchetto dentro il nostro softwere puo utilizzare un codice esterno, quindi knotr va a prendere il codice all'esterno,lo importa dentro R e all'interno di R genera un report che verra salvato nella stessa cartella dove è presente il codice precedente.
#installiamo knitr
install.packages("knitr")
library("knitr")

#dopo aver salvato il codice nella cartella lab, da R usiamo il pacchetto knitr che pesca il codice nella cartella lab che va a caricare dentro R generando il report

#la funzione che useremo sarà:
stitch("R_Code_Greenland.r.txt", template=system.file("misc", "knitr-template.Rnw", package="knitr"))
#vedremo la generazione del report
#oltre aver generato il report, vengono generate le figure che mette dentro la cartella figure in lab


#un compilatore è un softwere come R che usa il codice per generare del testo
#registrazione a overlife, strumento potente per usare codice latex all'interno.

#primp progetto da tex
#ricompila: serve a passare dal file tex al pdf
#adesso copiamo e incolliamo tutto cio che è salvato nel file tex e lo copiamo dentro
#includegraphics: funzione che prende le figure e le inserisce all'interno, prendendole dentro la cartella  figure


#day 21/04

#Classificazione delle immagini: processo che accorpa pixel on valori simili rappresentando una classe (bosco, vegetazione,prateria, specie simili)
#studieremo il grand canyon , diverse rocce.
#Solar obiter: monitora il sole (sensori basati su raggi ultravioletti)





#-------------------------------------------------------------------------------------------
#5. R code multivariate analysis

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

#data cube è un immagine iperspettrale dove abbiamo centinaia di bande a disposizione che sono possibili compattare attraverso la PCA.

funzione str----> ci da molte informazioni sul file 
#l'analisi multivariata si usa per diminuire un set di variabili che abbiamo a disposizione.
# vi sono situazioni in cui non possiamo usare variabili correlate  tra loro quindi prendiamo le variabili originali facciamo una PCA e usiamo solo alcune componenti della PCA.








#-------------------------------------------------------------------------------

#6. R code classification
#day 21/04

#Classificazione delle immagini: processo che accorpa pixel on valori simili rappresentando una classe (bosco, vegetazione,prateria, specie simili)
#studieremo il grand canyon , diverse rocce.
#Solar obiter: monitora il sole (sensori basati su raggi ultravioletti)

 setwd("C:/lab/") # Windows
# scarichiamo l'immagine solar obiter che rappresenta dei diversi livelli di energia tramite raggi UV, carichiamo l'immagine

library(raster)
 
so <- brick("Solar_Orbiter_s_first_views_of_the_Sun_pillars.jpg")
# immagine con 3 livelli e la importiamo in R tramite Brick e la visualizziamo:
 
plotRGB(so, 1, 2, 3, stretch="lin")

#nell'immagine vediamo un livello leggero a destra, uno intermedio e uno piu alto delle esplosioni
so #informazioni immagine

#nella banda del rosso e blu i valori assorbono quindi saranno bassi mentre nel verde sarà alto

#dove si impostano i pixel nello spazio multispettrale? dipende dalla riflettanza cosi creerà delle classi associate (bosco, urbano, ecc) per classificare tutta l'immagine.
#il softwere andra a classificare tutti gli altri pixel in funzione della nuvola di punti iniziale (Teoria della somiglianza massima)


library(RStoolbox)
install.packages("RStoolbox")

#Classificazione non supervisionata, si lascia al softwere la possibilita di definire i pixel e classificarli nell'immagine.

#Unsupervised Classification , dentro rstoolbox opera la classificazione non supervisionata


#funzione unsuperclass classification, l'iimagine è so, poi il numero di classi, la associamo poi ad un oggetto:
soc <- unsuperClass(so, nClasses=3)
#quindi ho creato il modello in uscita e ora plotto la mappa, plotto la mappa soc e la lego 


plot(soc$map)
#vi è un po di diversità
#per annullare la diversità si utilizza la funzione se.seed

#aumentiamo il numero delle classi a 20
# Unsupervised Classification with 20 classes

soc20 <- unsuperClass(so, nClasses=20)
plot(soc20$map)
#qui discriminiamo ogni singola parte dell'immagine (concetto di come classificare un'immagine, qualsiasi immagine)
cl <- colorRampPalette(c('yellow','red','black'))(100)


#scarichiamo un immagine qualsiasi dal solar obiter 
# https://www.esa.int/ESA_Multimedia/Missions/Solar_Orbiter/(result_type)/images
sun <- brick("sun.png")
sunc <- unsuperClass(sun, nClasses=3)
plot(sunc$map)
#plottando l'immagine si osserva bene il livello piu energetico esterno in giallo.

#possiamo plottare e classificare qualsiasi immagine (affioramenti ecc), maggiore è il dettaglio dell'immagine e maggiori problemi riscontreremo. (esempio roccia che da il colore bianco)
#non sempre utilizziamo il sole come fonte di energia per le immagini satellitari, ma la fonte puo essere esterna al sensore. a volte puo essere interna come il laser.
#con il segnale radar ad esempio le nuvole non vengono viste e quindi oltrepassate. (frane ecc)
#sole immagine ottica e sensori passivi. laser hanno sensori attivi.


#visualizziamo le immagini del grand canyon, faremo una classificazione mineralogica.


#DAY 23/04

#La mineralogia determina la riflettanza di una determinata zona della terra, utilizziamo questi valori di riflettanza per creare l'immagine  classificata

#visualizziamo le immagini del grand canyon, faremo una classificazione mineralogica.
#grand canyon e immagine 

#dolansprings_oli_2013088_canyon_lrg (immagine)
 
setwd("C:/lab/") # Windows


library(raster)
library(RStoolbox)

#carichiamo la nostra immagine in RGB con la funzione brick. con all'interno il file appena scaricato assegnandogli un nome "gc"

gc <- brick("dolansprings_oli_2013088_canyon_lrg.jpg")
#visualizziamo con plotRGB, quindi abbiamo un oggetto raster con piu dati e lo plottiamo (3 strati/bande)
#usiamo lo stretch per aumentare la visibilità dei colori

plotRGB(gc, r=1, g=2, b=3, stretch="lin")


#cambiamo il tipo di stretching  da lineare  a istogram stretching e visualizziamo tutti i colori possibili fino a 255 utilizzando tutte le bande possibili dei colori.
#utilizzando il giallo nelle immagini, il nostro occhio accentuerà questo colore.
plotRGB(gc, r=1, g=2, b=3, stretch="hist")

#iniziamo il processo di classificazione dell'immagine


#manuale del pacchetto:
#https://cran.r-project.org/web/packages/RStoolbox/RStoolbox.pdf

#applichiamo la funzione per la classificazione come gia fatto in passato:
gcc2 <- unsuperClass(gc, nClasses=2)
#quindi usiamo la funzione unsuperClass che fa parte del pacchetto RStoolbox, nome immgine gcc e numero delle classi pari a 2 poi la plottiamo
#gcc2 è data da tutto il modello quindi informazioni sulle singole classi, mappa ecc. siccome dobbiamo plottare la mapppa in uscita dobbiamo legare la mappa al nostro modello attraverso il dollaro.
plot(gcc2$map)
#visualizziamo il risultato
gcc2 #abbiamo la classe 1 e 2 e questa immagine ha 58 Mln di pxel
#abbiamo discriminato una zona centrale piu scura associata al bianco nell immagine. mentre i valori piu scuri sono stati associati alla classe 1 in funzione della riflettanza.


#utilizziamo 4 classi  
gcc4 <- unsuperClass(gc, nClasses=4)
plot(gcc4$map)

#dopo aver fatto la classificazione vediamo sul campo quanto l'immagine possa essere utilizzata. se usassimo anche la banda dell'infrarosso vedremo l'H2O in una sola classe a parte.

#quindi capire sul campo perche son venuti fuori diversi valori di riflettanza e le cause 
#articolo mineralogical mapping




#-------------------------------------------------------------------------------
#7. R code ggplot2




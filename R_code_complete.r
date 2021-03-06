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
#8. R Code Vegetation_indices.r
#9. R code land cover
#10. R code variability temp.
#11. R code spectral signatures.r

#------------------------------------------------------------------
#1. Remote sensing first code 


# il mio primo codice in R per il telerilevamento!
# seleziono la cartella di riferimento lab

setwd("C:/lab/") #windows

# install.packages("raster")
library(raster)
#importo i dati con la funzione brick

p224r63_2011 <- brick("p224r63_2011_masked.grd")
# Attraverso la funzione brick ho importato l'intera immagine! (immagine p224 ovvero stiamo seguendo il percorso sinusoide p224, incrociandolo con la riga 63, così troveremo l'immagine landsat di interesse---> parakana)

p224r63_2011 
# successivamento digitando il nome dell'immagine ho visualizzato tutte le sue informazioni (tipo di file, risoluzione, informazioni sui sistemi di riferimento etc)

plot(p224r63_2011)
# ho fatto il primo plot con sette bande con dei dati satellitari!!

#stabiliamo adesso un differente range di colori da nero a grigio chiaro, inserendo una C davanti alla parentesi ad indicare una serie di elementi (colori). il 100 indica il  numero di livelli
cl <- colorRampPalette(c('black','grey','light grey'))(100)

# plotto il colore con il primo argomento che è l'immagine mentre il secondo argomento sara il colore che daremo ad ogni singola banda
plot(p224r63_2011, col=cl)

#vediamo che nell'infrarosso c'è molta riflettanza. 

#adesso provo ad osservare la riflettanza con dei diversi colori:
cl <- colorRampPalette(c('yellow','grey','pink','white','green','red','orange','blue'))(100)

plot(p224r63_2011, col=cl)

# le analisi multitemporali sia geologiche che non...sono molto interessanti! cosa succede in varie aree del mondo nel tempo?----> https://earthobservatory.nasa.gov/
# è importante conoscere il sistema di riferimento, e cioè da dove partiamo per poter calcolare le coordinate ricercate. Latitudine e longitudine non sono coordinate assolute ma dipendono dal sistema di riferimento.
# sistema di riferimento WGS84 WORLD GEODETIC STSTEM 1984, ellissoide di riferimento per le coordinate.


# adesso passeremo dalla terra in 3D alla terra in 2D portando la terra dall'ellissoide al piano attraverso la suddivisione in fusi----mercator project UTM, INOLTRE POSSIAMO PASSARE DA UN SISTEMA DI RIFERIMENTO ALL'ALTRO PARTENDO DA UN SISTEMA DI RIFERIMENTO GIA DEFINITO.
# ADESSO VEDREMO COME LAVORARE SULLE SINGOLE BANDE DI IMMAGINI DA SATELLITE E COME PLOTTARE PIU BANDE INSIEME. 



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

library(raster)
library(RStoolbox)
library(ggplot2)
library(gridExtra)

setwd("~/lab/")

p224r63 <- brick("p224r63_2011_masked.grd")

ggRGB(p224r63,3,2,1, stretch="lin")
ggRGB(p224r63,4,3,2, stretch="lin")

p1 <- ggRGB(p224r63,3,2,1, stretch="lin")
p2 <- ggRGB(p224r63,4,3,2, stretch="lin")

grid.arrange(p1, p2, nrow = 2) # this needs gridExtra
#-------------------------------------------------------------------------------


#8. R Code Vegetation indices.r


library(raster)
setwd("C:/lab/")
#carichiamo le due immagini

defor1 <- brick("defor1.jpg")
defor2 <- brick("defor2.jpg")


#facciamo il plot RGB

# b1 = NIR, b2 = red, b3 = green

par(mfrow=c(2,1))
plotRGB(defor1, r=1, g=2, b=3, stretch="lin")
plotRGB(defor2, r=1, g=2, b=3, stretch="lin")


#plot e vediamo le loro multitemporalità, in queste due immagini vi è la stessa zona perchè, il corso del fiume è lo stesso quindi è la stessa zona. tutta la parte rossa è vegetazione quella chiara è suolo agricolo.


#adesso calcoleremo l'indice di vegetazione e lo applicheremo alle due immagini per fare un analisi temporale.


#DAY 30/04

#una pianta ha la possibilita di riflettere alcune lunghezze d'onda e assorbirle in altre (ad esempio il rosso)
#posso misurare qunto è sana la vegetazione
#l'indice Dvi è la differenza di riflettanza tra l'infrarosso vicino(riflette molto) e il rosso (bassa riflettanza)
#il range possibile è tra -255 a 255 nel caso di un immagine a 8bit
#possiamo normalizzare i due indici 
#calcoliamo il Dvi prima e dopo
#vediamo quali sono i nomi delle bande 
defor1
dvi1 <- defor1$defor1.1 - defor1$defor1.2
#per ogni pixel stiamo prendendo la banda dell'infrarosso e sottraiamo allo stesso pixel quella del rosso ottenendo cosi la differenza. Otteniamo inoltre la prima mappa e la plottiamo
plot(dvi1)

#la parte del fiume  è chiara, quella della vegetazione molto verde.
#cambiamo la color Ramp palette

dev.off()

cl <- colorRampPalette(c('darkblue','yellow','red','black'))(100) # specifying a color scheme

plot(dvi1, col=cl)
#dvi1 calcolato, adesso calcoliamo il dvi2 della seconda immagine rifacendo la stessa procedura e plottando.
#vediamo come si chiamano le bande dentro defor2
defor2
dvi2 <- defor2$defor2.1 - defor2$defor2.2
plot(dvi2)
de.off()

cl <- colorRampPalette(c('darkblue','yellow','red','black'))(100) # specifying a color scheme

plot(dvi2, col=cl)

#parte gialla in cui non vi è vegetazione o sta soffrendo .
#faremo un analisi su quanta percentuale di foresta abbiamo perso 

#plottiamo i 2 dvi insieme con par
par(mfrow=c(2,1))
plot(dvi1, col=cl, main="DVI at time 1")
plot(dvi2, col=cl, main="DVI at time 2")
#dunque vediamo come la situazione è cambiata nel tempo attraverso i 2 indici
#facciamo la differenza tra le due mappe per ogni pixel, 

difdvi <- dvi1 - dvi2 #i due raster hanno due estensioni diverse per differenza di area. calcola l'area intersecata tra le due e plottiamo.
cld <- colorRampPalette(c('blue','white','red'))(100) 
plot(difdvi, col=cld)
#vediamo dove ho valori di differenza piu marcata ho le zone rosse, vediamo dove c'è stata maggiore sofferenza di vegetazione.

#se cambiamo il numero di Bit a 16 , la risoluzione è diversa quindi non vi si possono paragonare quella a 8 e quella a 16 
#utilizzeremo un'altra normalizzazione e standardizzazione con ndvi al posto di dvi possiamo paragonare qualsiasi tipo di immagini che hanno risoluzione differente in entrata
#Calcoliamo quindi ndvi
# ndvi
# (NIR-RED) / (NIR+RED)

#inseriamo all'interno delle parentesi le variabili
ndvi1 <- (defor1$defor1.1 - defor1$defor1.2) / (defor1$defor1.1 + defor1$defor1.2)

plot(ndvi1, col=cl)

#vediamo il range da max a min da -1 a 1

#possiamo anche scriverlo cosi tramite un file gia fatto in precedenza:
# ndvi1 <- dvi1 / (defor1$defor1.1 + defor1$defor1.2)
# plot(ndvi1, col=cl)


#spectral indices calcola diversi indici, giocarci e calcolarli.
defor2
#calcolo ndvi per la seconda immagine
ndvi2 <- (defor2$defor2.1 - defor2$defor2.2) / (defor2$defor2.1 + defor2$defor2.2)

plot(ndvi2, col=cl)

#funzione spectral indices
#RStoolbox::spectralIndices

library(RStoolbox) #richiamiamo il pacchetto ed utilizziamo la funziona assegnando un nome vi1
vi1 <- spectralIndices(defor1, green = 3, red = 2, nir = 1)

#spectral indices della nostra immagine e richiamiamo le tre bande poi plottiamo e vediamo che calcola tutti gli indici e li mette tutti insieme. Vasta gamma di indici
plot(vi1, col=cl)
#cosi possiamo lavorare su qualsiasi componente all'intenro di un ecosistema con  olti indici da poter calcolare.
#facciamo la stessa cosa per la seconda immagine
#non riesce a calcolare tutti gli indici perche alcuni di essi hanno bisogno di bande a colori differenti

vi2 <- spectralIndices(defor2, green = 3, red = 2, nir = 1)
plot(vi2, col=cl)


#differenza tra i due ndvi
difndvi <- ndvi1 - ndvi2
cl <- colorRampPalette(c('blue','white','red'))(100)

plot(difndvi, col=cld)

#in rosso le aree con maggior perdita di vegetzione

DAY 5/05

#WORLDwIDE NDVI  

install.packages("rasterdiv")
library(rasterdiv)
plot(copNDVI) #differenza tra infrarosso e rosso diviso la loro somma, piu biomassa vi è nel pianeta maggiore sarà l'indice.

#PARTE CHE INDIVIDUA L'ACQUA CHE VOGLIAMO TOGLIERE TRAMITE:


## Pixels with values 253, 254 and 255 (water) will be set as NA’s.

#i pixel possono essere trasformati in non valori tramite reclassify che viene da raster. effettuiamo questa trasformazione per i valori 253,255 in NA
copNDVI <- reclassify(copNDVI, cbind(253:255, NA))
plot(copNDVI)
#abbiamo eliminato l'acqua e vediamo la mappa NVDI a scala globale


# rasterVis package needed:

library(rasterVis)
levelplot(copNDVI) #dentro il pacchetto rastervis 
#valori dal 1999 al 2017, valori bassi in aree desertiche, mentre alti valori in zone in cui vi è neve. (notiamo il respiro della terra).
#in corrispondenza dell'equatore abbiamo massimi valori perche vi è la massima luce e le piante avranno molto bisogno di luce. a 23 gradi nord ci sono i deserti per via dei moti di convezione delle masse d'aria 
#all'interno delle foreste tropicali l'evapotraspirazione è elevatissima.
#biomes estensione della biomassa nel pianeta


#-------------------------------------------------------------------------------


#9. R code land cover



5/05
#R_code_land_cover.r
#Utilizziamo gli algoritmi della classificazione delle immagini e facciamo lanalisi multitemporale della variazione della copertura del suolo

# R code analisi multitemporale di variazione della land cover
setwd("C:/lab/")


library(raster)
install.packages("RStoolbox") 
library(RStoolbox)#per la classificazione

install.packages("ggplot2")
library(ggplot2) 

#carichiamo la prima immagine
defor1 <- brick("defor1.jpg") 

plotRGB(defor1, r=1, g=2, b=3, stretch="Lin")
#all'interno di ggplot ci sono funzioni potenti per plottare immagini----> funzioni con gg
#funzione ggRGB, essa ha bisogno dell' immagine , delle componenti RGB e stretch.
ggRGB(defor1, r=1, g=2, b=3, stretch="Lin") #otteniamo un plot con le coordinate spaziali (plot migliore)
#carico adesso la seconda immagine ed effettuo le stesse operazioni.

defor2 <- brick("defor2.jpg")
plotRGB(defor2, r=1, g=2, b=3, stretch="Lin")
ggRGB(defor2, r=1, g=2, b=3, stretch="Lin")

#mettiamo le immagine plotRGB accanto con parmfrow
par(mfrow=c(1,2))
plotRGB(defor1, r=1, g=2, b=3, stretch="Lin")
plotRGB(defor2, r=1, g=2, b=3, stretch="Lin")


#per mettere le immagini accanto o incolonnate non usiamo parmfrow come per plotRGB ma con ggplot si fa  con la funzione grid
#per farlo installiamo gridExtra


#multiframewith ggplot2 andgridExtra
install.packages("gridExtra")
library(gridExtra)

#usiamo adesso la funzione grid.arrange che mette insieme vari pezzi dentro il grafico
p1 <- ggRGB(defor1, r=1, g=2, b=3, stretch="Lin")
p2 <- ggRGB(defor2, r=1, g=2, b=3, stretch="Lin")
grid.arrange(p1, p2, nrow=2)
#immagini disposte su due righe

#utilizzzeremo ggplot per vedere la diminuzione nella foresta amazzonica e la plotteremo visualizzando il cambiamento


DAY 7/05
#differenza tra vegetazione e uso del suolo (copertura). la vegetazione è piu particolareggiata con le singole specie dominanti. 
#per la vegetaazione abbiamo bisogno di sensori iperspettrali e quindi molte bande per distinguere le specie.

#facciamo l'unsupervised(non viene supervisionata da noi inizialmente) classification 
# classificazione non supervisionata
d1c <- unsuperClass(defor1, nClasses=2) #immmagine e numero di classi
d1c #due valori
#abbiamo d1c che è il modello e la mappa che abbiamo creato e lo plotiamo
plot(d1c$map)
#classe 1 agricola
#classe due non agricola
#creiamo la seconda mappa 

d2c <- unsuperClass(defor2, nClasses=2) #immmagine e numero di classi
d2c #due valori
plot(d2c$map)

#facciamo una classificazione a 3 classi per riuscire ad identificare il fiume
d2c3 <- unsuperClass(defor2, nClasses=3) #immmagine e numero di classi
d2c3 #due valori
plot(d2c3$map)
#la parte agricola è stata distinta in due parti
#quanta foresta è stata persa? effettuiamo dei calcoli. calcoliamo la frequenza dei pixel delle classi con la funzione 
#frequenza delle due classi:
freq(d1c$map) #la classe n1 vs n2

#valori riguardo le aree aperte =    307841 pixel
#valori riguardo la foresta =  33451 pixel

#facciamo la proporzione tra questi due valori

s1 <-  307841 + 33451
s1

prop1 <- freq(d1c$map) / s1
prop1
#[1,] 2.930042e-06 0.90198715 #foresta
[2,] 5.860085e-06 0.09801285 #agricolo

#proporzioni nella seconda immagine
s2 <- 342726
prop2 <- freq(d2c$map) / s2
prop2
[1,] 2.917783e-06 0.5224261 #foresta
[2,] 5.835565e-06 0.4775739 #agricolo

#costruiamo un dataframe con righe e colonne
cover <- c("Agriculture","Forest")
percent_1992 <- c(9.8,90.2)
percent_2006 <- c(47.7,52.2)

#funzione per creare un dataframe
percentages <- data.frame(cover,percent_1992,percent_2006)
percentages
#facciamo un grafico con ggplot

library(ggplot2)
#p1<-ggplot(output, aes(x=cover, y=before, color=cover)) + geom_bar(stat="identity", fill="white")  
ggplot(percentages, aes(x=cover, y=percent_1992, color=cover)) + geom_bar(stat="identity", fill="white")
#geometria a barre #dati originati identity #color: quali oggetti discriminare #fill: di che colore voglio le barre all'interno
#vediamo nel grafico la parte agricola  molto bassa e foresta molto alta. la legenda = cover
#facciamo la stessa operazione per il plot del 2006
ggplot(percentages, aes(x=cover, y=percent_2006, color=cover)) + geom_bar(stat="identity", fill="white")

#le due barre adesso sono simili
#grid.arrange mette insieme i plot grafici in una pagina, associamo i plot ad un  nome (p1,p2) e poi li plottiamo insieme con grid.arrange
p1 <- ggplot(percentages, aes(x=cover, y=percent_1992, color=cover)) + geom_bar(stat="identity", fill="white")
p2 <- ggplot(percentages, aes(x=cover, y=percent_2006, color=cover)) + geom_bar(stat="identity", fill="white")
grid.arrange(p1, p2, nrow=1)

#vediamo il plot con i valori, vediamo le differenze tra il 1992 e il 2006 nello stesso grafico. siamo passati da un immagine satellitare ad un grafico che ci mostra i cambiamenti multitemporali.


#-------------------------------------------------------------------------------

#10. R code variability temp.



#DAY 19/05
#R_Code_Variability.r
library(raster)
library(RStoolbox)
library(ggplot2) # for ggplot plotting
library(gridExtra) # for plotting ggplots together
# install.packages("viridis")
install.packages("viridis") # for ggplot colouringll.packages("RStoolbox")

setwd("C:/lab/") # Windows
#l'immagine sentinel è composta da tre strati near infrared il red al secondo e green al terzo livello
#il raster si utilizza solo per catturare il primo strato quindi usiamo brick cosi portiamo dentro l'intero blocco


#abbiamo tre bande, nero infrared che mettiamo sulla compnente red 1,il rosso sulla compnente green  2 e banda green sulla componente blu 3 e la inseriamo nello schema rgb:
sent <- brick("sentinel.png")

# NIR 1, RED 2, GREEN 3
# r=1, g=2, b=3
plotRGB(sent, stretch="lin") 
plotRGB(sent, r=2, g=1, b=3, stretch="lin") 
#parte rosa calcare, vediamo la parte vegetale in verde florescente, in nero l'acqua e i laghi e ombre.
#calcoliamo la dev standard e possiamo utilizzare una sola banda su cui passera la movie window (finestra mobile) per fare il calcolo, poi facciamo la media dei pixel.
#costruiamo la distribuzione a campana di tutte le frequenze, la variabilita è data dal 68 percento dei dati ottenendo la dev standard. maggiore è la variabilita maggiore sara la dev standard.
#la finestra mobile si spostera e calcoleremo la dev standard dei pixel inclusi, ottengo cosi una nuova mappa con dei valori nuovi calcolati per la dev standard. 
#in questo caso la finestra mobile passa su una sola banda quindi bisogna compattare tutti i dato in un solo strato
#un metodo potrebbe essere l'indice di vegetazione ndvi che ci porta ad un singolo layer e otteniamo un valore per ogni pixel.
nir <- sent$sentinel.1
red <- sent$sentinel.2
#associamo le due bande a due oggetti e ora calcoliamo ndvi e gli associamo un nome e lo plottiamo
ndvi <- (nir-red) / (nir+red)

plot(ndvi)
#ndvi va da -1 a 1 , dove vediamo bianco non c'è vegetazione e quindi acqua, il marroncino è roccia e non c'è vegetazione, in giallo e verde è il bosco, le parti sommitali in verde sculo è la vegetazione.
#possiamo cambiare la colorRampalette e la plotto, abbiamo calcolato la vegetazione del singolo strato.
cl <- colorRampPalette(c('black','white','red','magenta','green'))(100) # 

plot(ndvi,col=cl)
#ora calcoliamo la variabilità di questa immagine 

#calcoliamo la dev. standard di questa immagine cin la funzione focal, calcolando la statistica (media , dev standard ecc)
#procediamo con la dev standard
#focal del dato ndvi, la w=window è uguale alla matrice (abbiamo 9 pixel in questo caso) isotropo. facciamo una dev standard con una finestra mobile di 3 pixel e gli associamo il nome.
ndvisd3 <- focal(ndvi, w=matrix(1/9, nrow=3, ncol=3), fun=sd)
plot(ndvisd3)
#cambiamo la colorampalette, abbiamo calcolato la variabilità con la dev standard dell'immagine e cambiato i colori
clsd <- colorRampPalette(c('blue','green','pink','magenta','orange','brown','red','yellow'))(100) # 
plot(ndvisd3, col=clsd)
#in rosso giallo abbiamo una variabilità piu alta, la dev standard è in alcune parti omogenea nelle parti vegetate (giallo e rosso) mentre in altre zone sarà piu alta e in altre piu bassa. dev standard sull'nvdi.
# facciamo una media della dev standard 
# mean ndvi with focal,
ndvimean3 <- focal(ndvi, w=matrix(1/9, nrow=3, ncol=3), fun=mean)
#cambiamo la color e la plottiamo
clsd <- colorRampPalette(c('blue','green','pink','magenta','orange','brown','red','yellow'))(100) # 
plot(ndvimean3, col=clsd) #vediamo l' media dell'ndvi, valori alti nei boschi ecc e valori piu bassi per la roccia
#aumentiamo la grandezza e quindi la finestra a nostro piacere quindi non piu 3x3 ma la faccio con un 13x13 e la plotto
ndvisd13 <- focal(ndvi, w=matrix(1/169, nrow=13, ncol=13), fun=sd)
clsd <- colorRampPalette(c('blue','green','pink','magenta','orange','brown','red','yellow'))(100) # 
plot(ndvisd13, col=clsd)
#la finestra adesso  è molto piu ampia, facciamo un calcolo con una finestra 5x5
ndvisd5 <- focal(ndvi, w=matrix(1/25, nrow=5, ncol=5), fun=sd)
clsd <- colorRampPalette(c('blue','green','pink','magenta','orange','brown','red','yellow'))(100) # 
plot(ndvisd5, col=clsd)
#finora abbiamo lavorato sull ndvi per la compattazione ma vi è un'altra tecnica.
#Avremo la pc1 che è la prima componente principale della PCA.  e non nvdi in questo caso, la pc1 è sempre un singolo strato e ci passeremo la movie window come prima fino a creare una mappa di dev standard. 
#utilizziamo la funzione rasterPCA, e facciamo l'analisi delle componenti principali per i raster che si trova nel pacche RStoolbox e lo chiamiamo sentpca e la associamo alla funzione.
sentpca <- rasterPCA(sent) 
plot(sentpca$map)  
#osserviamo le 4 componenti che ha, via via che si passa da una pca all'altra si perdono informazioni. i layer sono 4 pc1-2-3-4.
#vediamo quanta variabilita spiegano le singole componenti #summary:
#la prima componente principale spiega il 67,36 % della proporzione principale e lo abbiamo visto attraverso summary
summary(sentpca$model)
 #la prima PC spiega il 67,36804 % dell'informazione totale e originale 
#la nostra immagine sentpca la leghiamo a map con il dollero ed essa cconterra 4 variabili, noi prenderemoo la PC questo lo associamo ad un ogetto cche si chiama PC1 e aplichiama la funzione focal a PC1



DAY 21/05
#e useremo questo oggetto PC1 per applicare focal
pc1 <- sentpca$map$PC1
#facciamo la dev standard tramite focal sulla PC1 usando direttamente una griglia 5x5 e cambiamo la colorampalette, poi plottiamo
pc1sd5 <- focal(pc1, w=matrix(1/25, nrow=5, ncol=5), fun=sd)
clsd <- colorRampPalette(c('blue','green','pink','magenta','orange','brown','red','yellow'))(100) # 
plot(pc1sd5, col=clsd)
#la confrontiamo con l'immagine sent del similaun originale del ghiacciaio
#usando la pc1 vediamo la parte di vegetazione è quella piu omogenea mentre un aumento di variabilità nelle zone di roccia (metodo ideale per vedere la variabilità
#la funzione source ci permette di richiamare un pezzo di codice che abbiamo gia creato in precedenza. lo facciamo con una mappa della standard dev di 7x7 e lo salvo nella cartella lab per poi andarla a richiamare tramite source dalla cartella lab.
# pc1 <- sentpca$map$PC1
# pc1sd7 <- focal(pc1, w=matrix(1/49, nrow=7, ncol=7), fun=sd)
# plot(pc1sd7)
#adesso la richiamo tramite source e lo plotto 
source("source_test_lezione.r")
#questa è la dev standard di una finestra 7x7 pixel
#altro esempio per rrochiamare uno script
source("source_ggplot.r.txt")
#ggplot permette di fare dei plottaggi piu belli
#creiamo una nuova finestra vuota e aggiungiamo dei blocchi, ad esempio una geometria geom_point crea dei punti ad esempio.
ggplot()

#useremo la funzione geom_raster della mappa creata della pca

p1 <- ggplot() + geom_raster(pc1_devst, mapping = aes(x = x, y = y, fill = layer)) + scale_fill_viridis() + ggtitle("Standard deviation of PC1by viridis colour scale")
#ho definito quale raster usare e le componenti mapping
#definito le estetiche e cioe cosa plottimo x e y e tutti i valori interni e cioe il layer. la funzione per estetics dentro geom_raster è mapping e cioe cosa vogliamo mappare.
#abbiamo plottato con ggplot e vediamo il valore della dev.standard, vediamo tutte le discontinuità ed il dato è molto omogeneo, si osservano bene le varibilità ecologiche e geomorfologiche von ggplot.
#metodo migliore per individuare tutte le variabilità, anche geologiche.
#ed ho aggiunto l'utilizzo delle legende viridis di default ed aggiunto il titolo

#provo ad usare un'altra legeda "magma" e facciamo un altro ggplot
p2 <- ggplot() + geom_raster(pc1_devst, mapping = aes(x = x, y = y, fill = layer)) + scale_fill_viridis(option = "magma") + ggtitle("Standard deviation of PC1by magma colour scale")

#vediamo molto bene le parti con dev.standard elevata
#usiamo legenda "inferno"
p3 <- ggplot() + geom_raster(pc1_devst, mapping = aes(x = x, y = y, fill = layer)) + scale_fill_viridis(option = "inferno") + ggtitle("Standard deviation of PC1by inferno colour scale")
#legenda turbo
p4 <- ggplot() + geom_raster(pc1_devst, mapping = aes(x = x, y = y, fill = layer)) + scale_fill_viridis(option = "turbo") + ggtitle("Standard deviation of PC1by turbo colour scale")

#proviamo a mettere le tre mappe create con le diverse legende insieme, abbiamo le tre mappe viridis, magma e turbo, che associamo a p1,p2, p3 e p4 le mettiamo insieme tramite grid.arrange dalla libreria grid extra
grid.arrange(p1, p2, p3, p4, nrow = 1) 
#viridis e magma sono le piu utili, l'occhio umano èpiu colpito dal colore giallo

#-------------------------------------------------------------------------------


#11. R_code_spectral_signatures.r

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


#########analisi multitemporale 

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

#####################

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
 


#------------------------------------------------------------------------------- FINE DEL CODICE COMPLETO.

































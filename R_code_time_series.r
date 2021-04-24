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



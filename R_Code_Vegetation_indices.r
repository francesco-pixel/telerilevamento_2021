#R_Code_Vegetation_indices.r


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


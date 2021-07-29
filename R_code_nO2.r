#R_code_nO2.r

library(raster)
library(RStoolbox) #per analisi multitemporale di raster

#Set the work directory EN


setwd("C:/lab/EN") #windows

#importo la prima immagine e quindi la prima banda 

EN01 <- raster("EN_0001.png") #gennaio

#plotto la prima immagine con la mia color ramp palette preferita
cls <- colorRampPalette(c('blue','green','pink','magenta','orange','brown','red','yellow'))(200) # 
plot(EN01, col=cls)

#importo la tredicesima immagine e la plotto con l'ultima color ramp palette precedente
EN13 <- raster("EN_0013.png") #marzo
cls <- colorRampPalette(c('blue','green','pink','magenta','orange','brown','red','yellow'))(200)  
plot(EN13, col=cls)

#faccio la differebza fra le due immagini, lo associo ad un oggetto e poi la plotto, marzo meno gennaio ma posso fare anche gennaio meno marzo.

ENdif <- EN13 - EN01
plot (ENdif, col=cls)

#plotto tutte e tre le immagini ricavate insieme
rlist <- list.files(pattern="EN") #list file crea una lista
rlist #lista di tutti i file che hanno al loro interno la parola EN in comune
#pattern è la scritta che hanno in comu e i file
import <- lapply(rlist,raster) #li importo tramite lapply
import

#dopo aver importato la lista dentro R quindi abbiamo i singoli file e a questo punto possiamo raggruppare tutti i file insieme e gli diamo un nome tramite la funzione stack:
#stack mi passa dai singoli file che io ho importato ad un unico grande file, per fare delle operazioni di plottaggio contemporaneamente
EN <- stack(import)
plot(EN, col=cls)

par(mfrow=c(1,3))
plot(EN01, col=cls, main="NO2 difference gennaio")
plot(EN13, col=cls, main="NO2 difference marzo")
plot(ENdif, col=cls, main="NO2 difference differenze")

#plotto tutto il set di immagini 


rlist <- list.files(pattern="EN") #list file crea una lista
rlist #lista di tutti i file che hanno al loro interno la parola EN in comune
#pattern è la scritta che hanno in comu e i file
import <- lapply(rlist,raster) #li importo tramite lapply
import

#dopo aver importato la lista dentro R quindi abbiamo i singoli file e a questo punto possiamo raggruppare tutti i file insieme e gli diamo un nome tramite la funzione stack:
#stack mi passa dai singoli file che io ho importato ad un unico grande file, per fare delle operazioni di plottaggio contemporaneamente
EN <- stack(import)
plot(EN, col=cls)

#plotto le immagini 1 e 13 dallo stack e le plottiamo una accabto all'altra
par(mfrow=c(1,2))
plot(EN$EN_0001, col=cls)
plot(EN$EN_0013, col=cls)


#raster pca 
#raster PCA: prende il pacchetto dei dati e li compatta in un numero minore di bande
ENpca <- rasterPCA(EN)
#la funzione summary ci da un sommario del nostro modello e visualizzarlo

summary(ENpca$model) 





plotRGB(ENpca$map, r=4, g=3, b=2, stretch="lin") #in rosso la parte stabile del set di dati
 
#calcoliamo la dev. standard di questa immagine con la funzione focal

pc1 <- ENpca$map$PC1
pc1sd <- focal(pc1, w=matrix(1/9, nrow=3, ncol=3), fun=sd)
plot(pc1sd)




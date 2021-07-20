#R_Code_Variability.r
library(raster)
library(RStoolbox)
# install.packages("RStoolbox")
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
#la prima componente principale spiega il 67,36 % della proporzione principale
summary(sentpca$model)
 #la prima PC spiega il 67,36804 % dell'informazione totale e originale 

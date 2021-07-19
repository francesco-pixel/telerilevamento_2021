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
#la finestra mobile si spostera e calcoleremo la dev standard dei pixel inclusi, ottengo cosi una nuova mappa con i valori. 
#in questo caso la finestra mobile passa su una sola banda quindi bisogna compattare 

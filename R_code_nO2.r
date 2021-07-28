#R_code_nO2.r

library(raster)


#Set the work directory EN


setwd("C:/lab/EN") windows

#importo la prima immagine e quindi la prima banda 

EN01 <- raster("EN_0001.png") #gennaio

#plotto la prima immagine con la mia color ramp palette preferita
cls <- colorRampPalette(c('blue','green','pink','magenta','orange','brown','red','yellow'))(200) # 
plot(EN_0001.png, col=cls)

#importo la tredicesima immagine e la plotto con l'ultima color ramp palette precedente
EN013 <- raster("EN_0013.png") #marzo
cls <- colorRampPalette(c('blue','green','pink','magenta','orange','brown','red','yellow'))(200) # 
plot(EN_0013.png, col=cls)

#faccio la differebza fra le due immagini, lo associo ad un oggetto e poi la plotto, marzo meno gennaio ma posso fare anche gennaio meno marzo.

ENdif <- EN13 - EN01
plot (ENdif, col=cls)

#plotto tutte e tre le immagini ricavate insieme
par(mfrow=c(3,1))
plot(EN_0001.png, col=cls main= "NO2 a gennaio)
plot(EN_0013.png, col=cls main= "NO2 a marzo)
plot (ENdif, col=cls main= "NO2 difference)

#R_Code_classification.r

#day 21/04

#Classificazione delle immagini: processo che accorpa pixel on valori simili rappresentando una classe (bosco, vegetazione,prateria, specie simili)
#studieremo il grand canyon , diverse rocce.
#Solar obiter: monitora il sole (sensori basati su raggi ultravioletti)

 setwd("C:/lab/") # Windows
# scarichiamo l'immagine solar obiter che rappresenta dei diversi livelli di energia tramite raggi UV, carichiamo l'immagine

library(raster)
 
so <- brick("Solar_Orbiter_s_first_views_of_the_Sun_pillars.jpg")
 
plotRGB(so, 1, 2, 3, stretch="lin")


soc <- unsuperClass(so, nClasses=3)
 

plot(soc$map)

library(RStoolbox)
# Unsupervised Classification with 20 classes

cl <- colorRampPalette(c('yellow','red','black'))(100)

# Unsupervised Classification with 20 classes
soc20 <- unsuperClass(so, nClasses=20)
plot(soc20$map)
 
sun <- brick("sun.png")


# Download an image from:
# https://www.esa.int/ESA_Multimedia/Missions/Solar_Orbiter/(result_type)/images
sun <- brick("sun.png")

 

# Unsupervised classification
sunc <- unsuperClass(sun, nClasses=3)
plot(sunc$map)


# Download an image from:
# https://www.esa.int/ESA_Multimedia/Missions/Solar_Orbiter/(result_type)/images
sun <- brick("sun.png")

 

# Unsupervised classification
sunc <- unsuperClass(sun, nClasses=3)
plot(sunc$map)

#R_Code_classification.r

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







    
# R_code_multivariate_analysis.r






setwd("C:/lab/") # Windows
 





p224r63_2011_masked.grd


p224r63_2011
 
plot(p224r63_2011$B1_sre, p224r63_2011$B2_sre, col="red", pch=19, cex=2)
 
pairs(p224r63_2011)
 

 


 


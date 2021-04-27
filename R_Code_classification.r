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

#possiamo plottare e classificare qualsiasi immagine (qffioramenti ecc), maggiore è il dettaglio dell'immagine e maggiori problemi riscontreremo. (esempio roccia che da il colore bianco)
#non sempre utilizziamo il sole come fonte di energia per le immagini satellitari, ma la fonte puo essere esterna al sensore. a volte puo essere interna come il laser.
#con il segnale radar ad esempio le nuvole non vengono viste e quindi oltrepassate. (frane ecc)
#sole immagine ottica e sensori passivi. laser hanno sensori attivi.


#visualizziamo le immagini del grand canyon, faremo una classificazione mineralogica.


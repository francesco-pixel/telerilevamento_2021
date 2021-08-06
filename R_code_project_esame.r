#R_code_project_exam.r

#R_code variazione della land cover nella parte superiore del bacino idrografico del Fiume Missisippi 
#Analisi multitemporale della land cover del bacino idrografico del Missisippi comrendende il Missisippi River, Illinois River ed il Missouri River.


#Durante la prima metà del 1993, il Midwest statunitense ha subito piogge insolitamente forti. Gran parte degli Stati Uniti nella parte superiore del bacino
#idrografico del fiume Mississippi ricevettero più di 1,5 volte le loro precipitazioni medie nei primi sei mesi dell'anno.
#Questa coppia di immagini estratte dall'Earth Observatory  che andrò ad analizzare tramite softwere R mostra l'area intorno a St. Louis, Missouri, nell'agosto 1991 e nel 1993. 
#L'immagine del 1993 è stata catturata leggermente dopo il picco dei livelli dell'acqua in questa parte del fiume Mississippi.
#Questa immagine a falsi colori è stata creata combinando lunghezze d'onda infrarosse,
#infrarosso vicino e verdi di luce osservate dallo strumento Thematic Mapper (TM) a bordo del satellite Landsat 5 
#L'acqua appare blu scuro, la vegetazione sana è verde, i campi nudi e il terreno appena esposto sono rosa. 
#Inoltre, il diffuso cambiamento della copertura del suolo lungo fiumi e torrenti ha modificato drasticamente i sistemi naturali di controllo

#NASA images created by Jesse Allen, Earth Observatory, using data provided courtesy of the Landsat Project Science Office.
#Sensori:
#Landsat 5 - TM con una risoluzione di 30m

# figure 1: 14 agosto 1991
# figure 2: 19 agosto 1993
#dati rasterbrick, un raster è una matrice di dati

#Utilizzo gli algoritmi di classificazione delle immagini e faccio un analisi multitemporale della variazione della copertura del suolo, successivamente calcolo alcuni parametri.


setwd("C:/lab/")


library(raster)


install.packages("RStoolbox") 
library(RStoolbox)#per la classificazione dell immagini

install.packages("ggplot2")
library(ggplot2) #per effettuare dei plottaggi dettagliati
#installo anche gridExtra per effettuare piu plottaggi insieme 

install.packages("gridExtra")
library(gridExtra)

#metto a confronto due immagini gia processate che hanno perso il proprio sistema di riferimento originale e faccio un' analisi multitemporale

#carico la prima immagine con la funzione brick
stlouis91 <- brick("stlouis91.jpg") 

stlouis91
#è un rasterbrick e cioè un raster multistrato.
#vediamo tutte le informazioni del dato tra cui crs che è il sistema di riferimento ed è uguale ad NA perche non ha più un sistema di riferimento in quanto è stata scaricata dall'earth obs e gia preprocessata.
plot(stlouis91) #visualizzo le 3 bande di riflettanza impacchettate nella nostra immagine 1991



#plotto il mio dato in RGB per visualizzarlo a colori naturali
plotRGB(stlouis91, r=1, g=2, b=3, stretch="Lin")
#all'interno di ggplot ci sono funzioni potenti per plottare immagini----> funzioni con gg
#funzione ggRGB, essa ha bisogno dell' immagine , delle componenti RGB e stretch.
#faccio un ggplot
ggRGB(stlouis91, r=1, g=2, b=3, stretch="Lin") #otteniamo un plot con le coordinate spaziali con uno stretch lineare evitando lomschiacciamento verso un colore (plot migliore)


#carico adesso la seconda immagine ed effettuo le stesse operazioni.

stlouis93 <- brick("stlouis93.jpg")
stlouis93 #info immagine
plot(stlouis93) #visualizziamo le 3 bande di riflettanza impacchettate nella nostra immagine 1993

#visualizzo l'immagine cambiando i colori sui valori delle riflettanze della mia immagine, utilizzando una mia personale legenda.
cl <- colorRampPalette(c('black','grey','orange'))(100)


plot(stlouis91, col=cl)
plot(stlouis93, col=cl)
#in queste tre bande ho i valori piu bassi di riflettanza nel nero ed i piu alti nell'arancio

plotRGB(stlouis93, r=1, g=2, b=3, stretch="Lin")
ggRGB(stlouis93, r=1, g=2, b=3, stretch="Lin")

#metto le immagine plotRGB accanto con la funzione parmfrow e le metto a confronto
par(mfrow=c(1,2))
plotRGB(stlouis91, r=1, g=2, b=3, stretch="Lin")
plotRGB(stlouis93, r=1, g=2, b=3, stretch="Lin")

#Potrei effettuare anche uno stretch hist che mi farà vedere ancor meglio le differenze in termini di riflettanza e quindi di colore
par(mfrow=c(1,2))
plotRGB(stlouis91, r=1, g=2, b=3, stretch="hist")
plotRGB(stlouis93, r=1, g=2, b=3, stretch="hist")






#usiamo adesso la funzione grid.arrange che mette insieme vari pezzi dentro il grafico
p1 <- ggRGB(stlouis91, r=1, g=2, b=3, stretch="Lin")
p2 <- ggRGB(stlouis93, r=1, g=2, b=3, stretch="Lin")
grid.arrange(p1, p2, nrow=2)
#immagini disposte su due righe


#Faccio una classificazione  in funzione della somiglianza massima di ogni pixel ed alla distanza 

#facciamo l'unsupervised classification (non viene supervisionata da noi) 
# classificazione non supervisionata
st1 <- unsuperClass(stlouis91, nSamples=10000, nClasses=3) 

#immmagine e numero di classi, utilizza 10000 pixel random e fa una classificazione in 3 classi

st1 #tre valori
# st1  è il modello e poi ho la mappa che ho creato che lego con il dollaro ottenendo la mappa
plot(st1$map)
#Vedo una classe in giallo data dall'acqua, una in verde data dalla vegetazione sana e una in bianco data dalla copertura nuda
#grazie ai diversi valori di riflettanza osserviamo diversi colori  che danno diverse classi  per ogni firma spettrale

#classe  in funzione della riflettanza e cioe quanta luce viene restituita da un certo corpo sulla terra che viene colpita dalla luce filtrata anche dall'atmosfera
#classe 1 suolo esposto in rosa
#classe 2 vegetazione sana. l'infrarosso vicino riflette piu di tutti
#classe 3 acqua fiume riflette poco

#classifico la seconda immagine del 1993
st2 <- unsuperClass(stlouis93, nSamples=10000, nClasses=3) 

st2

plot(st2$map)

#classe 1 suolo esposto in rosa
#classe 2 vegetazione sana
#classe 3 acqua fiume

#mettendo a confronto le due mappe posso calcolare l'evoluzione della vegetazione e l'incremento di acqua che ha avuto il fiume Missisipi, il Missouri ed il illinois river.
#calcolo la frequenza dei pixel di una certa classe chiedendomi quanti pixel ho delle corrisettive 3 classi e come sono state modificate dal 1991 al 1993 a causa delle intense piogge

#utilizzo la funzione freq per calcolare la frequeza dei pixel della mappa generata
freq(st1$map)
#value   count
#[1,]     1 7357344 pixel
#[2,]     2 5193331 pixel
#[3,]     3  409325 pixel

#calcolo la proporzione fra le tre classi di pixel nel 1991:

somma1 <- 7357344 + 5193331 + 409325
somma1


#faccio la proporzione facendo fre/somma valori (in %)
prop1 <- freq(st1$map) / somma1
prop1 #1991
#prop. 56.769630 suolo esposto
#prop. 40.071998 vegetazione sana
#prop. 3.158372 acqua river


 #utilizzo la funzione freq per calcolare la frequeza dei pixel della mappa generata
freq(st2$map)
#     value   count
#[1,]     1 7906266
#[2,]     2 3606231
#[3,]     3 1447503




#calcolo la proporzione per l'anno 1993
somma2 <- 7906266 + 3606231 + 1447503
somma2

#faccio la proporzione facendo freq/somma valori (in %)
prop2 <- freq(st2$map) / somma2
prop2 #1993

            value     count
#prop1. 61.00514 suolo esposto
#prop2. 27.82586 vegetazione sana
#prop3. 11.16900 acqua river

#adesso genero un dataset contenente i fattori e cioe delle variabili categoriche: suolo nudo, vegetazione sana e acqua con i rispettivi valori in % del 1991 e del 1993

#costruisco il mio dataframe


cover <- c("suolo esposto", "vegetazione sana", "acqua")
percent_1991 <- c(56.76, 40.07, 3.15)
percent_1993 <- c(61.00, 27.82, 11.16)

#con la funzione data.frame creo una tabella

percent <- data.frame(cover, percent_1991, percent_1993)
percent

# cover percent_1991 percent_1993
# 1 suolo esposto, vegetazione sana, acqua        56.76        61.00
# 2 suolo esposto, vegetazione sana, acqua        40.07        27.82
# 3 suolo esposto, vegetazione sana, acqua         3.15        11.16


#con la funzione ggplot faccio due buon  grafici e li metto a confronto 

g91 <- ggplot(percent, aes(x=cover, y=percent_1991, color=cover)) + geom_bar(stat="identity", fill="grey")

g93 <- ggplot(percent, aes(x=cover, y=percent_1993, color=cover)) + geom_bar(stat="identity", fill="grey")
#tra il 1991 e il 1993 notiamo un netto incremento di acqua 
#metto i due grafici a confronto con la funzione grid.arrange



grid.arrange(g91, g93, nrow=2)
#in questa zona della terra tra il 1991 e il 1993 notiamo un netto incremento di acqua con esondazioni da parte dei fiumi, vi è anche una diminuzione della vegetazione sana.
#ho analizzato un cambiamento multitemporale nell'area del Missisipi data da eventi metereologici intensi.

##################### analisi multitemporale e confronto firme spettrali

#tramite la funzione click ricavo informazioni relative alla riflettanza tra le due mappe e ne faccio un confronto
stlouis91 <- brick("stlouis91.jpg")


plotRGB(stlouis91, r=1, g=2, b=3, stretch="hist")
#faccio uno stretch hist ottenendo un'immagine piu dettagliata 

#creiamo lo spectral signatures di  stlouis91  e clicco 3 punti effettuando un tansetto perpendicolare  al Missisipi River e commento i valori ottenuti 
click(stlouis91, id=T, xy=T, cell=T, type="p", pch=16, cex=4, col="orange")
#la funzione click mi permette di effettuare dei click e ottenere risultati per ogni punto sulla riflettanza 
#id= identificativo
#xy=info spaziale
#tipo= punto
#pch= simbolo
#     x      y    cell stlouis91.1 stlouis91.2 stlouis91.3
#1 1589.5 1939.5 5977590         123         127          43
#       x      y    cell stlouis91.1 stlouis91.2 stlouis91.3
#1 1595.5 1882.5 6182796           0          22          36
#       x      y    cell stlouis91.1 stlouis91.2 stlouis91.3
#1 1606.5 1791.5 6510407         123          97          38


#ripeto l'operazione anche per l'immagine stlouis93
stlouis93 <- brick("stlouis93.jpg")


plotRGB(stlouis93, r=1, g=2, b=3, stretch="hist")
#faccio uno stretch hist ottenendo un'immagine piu dettagliata 
#creiamo lo spectral signatures di  stlouis91  e clicco 3 punti effettuando un tansetto perpendicolare  al Missisipi River ricoprendo lo stesso areale del precedente  

click(stlouis93, id=T, xy=T, cell=T, type="p", pch=16, cex=4, col="orange")
#   x      y    cell stlouis93.1 stlouis93.2 stlouis93.3
#1 1566.5 1876.5 6204367           2          29          46
#       x      y    cell stlouis93.1 stlouis93.2 stlouis93.3
#1 1572.5 1791.5 6510373           2          17          46
#       x      y    cell stlouis93.1 stlouis93.2 stlouis93.3
#1 1589.5 1649.5 7021590           5          23          27

#Dopo aver individuato lungo il mio transetto i valori di riflettanza di tutti e 3 i pixel rispettivi ai due anni posso costruire una tabella ed un dataframe e osservare il cambiamento tra il 1991 e il 1993

band <- c(1,2,3)
tempo1p1 <- c(123,127,43)
tempo1p2 <- c(0,22,36)
tempo1p3 <- c(123,97,38)
tempo2p1 <- c(2,29,46)
tempo2p2 <- c(2,17,46)
tempo2p3 <- c(5,23,27)
tabellaspectral <- data.frame(band, tempo1p1, tempo1p2, tempo1p3, tempo2p1, tempo2p2, tempo2p3)
#con ggplot plotto le tre curve temporali nel grafico 


ggplot(tabellaspectral, aes(x=band)) +
geom_line(aes(y=tempo1p1), color="red", inetype="dotted") +
geom_line(aes(y=tempo1p2), color="red", linetype="dotted") +
geom_line(aes(y=tempo1p3), color="red", linetype="dotted") +
geom_line(aes(y=tempo2p1), color="blue", linetype="dotted") +
geom_line(aes(y=tempo2p2), color="blue", linetype="dotted") +
geom_line(aes(y=tempo2p3), color="blue", linetype="dotted") +
labs(x="band", y="reflectance")
#linetype per differenziare le diverse linee ottenute 


#Posso osservare le curve in rosso riferite al 1991 dove si osserva un alto valore di riflettanza dato dalla vegetazione mentre una delle tre curve in rosso ha valori molto bassi
#in quanto uno dei tre pixel rilevati coincide e riflette con bassi valori dovuti all'acqua all'interno del fiume Mississipi,
#Per quanto riguarda invece l'anno 1993 tutti e tre le curve in blu riferite ai valori di riflettanza risultano essere bassi perche il fiume estendendo il suo areale
#ha esondato l'intero transetto studiato e di conseguenza risultano valori di riflettanza bassi a causa della sua
#espansione nel 1993 data dalle intense precipitazioni.









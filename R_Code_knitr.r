#day 16/04

setwd("C:/lab/") 


generiamo il codice che utilizzeremo dentro knitr 
# all'interno di R abbiamo il pacchetto knitr. e questo pacchetto dentro il nostro softwere puo utilizzare un codice esterno, quindi knotr va a prendere il codice all'esterno,lo importa dentro R e all'interno di R genera un report che verra salvato nella stessa cartella dove è presente il codice precedente.
#installiamo knitr
install.packages("knitr")
library("knitr")

#dopo aver salvato il codice nella cartella lab, da R usiamo il pacchetto knitr che pesca il codice nella cartella lab che va a caricare dentro R generando il report

#la funzione che useremo sarà:
stitch("R_Code_Greenland.r.txt", template=system.file("misc", "knitr-template.Rnw", package="knitr"))
#vedremo la generazione del report
#oltre aver generato il report, vengono generate le figure che mette dentro la cartella figure in lab


#un compilatore è un softwere come R che usa il codice per generare del testo
#registrazione a overlife, strumento potente per usare codice latex all'interno.

#primp progetto da tex
#ricompila: serve a passare dal file tex al pdf
#adesso copiamo e incolliamo tutto cio che è salvato nel file tex e lo copiamo dentro
#includegraphics: funzione che prende le figure e le inserisce all'interno, prendendole dentro la cartella  figure


#day 21/04

#Classificazione delle immagini: processo che accorpa pixel on valori simili rappresentando una classe (bosco, vegetazione,prateria, specie simili)
#studieremo il grand canyon , diverse rocce.
#Solar obiter: monitora il sole (sensori basati su raggi ultravioletti)

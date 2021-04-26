#day 16/04

setwd("C:/lab/") 


generiamo il codice che utilizzeremo dentro knitr 
# all'interno di R abbiamo il pacchetto knitr. e questo pacchetto dentro il nostro softwere puo utilizzare un codice esterno, quindi knotr va a prendere il codice all'esterno,lo importa dentro R e all'interno di R genera un report che verra salvato nella stessa cartella dove è presente il codice precedente.
#installiamo knitr
install.packages("knitr")
library("knitr")





require(knitr)
stitch("~/Downloads/R_code_temp.r", template=system.file("misc", "knitr-template.Rnw", package="knitr"))

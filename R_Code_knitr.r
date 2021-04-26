#day 16/04
generiamo il codice che utilizzeremo dentro knitr 



require(knitr)
stitch("~/Downloads/R_code_temp.r", template=system.file("misc", "knitr-template.Rnw", package="knitr"))

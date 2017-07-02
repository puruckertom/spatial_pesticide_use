#Install and load supporting libraries.
print(Sys.info()[4])

R.Version()$version.string
library(rmarkdown, quietly = TRUE, warn.conflicts = FALSE)
library(dplyr, quietly = TRUE, warn.conflicts = FALSE)
library(knitr, quietly = TRUE, warn.conflicts = FALSE)
library(ggplot2)
library(reshape2)
library(MASS)
library(pwr)
print("list of loaded packages: ")
print((.packages()))

#Determine path directory based on the user machine######
#tom epa windows
if(Sys.info()[4]=="DZ2626UTPURUCKE"){
  sp_root<-path.expand("k:/git/spatial_pesticide_use/")
}
if(Sys.info()[4]=="stp-air"){
  sp_root<-path.expand("~/git/spatial_pesticide_use/")
}
print(paste("Root directory location: ", sp_root, sep=""))

sp_data <- paste(sp_root, "data/", sep="")

#check to see if directories are accessible
boo = file.exists(paste(sp_data,"HighEstimate_AgPestUsebyCropGroup92to14.txt",sep=""))
print(paste("check to see if R can access files OK: ", boo))

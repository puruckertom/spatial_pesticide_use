#Install and load supporting libraries.
print(Sys.info()[4])

R.Version()$version.string
library(rmarkdown, quietly = TRUE, warn.conflicts = FALSE)
library(dplyr, quietly = TRUE, warn.conflicts = FALSE)
library(knitr, quietly = TRUE, warn.conflicts = FALSE)
library(fiftystater)
library(ggplot2)
library(mapproj)
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
if(Sys.info()[4]=="Coiles-MacBook-Pro.local" || Sys.info()[4]=="Coiles-MBP"){
  sp_root<-path.expand("~/git/spatial_pesticide_use/")
}
print(paste("Root directory location: ", sp_root, sep=""))

#create directories to write to
sp_data <- paste(sp_root, "data/", sep="")
sp_graphics <- paste(sp_root, "graphics/", sep="")

#check to see if directories are accessible
dir_check = file.exists(paste(sp_data,"HighEstimate_AgPestUsebyCropGroup92to14.txt",sep=""))
print(paste("check to see if R can access files OK: ", dir_check))

#files to import from data directory
file_state_high <- paste(sp_data,"HighEstimate_AgPestUsebyCropGroup92to14.txt",sep="")
species_state <- paste(sp_data,"endangered_species_state.csv",sep="")
google_scholar_citations <- paste(sp_data,"google_scholar_cites.csv",sep="")

# outputs to be written
out_national_high <- paste(sp_data,"national_high_summary.csv",sep="")
out_top20 <- paste(sp_data,"top20.csv",sep="")

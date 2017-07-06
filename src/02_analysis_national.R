national_by_year <- read.csv(out_national_high)
dim(national_by_year)
colnames(national_by_year)
compounds <- national_by_year$X
n_years <- length(colnames(national_by_year))-1
x <- 1:(n_years-1)

#linear slopes for use and create summary table
compound_info <- data.frame(matrix(NA, nrow = n_compounds, ncol = 4))
i=0
for(compound in compounds){
  i = i + 1
  pesticide_use <- as.numeric(national_by_year[i,2:n_years]) 
  use_max <- max(pesticide_use)
  lm_use <- lm(pesticide_use ~ x)
  use_slope <- lm_use$coefficients[[2]]
  plot(x,pesticide_use,title(main=compound, sub=use_slope))
  lines(x,predict.lm(lm_use),col='red')
  compound_info[i,1] <- compound
  compound_info[i,2] <- use_max
  compound_info[i,3] <- use_slope
}
#rank negative values to go from highest to lowest
compound_info[,4] <- rank(-compound_info[,2])
View(compound_info)

#top 20 1992, 2003, 2014
#1992
national_1992 <- national_by_year[,1:2]
national_1992[,3] <- rank(-national_1992[,2])
View(national_1992)
top20 <- which(national_1992[,3]<=20)
national_1992[top20,]

#2003
national_2003 <- national_by_year[,c(1,13)]
national_2003[,3] <- rank(-national_2003[,2])
View(national_2003)
top20 <- which(national_2003[,3]<=20)
national_2003[top20,]

#2014
national_2014 <- national_by_year[,c(1,24)]
national_2014[,3] <- rank(-national_2014[,2])
View(national_2014)
top20 <- which(national_2014[,3]<=20)
national_2014[top20,]

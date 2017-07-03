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

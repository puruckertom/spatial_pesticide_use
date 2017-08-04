national_by_year <- read.csv(out_national_high)
dim(national_by_year)
colnames(national_by_year)
compounds <- national_by_year$X
n_compounds <- length(compounds)
n_years <- length(colnames(national_by_year))-1
x <- 1:(n_years-1)
summary(national_by_year)
View(national_by_year)
national_by_year <- national_by_year[,2:25]
View(national_by_year)


#linear slopes for use and create summary table
compound_info <- data.frame(matrix(NA, nrow = n_compounds, ncol = 4))
i=0
for(compound in compounds){
  i = i + 1
  pesticide_use <- as.numeric(national_by_year[i,2:n_years]) 
  use_max <- max(pesticide_use)
  lm_use <- lm(pesticide_use ~ x)
  use_slope <- lm_use$coefficients[[2]]
  x <- 1992:2014
  plot(x,pesticide_use,type='l',col='red',xlab='Year',
       ylab='EPest High Estimate',title(main=compound))
  # sub=use_slope
  # lines(x,predict.lm(lm_use),col='red')
  compound_info[i,1] <- compound
  compound_info[i,2] <- use_max
  compound_info[i,3] <- use_slope
}
#rank negative values to go from highest to lowest
compound_info[,4] <- rank(-compound_info[,2])
summary(compound_info)
View(compound_info)
colnames(compound_info) <- c('compound','max_use','use_slope','rank')

#################
# grab some yearly snapshots
colnames(national_by_year)


#top 20 1992, 2003, 2014
#1992
national_1992 <- national_by_year[,1:2]
national_1992[,3] <- rank(-national_1992[,2])
top20 <- which(national_1992[,3]<=20)
top20_national_1992 <- national_1992[top20,]
colnames(top20_national_1992) <- c('compound', 'year', 'rank')
rank20_national_1992 <- top20_national_1992[order(top20_national_1992$rank),]

#1998
national_1998 <- national_by_year[,c(1,8)]
national_1998[,3] <- rank(-national_1998[,2])
top20 <- which(national_1998[,3]<=20)
top20_national_1998 <- national_1998[top20,]
colnames(top20_national_1998) <- c('compound', 'year', 'rank')
rank20_national_1998 <- top20_national_1998[order(top20_national_1998$rank),]

#2003
national_2003 <- national_by_year[,c(1,13)]
national_2003[,3] <- rank(-national_2003[,2])
top20 <- which(national_2003[,3]<=20)
top20_national_2003 <- national_2003[top20,]
colnames(top20_national_2003) <- c('compound', 'year', 'rank')
rank20_national_2003 <- top20_national_2003[order(top20_national_2003$rank),]

#2008
national_2008 <- national_by_year[,c(1,18)]
national_2008[,3] <- rank(-national_2008[,2])
top20 <- which(national_2008[,3]<=20)
top20_national_2008 <- national_2008[top20,]
colnames(top20_national_2008) <- c('compound', 'year', 'rank')
rank20_national_2008 <- top20_national_2008[order(top20_national_2008$rank),]

#2014
national_2014 <- national_by_year[,c(1,24)]
national_2014[,3] <- rank(-national_2014[,2])
top20 <- which(national_2014[,3]<=20)
top20_national_2014 <- national_2014[top20,]
colnames(top20_national_2014) <- c('compound', 'year', 'rank')
rank20_national_2014 <- top20_national_2014[order(top20_national_2014$rank),]

rank20_national_1992_compound <- as.character(rank20_national_1992$compound)
rank20_national_1998_compound <- as.character(rank20_national_1998$compound)
rank20_national_2003_compound <- as.character(rank20_national_2003$compound)
rank20_national_2008_compound <- as.character(rank20_national_2008$compound)
rank20_national_2014_compound <- as.character(rank20_national_2014$compound)

top20 <- cbind(rank20_national_1992_compound,rank20_national_1998_compound,
      rank20_national_2003_compound,rank20_national_2008_compound,
      rank20_national_2014_compound)

View(top20)
write.csv(top20, out_top20)

#top 20 time series plot
head(national_by_year)
top20_list <- Reduce(union, list(rank20_national_1992_compound, rank20_national_1998_compound, 
                   rank20_national_2003_compound, rank20_national_2008_compound,
                   rank20_national_2014_compound))
match(as.character(national_by_year$X) == top20_list)
type(as.character(national_by_year$X))

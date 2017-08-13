#https://water.usgs.gov/nawqa/pnsp/usage/maps/county-level/
#state level data
# metadata: https://water.usgs.gov/nawqa/pnsp/usage/maps/county-level/StateLevel/Metadata_AgPestUsebyCropGroup92to14.xml
# locally data/HighEstimate_AgPestUsebyCropGroup92to14.txt

#import state level metadata with farm regions
n_species_state <- read.csv(species_state, header=T)
summary(n_species_state)
n_species_state.df <- data.frame(state = tolower(n_species_state$state), 
                                 n_species = n_species_state$n_species,
                                 farm_region = n_species_state$farm_region)
summary(n_species_state.df)
farm_regions <- as.vector(unique(n_species_state.df$farm_region))
states <- as.vector(unique(n_species_state.df$state))

# load high estimates by state
sp_state_high <- read.table(file_state_high, sep = '\t', header=T)
dim(sp_state_high)
head(sp_state_high)

#factors as appropriate
colnames(sp_state_high)
class(sp_state_high$State_FIPS_code) <- factor(sp_state_high$State_FIPS_code)
states <- unique(sp_state_high$State)
class(sp_state_high$Compound)
compounds <- unique(sp_state_high$Compound)
class(sp_state_high$Year) <- factor(sp_state_high$Year)
years <- unique(sp_state_high$Year)
unique(sp_state_high$Units)

#convert NAs to zeroes for mathematical operations
sp_state_high$Corn[is.na(sp_state_high$Corn)] <- 0
sp_state_high$Soybeans[is.na(sp_state_high$Soybeans)] <- 0
sp_state_high$Wheat[is.na(sp_state_high$Wheat)] <- 0
sp_state_high$Cotton[is.na(sp_state_high$Cotton)] <- 0
sp_state_high$Vegetables_and_fruit[is.na(sp_state_high$Vegetables_and_fruit)] <- 0
sp_state_high$Rice[is.na(sp_state_high$Rice)] <- 0
sp_state_high$Orchards_and_grapes[is.na(sp_state_high$Orchards_and_grapes)] <- 0
sp_state_high$Alfalfa[is.na(sp_state_high$Alfalfa)] <- 0
sp_state_high$Pasture_and_hay[is.na(sp_state_high$Pasture_and_hay)] <- 0
sp_state_high$Other_crops[is.na(sp_state_high$Other_crops)] <- 0

#create sum column
sp_state_high$Sum <- sp_state_high$Corn + sp_state_high$Soybeans + sp_state_high$Wheat + sp_state_high$Cotton +
    sp_state_high$Vegetables_and_fruit + sp_state_high$Rice + sp_state_high$Orchards_and_grapes + 
    sp_state_high$Alfalfa + sp_state_high$Pasture_and_hay + sp_state_high$Other_crops
View(sp_state_high)

#create big summary table by summing across states and years for each compound
#create dataframe with dims #compounds by # years
n_compounds <- length(compounds)
n_years <- length(years)
n_states <- length(states)

national_by_year <- data.frame(matrix(NA, nrow = n_compounds, ncol = n_years))
colnames(national_by_year) <- years
rownames(national_by_year) <- compounds

## saved as csv and loaded on next script
i=0
for(compound in compounds){
  print(compound)
  i = i + 1
  j=0
  get_compound_rows <- which(sp_state_high$Compound==compound)
  for(year in years){
    j = j + 1
      get_year_rows <- which(sp_state_high$Year==year)
      compound_year <- intersect(get_compound_rows,get_year_rows)
      national_by_year[i,j] = sum(sp_state_high$Sum[compound_year])
  }
}
View(national_by_year)
write.csv(national_by_year, out_national_high)

## by usda farm regions

# add region to sp_state_high
summary(sp_state_high)
summary(n_species_state.df)
state_regions <- n_species_state.df[,-2]
merge(sp_state_high, state_regions, by.y = "name")

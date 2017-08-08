# usfws ecos 2015
# https://ecos.fws.gov/ecp0/reports/species-listed-by-state-totals-report

data("fifty_states") # this line is optional due to lazy data loading

#species_state imported in 00load.R
           
           
crimes <- data.frame(state = tolower(rownames(USArrests)), USArrests)
crimes

# map_id creates the aesthetic mapping to the state name column in your data
p <- ggplot(n_species_state.df, aes(map_id = state)) + 
  # map points to the fifty_states shape data
  geom_map(aes(fill = n_species), map = fifty_states) + 
  # scale_fill_gradient(low='white', high='grey20') +
  # scale_fill_gradientn(colours = terrain.colors(10)) +
  scale_fill_gradient2(low = "darkblue", high = "darkred", midpoint = 375) +
  expand_limits(x = fifty_states$long, y = fifty_states$lat) +
  coord_map() +
  scale_x_continuous(breaks = NULL) + 
  scale_y_continuous(breaks = NULL) +
  labs(x = "", y = "") +
  theme(legend.position = "bottom", 
        panel.background = element_blank())

p
# add border boxes to AK/HI
p + fifty_states_inset_boxes() 

hist(n_species_state.df$n_species,breaks=20,col = "darkblue",
     main="",xlab = "Number of listed species", ylab = "Frequency of states")




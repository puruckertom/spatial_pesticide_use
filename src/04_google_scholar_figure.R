library(ggplot2)

#create figure of top20 use 
summary(google_cites)
class(google_cites$Pesticide)
class(google_cites$Citations)

p<-ggplot(data=google_cites, aes(x=Pesticide, y=Citations)) +
  geom_bar(stat="identity", fill="purple4") +
  geom_text(aes(label=Citations), vjust=-0.3, size=3.5)+
  scale_x_discrete(limits=google_cites$Pesticide)+
  labs(x="Top 20 Pesticides Sorted by Pounds Applied in 2014", 
       y="Lit Citations since 2013 \n (+amphibian, +pesticide_x)") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 90, hjust = 1))
p

jpeg(paste(sp_graphics,"use_by_citations.jpg", sep=""),width = 8, height = 6, units = "in",res=300)
  p
dev.off()

library(ggplot2)
library(grid)
library(gridExtra)

setwd("~/Desktop/Linda's Projects/Pokemon")

data = read.csv('pokemon-data.csv')
data$type1 = as.character(data$type1)
data$type2 = as.character(data$type2)

#######################################
# overall type distribution
#######################################

plotPokemonTypes = function(data, titleString) {
  combinedTypes = c(data$type1, data$type2)
  typesFreq = as.data.frame(table(combinedTypes))
  typesFreq = typesFreq[-13,] 
  
  typesColors = c('#A8B820','#705848', '#7038F8', '#F8D030', '#EE99AC', '#C03028', '#F08030', '#A890F0', '#705898', '#78C850', '#E0C068', '#98D8D8', '#A8A878', '#A040A0', '#F85888', '#B8A038', '#B8B8D0', '#6890F0')
  print(titleString)
  p = ggplot(data=typesFreq, aes(x=combinedTypes, y=Freq)) +
    geom_bar(stat="identity", fill=typesColors) + 
    xlab("") + ylab("Count") + ylim(c(0,40)) +
    ggtitle(titleString) + 
    theme(plot.title = element_text(hjust = 0.5, face='bold'))
  p
}

plotPokemonTypesALL = function() {
  combinedTypes = c(data$type1, data$type2)
  typesFreq = as.data.frame(table(combinedTypes))
  typesFreq = typesFreq[-13,] 
  
  typesColors = c('#A8B820','#705848', '#7038F8', '#F8D030', '#EE99AC', '#C03028', '#F08030', '#A890F0', '#705898', '#78C850', '#E0C068', '#98D8D8', '#A8A878', '#A040A0', '#F85888', '#B8A038', '#B8B8D0', '#6890F0')
  
  p = ggplot(data=typesFreq, aes(x=combinedTypes, y=Freq)) +
    geom_bar(stat="identity", fill=typesColors) + 
    xlab("") + ylab("Count") +
  ggtitle("All Regions (908 total Pokemon)") + 
    theme(plot.title = element_text(hjust = 0.5, face='bold'))
  p
}

#######################################
# type distribution by region
#######################################

regions = unique(data$region)
regions = as.character(regions)

plots = list()
for (i in 1:length(regions)) {
  regionString = regions[i]
  
  regionData = data[which(data$region == regionString),]
  regionString = paste(regionString, " Region", sep="")

  pokeCount = dim(regionData)[1]
  regionString = paste(regionString, " (", pokeCount, " total Pokemon)", sep="")
  plots[[i]] = plotPokemonTypes(regionData, regionString)
}

plots[[8]] = plotPokemonTypesALL()

do.call(grid.arrange, list(grobs=plots, ncol=2, top=textGrob("Distribution of Pokemon Types", gp=gpar(fontface="bold", fontsize=16))))


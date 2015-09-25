## Read in the data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## Load the necessary packages
library(dplyr)
library(ggplot2)

## Subset SCC for External Combustion, then for Coal
SCC_extComb <- subset(SCC, grepl('Fuel Comb', EI.Sector))
SCC_extComb_Coal <- subset(SCC_extComb, grepl('Coal', EI.Sector))

## Put the SCC codes for Coal into a vector
coalCodes <- SCC_extComb_Coal$SCC

## Subset NEI by Ext Comb - Coal vector of SCC codes
NEIcoal <- subset(NEI, coalCodes %in% SCC)

## Aggregate the Emissions by year and type with a sum
NEIcoal <- aggregate(Emissions ~year + type, data=NEIcoal, sum)

## Plot it!
##ggplot: http://www.cookbook-r.com/Graphs/Bar_and_line_graphs_(ggplot2)/
png(file="plot4.PNG", bg="transparent")
coalPlot <- ggplot(data=NEIcoal, aes(x=year, y=Emissions, group=type, shape=type, color=type)) +
  geom_point(size=3, name="") +
  geom_line(name="") +
  xlab("Years") + ylab("Emissions in PPM") +
  ggtitle("National Emissions Trends") +
  theme_bw()
coalPlot + scale_color_discrete(name = "Type of Source") + scale_shape_discrete(name="Type of Source")
dev.off()
## Read in the data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## Load the necessary packages
library(dplyr)
library(ggplot2)

## Subset SCC for Motor Vehicle sources
SCC_mv <- subset(SCC, grepl('Mobile - On-Road', EI.Sector))

## Put the SCC codes for motor vehicles into a vector
mvCodes <- SCC_mv$SCC

## Subset NEI by Motor Vehicles vector of SCC codes
#mvNEI <- subset(NEI, mvCodes %in% NEI$SCC)
#mvNEI <- subset(NEI, fips == '24510' & grep(mvCodes, SCC))
#mvNEI <- subset(NEI, mvCodes %in% NEI$SCC)

## Subset NEI by ON-ROAD pollution types
mvNEI <- subset(NEI, type == 'ON-ROAD')

## Subset mvNEI by SCC codes for Motor Vehicles
mvNEI <- subset(mvNEI, mvCodes %in% mvNEI$SCC)

## Subset mvCodes by Baltimore, MD fips code
mvNEIBalmer <- subset(mvNEI, fips == '24510')

## Aggregate the Emissions by year and type with a sum
mvNEIBalmerAgg <- aggregate(Emissions ~year + type, data=mvNEIBalmer, sum)

## Plot it!
##ggplot: http://www.cookbook-r.com/Graphs/Bar_and_line_graphs_(ggplot2)/
png(file="plot5.PNG", bg="transparent")
mvPlot <- ggplot(data=mvNEIBalmerAgg, aes(x=year, y=Emissions, group=type, shape=type, color=type)) +
  geom_point(size=3, name="") +
  geom_line(name="") +
  xlab("Years") + ylab("MV Emissions in PPM") +
  ggtitle("Baltimore City, MD Motor Vehicle Emissions Trends") +
  theme_bw()
mvPlot + scale_color_discrete(name = "Type of Source") + scale_shape_discrete(name="Type of Source")
dev.off()
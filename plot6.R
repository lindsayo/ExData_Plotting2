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

## Subset mvCodes by Los Angeles, CA fips code
mvNEILA <- subset(mvNEI, fips == '06037')

## Aggregate the Emissions by year and type with a sum
mvNEIBalmerAgg <- aggregate(Emissions ~year + type, data=mvNEIBalmer, sum)
mvNEILAAgg <- aggregate(Emissions ~year + type, data=mvNEILA, sum)

## Plot it!
##ggplot: http://www.cookbook-r.com/Graphs/Bar_and_line_graphs_(ggplot2)/
mvPlot2 <- ggplot() +
  geom_line(aes(x=year,y=Emissions,color="MD"), data = mvNEIBalmerAgg) + 
  geom_line(aes(x=year,y=Emissions,color="LA"), data = mvNEILAAgg) +
  xlab("Years") + ylab("MV Emissions in PPM") +
  ggtitle("Baltimore, MD & Los Angeles, CA Motor Vehicle Emissions Trends") +
  theme_bw()
png(file="plot6.PNG", bg="transparent")
mvPlot2 + scale_colour_discrete("City")
dev.off()
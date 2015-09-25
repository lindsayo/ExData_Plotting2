## Read in the data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## Load the necessary packages
library(dplyr)
library(ggplot2)

## Subset NEI by fips = 24510 for Baltimore City, MD
NEIBalmer <- filter(NEI, fips == '24510')

## Aggregate the Emissions by year and type with a sum
NEIBalmer <- aggregate(Emissions ~year + type, data=NEIBalmer, sum)

## Plot it!
##ggplot: http://www.cookbook-r.com/Graphs/Bar_and_line_graphs_(ggplot2)/
png(file="plot3.PNG", bg="transparent")
BalmerPlot <- ggplot(data=NEIBalmer, aes(x=year, y=Emissions, group=type, shape=type, color=type)) +
  geom_point(size=3, name="") +
  geom_line(name="") +
  xlab("Years") + ylab("Emissions in PPM") +
  ggtitle("Emissions Trends for Baltimore, MD") +
  theme_bw()
BalmerPlot + scale_color_discrete(name = "Type of Source") + scale_shape_discrete(name="Type of Source")
dev.off()
## Read in the data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## Load the necessary packages
library(dplyr)

## Subset NEI by each of the years
NEI99 <- filter(NEI, year == '1999')
NEI02 <- filter(NEI, year == '2002')
NEI05 <- filter(NEI, year == '2005')
NEI08 <- filter(NEI, year == '2008')

## Sum the Emissions values for each year
sum99 <- sum(NEI99$Emissions)
sum02 <- sum(NEI02$Emissions)
sum05 <- sum(NEI05$Emissions)
sum08 <- sum(NEI08$Emissions)

## Set up the bar plot axes
years <- c(1999,2002,2005,2008)
sums <- c(sum99, sum02, sum05, sum08)

## Plot it!
png(file="plot1.PNG", bg="transparent")
barplot(sums, names.arg=years)
text(plotIt, sums, labels=round(sums, digits=0), pos=1, offset=.3)
dev.off()
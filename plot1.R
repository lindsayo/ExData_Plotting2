## Read in the data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## Load the necessary packages
library(dplyr)

## Subset NEI by each of the years
years <- c(1999,2002,2005,2008)
sum99 <- sum(NEI99$Emissions)
sum02 <- sum(NEI02$Emissions)
sum05 <- sum(NEI05$Emissions)
sum08 <- sum(NEI08$Emissions)
sums <- c(sum99, sum02, sum05, sum08)

barplot(sums, names.arg=years)
text(plotIt, sums, labels=round(sums, digits=0), pos=1, offset=.3)
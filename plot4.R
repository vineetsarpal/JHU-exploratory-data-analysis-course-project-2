# Load the libraries
library(tidyverse)
library(ggplot2)

# Read the data
NEI <- readRDS("./data/summarySCC_PM25.rds")
SCC <- readRDS("./data/Source_Classification_Code.rds")

# Fetch relevant data - Coal Combustion emissions
coal <- grep("Coal", SCC$SCC.Level.Four)
combust <- grep("Comb",SCC$SCC.Level.One)
coalcombust <- intersect(coal, combust)
SCC_coalcombust <- SCC[coalcombust,]$SCC

PM25CoalCombust <- NEI %>% 
    filter(SCC %in% SCC_coalcombust) %>% 
    group_by(year) %>% 
    summarise(PM25 = sum(Emissions))
    
# Plot the data
png(filename = "plot4.png", width = 480, height = 480)
options(scipen = 999)
g <- ggplot(PM25CoalCombust, aes(x = year, y = PM25))
g + geom_point() + geom_line() +
    ggtitle("Total PM2.5 emissions due to Coal Combustion in US")
dev.off()

# Load the libraries
library(tidyverse)

# Read the data
NEI <- readRDS("./data/summarySCC_PM25.rds")

# Fetch relevant data - Total PM25 from all sources
PM25byYears <- NEI %>% 
    group_by(year) %>% 
    summarise(PM25 = sum(Emissions))

# Plot the data
png(filename = "plot1.png", width = 480, height = 480)
options(scipen = 999)
plot(PM25byYears)
lines(PM25byYears)
title(main = "Total PM2.5 emissions in US from all sources")
dev.off()

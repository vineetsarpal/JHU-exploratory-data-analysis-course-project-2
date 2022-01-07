# Load the libraries
library(tidyverse)

# Read the data
NEI <- readRDS("./data/summarySCC_PM25.rds")

# Fetch relevant data - PM25 in Baltimore from all sources
PM25Balt <- NEI %>% 
    filter(fips == "24510") %>% 
    group_by(year) %>% 
    summarise(PM25 = sum(Emissions))

# Plot the data
png(filename = "plot2.png", width = 480, height = 480)
options(scipen = 999)
plot(PM25Balt)
lines(PM25Balt)
title(main = "Total PM2.5 emissions in Baltimore from all sources")
dev.off()

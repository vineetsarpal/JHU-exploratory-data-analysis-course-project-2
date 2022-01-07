# Load the libraries
library(tidyverse)
library(ggplot2)

# Read the data
NEI <- readRDS("./data/summarySCC_PM25.rds")

# Fetch relevant data - PM25 by type of source
PM25BaltByType <- NEI %>% 
    filter(fips == "24510") %>% 
    group_by(year, type) %>% 
    summarise(PM25 = sum(Emissions))

# Plot the data
png(filename = "plot3.png", width = 480, height = 480)
options(scipen = 999)
g <- ggplot(PM25BaltByType, aes(x = year, y = PM25, col = type))
g + geom_point() + geom_line() +
    ggtitle("Total PM2.5 emissions in Baltimore by Source type")
dev.off()

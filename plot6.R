# Load the libraries
library(tidyverse)
library(ggplot2)

# Read the data
NEI <- readRDS("./data/summarySCC_PM25.rds")
SCC <- readRDS("./data/Source_Classification_Code.rds")

# Fetch relevant data - Motor vehicle emissions in Baltimore and California
veh <- grep("Vehicle", SCC$SCC.Level.Two)
SCC_veh <- SCC[veh,]$SCC

PM25MotorVehBaltnCal <- NEI %>% 
    filter((fips == "24510" | fips == "06037") & NEI$SCC %in% SCC_veh) %>% 
    mutate(Region = if_else(fips == "24510", "Baltimore", "LA County")) %>% 
    group_by(year, Region) %>% 
    summarise(PM25 = sum(Emissions))

# Plot the data
png(filename = "plot6.png", width = 480, height = 480)
options(scipen = 999)
g <- ggplot(PM25MotorVehBaltnCal, aes(x = year, y = PM25))
g + geom_point() + geom_line() + facet_grid(.~Region) +
    ggtitle("Total PM2.5 emissions by Motor Vehicles in Baltimore & LA")
dev.off()

# Load the libraries
library(tidyverse)
library(ggplot2)

# Read the data
NEI <- readRDS("./data/summarySCC_PM25.rds")
SCC <- readRDS("./data/Source_Classification_Code.rds")

# Fetch relevant data - Motor vehicle emissions in Baltimore
veh <- grep("Vehicle", SCC$SCC.Level.Two)
SCC_veh <- SCC[veh,]$SCC

PM25MotorVehBalt <- NEI %>% 
    filter(fips == "24510" & NEI$SCC %in% SCC_veh) %>% 
    group_by(year) %>% 
    summarise(PM25 = sum(Emissions))

# Plot the data
png(filename = "plot5.png", width = 480, height = 480)
options(scipen = 999)
g <- ggplot(PM25MotorVehBalt, aes(x = year, y = PM25))
g + geom_point() + geom_line() + 
    ggtitle("Total PM2.5 emissions by Motor Vehicles in Baltimore")
dev.off()

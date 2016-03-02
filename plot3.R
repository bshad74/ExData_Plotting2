library(plyr)
library(ggplot2)
#Read the rds data for PM2.5 Emissions Data and Source Classification Code Table
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#Aggregate Emissions by year and filter "24510"
NEI.24510 <- NEI[which(NEI$fips == "24510"), ]
total.emissions.baltimore <- with(NEI.24510, aggregate(Emissions, by = list(year), 
                                                       sum))
colnames(total.emissions.baltimore) <- c("year", "Emissions")

#Aggregate Emissions by year, filter "24510", county, and type
total.emissions.baltimore.type <- ddply(NEI.24510, .(type, year), summarize, 
                                        Emissions = sum(Emissions))
total.emissions.baltimore.type$Pollutant_Type <- total.emissions.baltimore.type$type


#Open graphics device
png("plot3.png", width=480, height=480, units = "px")

#Plot final data to see which of the 4 sources have seen decreased emissions

qplot(year, Emissions, data = total.emissions.baltimore.type, group = Pollutant_Type, 
      color = Pollutant_Type, geom = c("point", "line"), ylab = expression("Total Emissions, PM"[2.5]), 
      xlab = "Year", main = "Total Emissions in U.S. by Type of Pollutant")
#shutdown device
dev.off()
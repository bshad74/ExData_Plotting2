library(plyr)

#Read the rds data for PM2.5 Emissions Data and Source Classification Code Table
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#We are doing aggregate w/ filter with ddply(plyr). Baltimore is fips code 24510
NEI.24510 <- NEI[which(NEI$fips == "24510"), ]
total.emissions.baltimore <- with(NEI.24510, aggregate(Emissions, by = list(year), 
                                                       sum))
colnames(total.emissions.baltimore) <- c("year", "Emissions")

#Open png device
png("plot2.png", width=480, height=480, units = "px")

#Total emissions from PM2.5 on average decreased in the Baltimore City, Maryland from 1999 to 2008

plot(total.emissions.baltimore$year, total.emissions.baltimore$Emissions, type = "b", 
     pch = 18, col = "green", ylab = "Emissions", xlab = "Year", main = "Baltimore Emissions")
#shutdown graphic device
dev.off()
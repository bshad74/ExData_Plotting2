library(ggplot2)

#Read the rds data for PM2.5 Emissions Data and Source Classification Code Table
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#Subsetting on baltimore city (fips=24510) and "on-road" Type
NEIonRoad <- NEI[(NEI$fips=="24510") & (NEI$type=="ON-ROAD"), ]

#Filter out from all emissions on above criteria and calculate aggregate
aggData <- aggregate(NEIonRoad$Emissions, list(Year=NEIonRoad$year), sum)
aggData$x <- aggData$x/1000

#Open graphics device
png(filename="plot5.png", width=480, height=480)

#Plotting the details to answer how emissions changed from motor vecicle sources 
ggplot(aggData) + 
    geom_line(aes(y = x, x = Year)) + 
    labs(y="Amount of PM2.5 emitted (tons)") + 
    ggtitle(expression(atop("Total PM2.5 emission from motor vehicle sources", 
                            atop(italic("Baltimore City, Maryland"), ""))))
#shutdown device
dev.off()

library(ggplot2)
library(data.table)

#Read the rds data for PM2.5 Emissions Data and Source Classification Code Table
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

NEI.DT = data.table(NEI)
SCC.DT = data.table(SCC)
#Filter Coal related source names from SCC Table
coal.scc = SCC.DT[grep("Coal", SCC.Level.Three), SCC]


#Now filter out all related emission sources for all the above Coal Sources
coal.emissions = NEI.DT[SCC %in% coal.scc, sum(Emissions), by = "year"]
colnames(coal.emissions) <- c("year", "Emissions")

#Open graphics device
png("plot4.png", width=480, height=480)
#Plot final data to plot which of the 4 sources have seen decreased emissions
g = ggplot(coal.emissions, aes(year, Emissions)) 
g + geom_point(color = "red") + geom_line(color = "green") + labs(x = "Year") + 
    labs(y = expression("Total Emissions, PM"[2.5])) + labs(title = "Emissions from Coal Combustion for the US")

#shutdown device
dev.off()
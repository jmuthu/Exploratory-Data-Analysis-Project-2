library(reshape2)
library(ggplot2)
dir_contents <- dir()
if (!("summarySCC_PM25.rds" %in% dir_contents &&
        "Source_Classification_Code.rds" %in% dir_contents)){
  
  download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip",
                "./NEI.zip")
  unzip("./NEI.zip")
}
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS ("Source_Classification_Code.rds")

# Get data from Baltimore and Los Angeles County
NEI <- NEI[NEI$fips == "24510" | NEI$fips == "06037",]

# Get the Code for motor vehicles
SCC_Mobiles <- SCC[grep("Vehicles",SCC$EI.Sector),]

NEI <- NEI[NEI$SCC %in% SCC_Mobiles$SCC,]

result <- dcast(NEI, year~fips, value.var="Emissions", sum)
result <- melt(result, id="year", variable.name="City")

g <- ggplot(result, aes(x=year, y=value, color = City )) + 
  geom_step() + geom_point() +
  scale_colour_discrete(name  ="City",
                        breaks=c("06037", "24510"),
                        labels=c("Los Angels County", "Baltimore City")) +
  labs(title = "Total PM2.5 Emissions in Baltimore And Los Angeles")  + 
  labs(x = "Year")  + labs(y = "Total PM2.5 Emissions (tons)")
ggsave(filename="plot6.png", plot = g)

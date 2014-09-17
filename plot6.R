library(reshape2)
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

png(filename="plot5.png", width=480, height=480)
par(bg="transparent")
plot(names(result),
     as.vector(result), 
     xlab="Year",
     xaxt = "n",
     pch = 20,
     type="o",
     main="Total PM2.5 Emissions from motor vehicles in Baltimore City",
     ylab="Total PM2.5 Emissions (tons)")
axis(1, at=names(result))

dev.off()

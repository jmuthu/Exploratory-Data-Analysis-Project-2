dir_contents <- dir()
if (!("summarySCC_PM25.rds" %in% dir_contents &&
        "Source_Classification_Code.rds" %in% dir_contents)){
  
  download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip",
                "./NEI.zip")
  unzip("./NEI.zip")
}
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS ("Source_Classification_Code.rds")

NEI_baltimore <- NEI[NEI$fips == "24510",]

result <- tapply(NEI_baltimore$Emissions,NEI_baltimore$year,sum)

png(filename="plot2.png", width=480, height=480)
par(bg="transparent")
plot(names(result),
     as.vector( result), 
     xlab="Year",
     xaxt = "n",
     pch = 20,
     type="b",
     main="Total PM2.5 Emissions in Balitmore City",
     ylab="Total PM2.5 Emissions (tons)")
axis(1, at=names(result))

dev.off()

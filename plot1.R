dir_contents <- dir()
if (!("summarySCC_PM25.rds" %in% dir_contents &&
      "Source_Classification_Code.rds" %in% dir_contents)){
  
 download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip",
                "./NEI.zip")
  unzip("./NEI.zip")
}
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS ("Source_Classification_Code.rds")


result <- tapply(NEI$Emissions,NEI$year,sum)

png(filename="plot1.png", width=480, height=480)
par(bg="transparent")
plot(names(result),
              as.vector( result)/1000, 
              xlab="Year",
              xaxt= "n",
              pch = 20,
              type="b",
              main="Total PM2.5 Emissions",
              ylab="Total PM2.5 Emissions (Kilotons)")
axis(1, at=names(result))

dev.off()

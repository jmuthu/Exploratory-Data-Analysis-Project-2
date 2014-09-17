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
result <- melt(result)

png(filename="plot2.png", width=480, height=480)
par(bg="transparent")
plot(result$Var1,
     result$value, 
     xlab="Year",
     xaxt = "n",
     pch = 20,
     type="p",
     main="Total PM2.5 Emissions in Baltimore City",
     ylab="Total PM2.5 Emissions (tons)")
axis(1, at=result$Var1)
l <- lm(value~Var1,result)
abline(l)

dev.off()

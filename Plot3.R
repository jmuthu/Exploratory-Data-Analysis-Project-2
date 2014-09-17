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

NEI_baltimore <- NEI[NEI$fips == "24510",]

result <- dcast(NEI_baltimore, year~type, value.var="Emissions", sum)
result <- melt(result, id="year", variable.name="Type")

g <- ggplot(result, aes(x=year, y=value )) + 
  geom_point() + geom_smooth(method = "lm") +
  facet_wrap(~Type, nrow=1, ncol=4, scales="free_y") +
  labs(title = "Total PM2.5 Emissions in Baltimore City")  + 
  labs(x = "Year")  + labs(y = "Total PM2.5 Emissions (tons)")
ggsave(filename="plot3.png", plot = g)
 

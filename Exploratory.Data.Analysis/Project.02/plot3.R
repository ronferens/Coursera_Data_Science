library(ggplot2)

# Setting the working directory
setwd('C:/Users/rferens/Git/datasciencecoursera/Exploratory.Data.Analysis/Project.02/')

# Creating the data directory in case it not exists yet
dataDir <- "./Data"
if(!file.exists(dataDir)) {
  dir.create(dataDir)
}

##========================================
## Getting the data set
##========================================
# Checking if the data zip file exist
destFileZip <- paste(dataDir, sep="/", "exdata-data-NEI_data.zip")
if(!file.exists(destFileZip)) {
  url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
  download.file(url, dest=destFileZip, mode="wb")
  unzip(destFileZip, exdir=dataDir)
}

NEI_File <- paste(dataDir, sep="/", "summarySCC_PM25.rds")
if(!file.exists(NEI_File)) {
  stop("summarySCC_PM25.rds does not exist")
}
NEI_Data <- readRDS(NEI_File)

SCC_File <- paste(dataDir, sep="/", "Source_Classification_Code.rds")
if(!file.exists(SCC_File)) {
  stop("Source_Classification_Code.rds does not exist")
}
SCC_Data <- readRDS(SCC_File)

##========================================
## Analysis
##========================================
BaltimoreCityData <- NEI_Data[NEI_Data$fips == "24510",]
totalPM25emitted <- tapply(BaltimoreCityData$Emissions, BaltimoreCityData$year, sum)
years <- unique(BaltimoreCityData$year)

##========================================
## GEnerating the plot
##========================================
png("plot3.png")
p <-  ggplot(data=BaltimoreCityData, aes(x = factor(year), y = Emissions)) + 
      geom_bar(stat="identity") +
      facet_grid(.~ type) +
      labs(x = "year", y = expression("Total PM"[2.5]*" Emission [Tons]"), srt=45) +
      theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
      labs(title = expression("PM"[2.5]*" Emissions per source type in Baltimore city from 1999-2008"))
print(p)
dev.off()
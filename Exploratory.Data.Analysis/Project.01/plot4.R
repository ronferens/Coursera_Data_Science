# Setting the working directory
setwd('C:/Users/rferens/Git/datasciencecoursera/Exploratory.Data.Analysis//Project.01')

# Creating the data directory in case it not exists yet
dataDir <- "./Data"
if(!file.exists(dataDir)) {
  dir.create(dataDir)
}

##========================================
## Getting the data set
##========================================
# Checking if the data zip file exist
destFileZip <- paste(dataDir, sep="/", "Electric.power.consumption.zip")
if(!file.exists(destFileZip)) {
  url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  download.file(url, dest=destFileZip, mode="wb")
  unzip(destFileZip, exdir=dataDir)
}

inputFile <- paste(dataDir, sep="/", "household_power_consumption.txt");
data <- read.table(inputFile, header = TRUE, sep=";", na.strings="?")
data$Date <- as.Date(data$Date, "%d/%m/%Y")

# Getting only data from the dates 2007-02-01 and 2007-02-02
subData <- subset(data, subset=(Date >= "2007-02-01" & Date <= "2007-02-02"))

##========================================
## Creating the plots
##========================================
png(file="plot4.png",width=480,height=480)

timeAndDate <- as.POSIXct(paste(as.Date(subData$Date), subData$Time))

par(mfrow = c(2,2))
with(subData, {
  # Top-Left plot
  plot(Global_active_power~timeAndDate, type="l", ylab = "Global Active Power", xlab = "")
  
  # Top-Right plot
  plot(Voltage~timeAndDate, type="l", ylab = "Voltage", xlab = "datetime")
  
  #Bottom-Left plot
  plot(subData$Sub_metering_1~timeAndDate, type="l", ylab="Energy sub metering", xlab="", col="black")
  lines(subData$Sub_metering_2~timeAndDate, type="l", col="red")
  lines(subData$Sub_metering_3~timeAndDate, type="l", col="purple")
  legend("topright",
         lwd = 2,
         col = c("black", "red", "purple"),
         legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
         bty = "n")
  
  #Bottom-Right plot
  plot(Global_reactive_power~timeAndDate, type="l", ylab = "Global_reactive_power", xlab = "datetime")
  
  
})

dev.off()
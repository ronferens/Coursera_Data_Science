setwd('C:/Users/rferens/Git/datasciencecoursera/Getting.and.Cleaning.Data/Quiz.04/')
datatDir <- "./Data"
if(!file.exists(datatDir)) {
  dir.create(datatDir)
}


##========================================
## Question #1
##========================================
destFile1 <- paste(datatDir, sep="/", "dataset_q1.csv")
if(!file.exists(destFile1)) {
  url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
  download.file(url, dest=destFile1, mode="wb")
}

data1 <- read.csv(destFile1)
splitNames  <-strsplit(names(data1), "wgtp")
print("Quetion #1 solution:")
print(splitNames[[123]])


##========================================
## Question #2
##========================================
destFile2 <- paste(datatDir, sep="/", "dataset_q2.csv")
if(!file.exists(destFile2)) {
  url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
  download.file(url, dest=destFile2, mode="wb")
}

data2 <- read.csv(destFile2)
valuesStr <- gsub(",", "", data2$X.3[5:194])
numbIndexes <- grep("[0-9]+", valuesStr)
avrg <- mean(as.numeric(valuesStr[numbIndexes]))

print("Quetion #2 solution:")
print(avrg)

##========================================
## Question #3
##========================================
q2ans <- grep("^United", data2$X.2)
print("Quetion #3 solution:")
print(length(q2ans))

##========================================
## Question #4
##========================================
destFile4 <- paste(datatDir, sep="/", "dataset_q4.csv")
if(!file.exists(destFile4)) {
  url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv"
  download.file(url, dest=destFile4, mode="wb")
}

data4 <- read.csv(destFile4)
data <- merge(data2, data4, by.x = "X", by.y = "CountryCode", sort=TRUE)

print("Quetion #4 solution:")
print(length( grep("Fiscal year end: June", data$Special.Notes)))

##========================================
## Question #5
##========================================
library(quantmod)
amzn = getSymbols("AMZN",auto.assign=FALSE)
sampleTimes = index(amzn)

year <- which(format(sampleTimes, "%y") == 12)
yearAndDay <- which(format(sampleTimes, "%a %y") == "Mon 12")
print("Quetion #4 solution:")
print(c(length(year), length(yearAndDay)))
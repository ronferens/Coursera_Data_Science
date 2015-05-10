setwd('C:/Users/rferens/Git/datasciencecoursera/Getting.and.Cleaning.Data/Quiz.03/')
destDir <- "./Data"
##========================================
## Helper Functions
##========================================


##========================================
## Question #1
##========================================
# if(!file.exists(destDir)) {
#   dir.create(destDir)
#   url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
#   destFile <- paste(destDir, sep="/", "dataset.csv")
#   download.file(url, dest=destFile, mode="wb")
# }
# 
# data <- read.csv(destFile)
# agricultureLogical <- which(with(data, data$ACR == 3 & data$AGS == 6))
# ans <- which(agricultureLogical)
# 
# ##========================================
# ## Question #2
# ##========================================
# library(jpeg)
# url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg "
# destFile <- paste(destDir, sep="/", "getdata2Fjeff.jpg")
# download.file(url, dest=destFile, mode="wb")
# jpgImg <- readJPEG(destFile, native = TRUE)
# quantile(jpgImg, probs = c(0.3, 0.8))

##========================================
## Question #3
##========================================
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
destFile <- paste(destDir, sep="/", "getdataFdata2FGDP.csv")
download.file(url, dest=destFile, mode="wb")
productData <- read.csv(destFile, header=F, skip=5, nrows=190)

url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv"
destFile <- paste(destDir, sep="/", "getdataFdataFEDSTATS_Country.csv")
download.file(url, dest=destFile, mode="wb")
educationalData <- read.csv(destFile)

data <- merge(productData, educationalData, by.x = "V1", by.y = "CountryCode", sort=TRUE)
data <- data[with(data, order(-V2)),]

##========================================
## Question #4
##========================================
# OECD
mean(data[data$Income.Group=='High income: OECD',]$V2)
# non OECD
mean(data[data$Income.Group=='High income: nonOECD',]$V2)

##========================================
## Question #5
##========================================
# assign quentile values
quantileVals <- quantile(combined$V2, seq(0.2,1.0,length.out = 5))
q1 <- data$V2 <= 38
xtabs(q1 ~ data$Income.Group)
xtabs(q1 ~ combined$Income.Group)
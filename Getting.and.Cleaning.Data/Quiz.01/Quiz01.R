## Getting and Cleaning Data - Quiz #1

setwd("C:\\Users\\rferens\\Git\\datasciencecoursera\\Getting.and.Cleaning.Data")
#data <- read.csv("getdata_data_ss06hid.csv")
#data <- read.table("getdata_data_ss06hid.csv", sep = ",", header=TRUE)

#------------------------------
# Question #01
#------------------------------
#sum(data$VAL>=24, na.rm = TRUE)

#------------------------------
# Question #02
#------------------------------
#Ans - Tidy data has one variable per column.

#------------------------------
# Question #03
#------------------------------
# library(xlsx)
# colIndex <- 7:15
# rowIndex <- 18:23
# dat <- read.xlsx("getdata_data_DATA.gov_NGAP.xlsx", sheetIndex = 1, colIndex=colIndex, rowIndex=rowIndex)
# ans <- sum(dat$Zip*dat$Ext,na.rm=T)

#------------------------------
# Question #04
#------------------------------
# library(XML)
# doc <- xmlTreeParse("getdata_data_restaurants.xml", useInternalNodes = TRUE)
# rootNode <- xmlRoot(doc)
# values <- xpathSApply(rootNode, "//zipcode", xmlValue)
# sum(values == "21231")

#------------------------------
# Question #05
#------------------------------
library(data.table)
DT <- fread("getdata_data_ss06pid.csv")

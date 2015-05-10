library(sqldf)

setwd("C:/Users/rferens/Git/datasciencecoursera/Getting.and.Cleaning.Data/Quiz.02")

localFile <- file.path(getwd(), "ss06pid.csv")
# fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv"
# download.file(fileUrl, localFile)

acs <- read.csv(localFile)

ans <- sqldf("select pwgtp1 from acs where AGEP < 50")


requiredResult <- unique(acs$AGEP)
query1 <- sqldf("select distinct AGEP from acs") ## Correct!
#query2 <- sqldf("select AGEP where unique from acs") ##Generates ERROR
query3 <- sqldf("select distinct pwgtp1 from acs") ## Wrong answer
#query4 <- sqldf("select unique * from acs") ## Generates ERROR
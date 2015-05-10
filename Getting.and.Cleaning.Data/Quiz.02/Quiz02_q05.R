setwd("C:/Users/rferens/Git/datasciencecoursera/Getting.and.Cleaning.Data/Quiz.02")

con <- url("https://d396qusza40orc.cloudfront.net/getdata%2Fwksst8110.for")
forCode <- readLines(con)
close(con)

sumVal <- 0
for(i in 1:length(forCode)) {
 num <- as.numeric(substr(forCode[i], 29, 32))
 if(!is.na(num)) {
   sumVal <- sumVal + num 
 }
}


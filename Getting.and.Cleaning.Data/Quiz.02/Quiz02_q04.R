setwd("C:/Users/rferens/Git/datasciencecoursera/Getting.and.Cleaning.Data/Quiz.02")

con <- url("http://biostat.jhsph.edu/~jleek/contact.html")
htmlCode <- readLines(con)
close(con)
ans <- c(nchar(htmlCode[10]), nchar(htmlCode[20]), nchar(htmlCode[30]), nchar(htmlCode[100]))

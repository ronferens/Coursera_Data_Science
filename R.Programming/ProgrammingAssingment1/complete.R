complete <- function(directory, id = 1:332) {
  ## 'directory' is a character vector of length 1 indicating
  ## the location of the CSV files
  
  ## 'id' is an integer vector indicating the monitor ID numbers
  ## to be used
  
  ## Return a data frame of the form:
  ## id nobs
  ## 1  117
  ## 2  1041
  ## ...
  ## where 'id' is the monitor ID number and 'nobs' is the
  ## number of complete cases
  
  orgCwd <- getwd()
  setwd(directory)
  filesList <- list.files(pattern = "[.]csv$")
  
  d <- data.frame()
  
  # Reading the files corresponding to the given IDs list
  for( fileIndex in id ) {
    fileName <- filesList[fileIndex]
    fileData <- read.csv(fileName)
    
    # Finding the number of complete cases in a file
    completeRes <- complete.cases(fileData)
    numOfCompleteRows = length(completeRes[completeRes==TRUE])
    
    # Appending result to data frame
    d <- rbind(d, c(fileIndex, numOfCompleteRows))
  }
  
  setwd(orgCwd)

  # Setting data frame columns' names
  names(d) <- c("id", "nobs")
  return(d)
}

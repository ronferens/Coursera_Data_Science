pollutantmean <- function(directory, pollutant, id = 1:332) {
  ## 'directory' is a character vector of length 1 indicating
  ## the location of the CSV files
  
  ## 'pollutant' is a character vector of length 1 indicating
  ## the name of the pollutant for which we will calculate the
  ## mean; either "sulfate" or "nitrate".
  
  ## 'id' is an integer vector indicating the monitor ID numbers
  ## to be used
  
  ## Return the mean of the pollutant across all monitors list
  ## in the 'id' vector (ignoring NA values)
  
  accumulatedData <-numeric()
  
  setwd(directory)
  filesList <- list.files(pattern = "[.]csv$")
  
  # Reading the files corresponding to the given IDs list
  for( monitorID in id ) {
    fileName <- filesList[monitorID]
    data <- read.csv(fileName)
    
    # Appending the requested pollutant data
    pollutantData <-data[[pollutant]]
    accumulatedData<-c(accumulatedData, pollutantData)
  }
  
  mean(accumulatedData, na.rm = TRUE)
}
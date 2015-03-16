corr <- function(directory, threshold = 0) {
  ## 'directory' is a character vector of length 1 indicating
  ## the location of the CSV files
  
  ## 'threshold' is a numeric vector of length 1 indicating the
  ## number of completely observed observations (on all
  ## variables) required to compute the correlation between
  ## nitrate and sulfate; the default is 0
  
  ## Return a numeric vector of correlations
  setwd(directory)
  filesList <- list.files(pattern = "[.]csv$")
  completeCases = complete(directory, 1:length(filesList))
  
  numOfCompleteCasees = completeCases[[2]]
  
  res <- rep(NA, length=length(filesList))
  
  # Reading the files corresponding to the given IDs list
  for( fileIndex in completeCases[[1]] ) {
    if(numOfCompleteCasees[fileIndex] > threshold) {
      fileName <- filesList[fileIndex]
      d <- read.csv(fileName)
      
      # Appending the requested pollutant data
      corRes <- cor(d[2], d[3], use = "complete.obs")
      res[fileIndex] = corRes
    }
  }
  
  res<-res[!is.na(res)]
  
  if(length(res) == 0) {
    res = 0;
  }
  
  return(res)
}
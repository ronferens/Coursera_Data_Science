best <- function(state, outcome) {
  ## Read outcome data
  ## Check that state and outcome are valid
  ## Return hospital name in that state with lowest 30-day death
  ## rate
  
  data <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
  
  # Retreiving the requested outcome
  if(outcome == "heart attack") {
    mortalityCol = which(colnames(data) == "Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack")
  } else if (outcome == "heart failure") {
    mortalityCol = which(colnames(data) == "Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure")
  } else if(outcome == "pneumonia") {
    mortalityCol = which(colnames(data) == "Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia")
  } else {
    stop("invalid outcome")
  }
  
  # Verfiying valid state argument
  if( !sum(data$State == state) ) {
    stop("invalid state")
  }
  
  
  match <- data[(data$State == state) & (data[,mortalityCol] != "Not Available"),]
  if(!nrow(match)) {
    stop("data unavailable")
  }
  
  # Calculating the lowest 30-day mortality
  d <- as.numeric(match[,mortalityCol])
  lowestMortality <- min(d)
  
  hospitalsIndexes <- as.numeric(match[,mortalityCol]) == lowestMortality
  res <- match$Hospital.Name[hospitalsIndexes]
  if(length(row) > 1) {
    # There are more than one hospital -> use alphabetical order
    sort(res)
  }
  
  return(res)
}
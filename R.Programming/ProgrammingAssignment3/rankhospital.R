rankhospital <- function(state, outcome, num = "best") {
  ## Read outcome data
  ## Check that state and outcome are valid
  ## Return hospital name in that state with the given rank
  ## 30-day death rate
  
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
  
  # Sorting by mortality (ascending) and than by hospital name (descending)
  match <- match[order(as.numeric(match[,mortalityCol]), match$Hospital.Name), ]
  
  if(num == "best") {
    res <- match$Hospital.Name[1]
  }else if(num == "worst") {
    res <- tail(match$Hospital.Name, 1)
  } else if((num < 1) || (num > nrow(match))) {
    return(NA)
  } else {
    res <- match$Hospital.Name[num]
  }
  
  return(res)
}
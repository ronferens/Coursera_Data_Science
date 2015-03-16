rankall <- function(outcome, num = "best") {
  ## Read outcome data
  ## Check that state and outcome are valid
  ## For each state, find the hospital of the given rank
  ## Return a data frame with the hospital names and the
  ## (abbreviated) state name
  
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
  
  # Creating the data frame according to the states vector
  states <- unique(sort(data$State))
  N <- length(states)
  res <- data.frame("hospital"=character(N), "state"=character(N),stringsAsFactors=FALSE)
  
  # Getting the requested rank for each state
  count <- 1
  for( state in states )
  {
    match <- data[(data$State == state) & (data[,mortalityCol] != "Not Available"),]
    if(!nrow(match)) {
      stop("data unavailable")
    }
    
    # Sorting by mortality (ascending) and than by hospital name (descending)
    match <- match[order(as.numeric(match[,mortalityCol]), match$Hospital.Name), ]
    
    if(num == "best") {
      hospital <- match$Hospital.Name[1]
    }else if(num == "worst") {
      hospital <- tail(match$Hospital.Name, 1)
    } else if((num < 1) || (num > nrow(match))) {
      hospital <- NA
    } else {
      hospital <- match$Hospital.Name[num]
    }
    
    res[count, ] <- c(hospital, state)
    count <- count + 1
  }
  
  return(res)
}
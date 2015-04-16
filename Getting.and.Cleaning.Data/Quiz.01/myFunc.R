myFunc <- function() {
  mean(DT[DT$SEX==1,]$pwgtp15)
  mean(DT[DT$SEX==2,]$pwgtp15)
}
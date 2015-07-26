# setwd("C:/Users/rferens/Git/datasciencecoursera/Reproducible.Research/Project.02/")
# dataDir <- "./Data"
# destFileZip <- paste(dataDir, sep="/", "repdata-data-StormData.csv.bz2")
# 
# if(!file.exists(destFileZip)) {
#   url <- "https://d396qusza40orc.cloudfront.net/repdata%2Fdata%2FStormData.csv.bz2"
#   download.file(url, dest=destFileZip, mode="wb")
# }
# 
# stormData <- read.csv(destFileZip)
names(stormData)

#***********************************************************
sortEvntTypeByColumn <- function(dataset, colName, threhold) {
  colIndex <-  which(colnames(dataset) == colName)
  aggData <- aggregate(dataset[,colIndex], by=list(dataset$EVTYPE), sum, na.rm=TRUE)
  colnames(aggData) <- c("EVTYPE", colName)
  aggData <- aggData[order(aggData[[colName]], decreasing = T),]
  return(aggData[1:threhold,])
}

evntByFatalities <- sortEvntTypeByColumn(stormData, "FATALITIES", 10)
evntByInjuries <- sortEvntTypeByColumn(stormData, "INJURIES", 10)

library(ggplot2)
library(gridExtra)
evntByFatalitiesPlot <- ggplot( data = evntByFatalities,
                                aes(x=reorder(EVTYPE, -FATALITIES), y=FATALITIES, fill=FATALITIES)) +
  geom_bar(stat="identity") +
  labs(x="Event Type", y="Total Fatalities", title="Total Fatalities By Event Type") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

evntByInjuriesPlot <- ggplot(data = evntByInjuries,
                                aes(x=reorder(EVTYPE, -INJURIES), y=INJURIES, fill=INJURIES)) +
  geom_bar(stat="identity") +
  labs(x="Event Type", y="Total Injuries", title="Total Injuries By Event Type") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

grid.arrange(evntByFatalitiesPlot, evntByInjuriesPlot, ncol=2, nrow=1)

#***********************************************************
damageEstimation <- function(damageValue, damageMagnitude) {
  if(damageMagnitude %in% c('h','H'))
    damageEstimation <- damageValue * (10 ** 2)
  else if(damageMagnitude == 'K')
    damageEstimation <- damageValue * (10 ** 3)
  else if(damageMagnitude %in% c('m','M'))
    damageEstimation <- damageValue * (10 ** 6)
  else if(damageMagnitude == 'B')
    damageEstimation <- damageValue * (10 ** 9)
  else
    damageEstimation <- damageValue
  return(damageEstimation)
}

stormData$PROPDMG_VAL <- mapply(damageEstimation, stormData$PROPDMG, stormData$PROPDMGEXP)
evntByPropDmg <- sortEvntTypeByColumn(stormData, "PROPDMG_VAL", 10)

stormData$CROPDMG_VAL <- mapply(damageEstimation, stormData$CROPDMG, stormData$CROPDMGEXP)
evntByCropDmg <- sortEvntTypeByColumn(stormData, "CROPDMG_VAL", 10)

evntByPropDmgPlot <- ggplot(data = evntByPropDmg,
                            aes(x=reorder(EVTYPE, -PROPDMG_VAL), y=PROPDMG_VAL, fill=PROPDMG_VAL)) +
  geom_bar(stat="identity") +
  labs(x="Event Type", y="Total Property-Damage Estimation [USD]", title="Total Property-Damage Estimation\nBy Event Type") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1), legend.position="none")

evntByCropDmgPlot <- ggplot(data = evntByCropDmg,
                            aes(x=reorder(EVTYPE, -CROPDMG_VAL), y=CROPDMG_VAL, fill=CROPDMG_VAL)) +
  geom_bar(stat="identity") +
  labs(x="Event Type", y="Total Crop-Damage Estimation [USD]", title="Total Crop-Damage Estimation\nBy Event Type") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1), legend.position="none")

grid.arrange(evntByPropDmgPlot, evntByCropDmgPlot, ncol=2, nrow=1)
setwd('C:/Users/rferens/Git/datasciencecoursera/Getting.and.Cleaning.Data/Project')

##========================================
## Helper Functions
##========================================
GetDataSetandLabels <- function (dataSetDir, subDir) {
  path <- sprintf("%s/%s/X_%s.txt", dataSetDir, subDir, subDir)
  set <- read.table(path)

  # Loading subjects' data
  path <- sprintf("%s/%s/subject_%s.txt", dataSetDir, subDir, subDir)
  subjects <- read.table(path)
  names(subjects) <- "subjects"

  # Loading labels' data
  path <- sprintf("%s/%s/Y_%s.txt", dataSetDir, subDir, subDir)
  labels <- read.table(path)
  names(labels) <- "activities"

  # Merging the three table into single one
  dataSet <- cbind(set, subjects, labels)
}

##========================================
## 0. Getting the input data
##========================================
destDir <- "./Data"

if(!file.exists(destDir)) {
  # Creating the "Data" folder
  dir.create(destDir)
  
  # Downloading and extracting the data set zip file
  url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  destZipFile <-paste(destDir, sep="/", "dataset.zip")
  download.file(url, dest=destZipFile, mode="wb")
  unzip(destZipFile, exdir=destDir)
}

dataSetDir <- paste(destDir, sep="/", "UCI HAR Dataset")


##========================================
## 1. Merges the training and the test
##    sets to create one data set
##========================================
trainSet <- GetDataSetandLabels(dataSetDir, "train")
testSet <- GetDataSetandLabels(dataSetDir, "test")
completeData <- rbind(trainSet, testSet)

##========================================
## 2. Extracts only the measurements on
##    the mean and standard deviation for
##    each measurement
##========================================
features <- read.table(sprintf("%s/features.txt", dataSetDir))
meanAndStdSubset <- subset(features, grepl("mean()", features$V2) | grepl("std()", features$V2))
meanAndStdkeys <- paste0("V", meanAndStdSubset$V1)
data <- completeData[,meanAndStdkeys]

# Addind the subjects and activities' names columns to the retrieved data
dataNames <- names(data)
dataNames <- factor(append(as.character(dataNames), c("subjects", "activities")))
data <- cbind(data, completeData$subjects, completeData$activities)
names(data) <- dataNames


# Creating a vector of names for the retrieved data 
meanAndStdNames <- meanAndStdSubset$V2
meanAndStdNames <- factor(append(as.character(meanAndStdNames), c("subjects", "activities")))

##========================================
## 3. Uses descriptive activity names to
##    name the activities in the data set
##========================================
activityNames <- read.table(sprintf("%s/activity_labels.txt", dataSetDir))
data$activities <-activityNames$V2[data$activities]

##========================================
## 4. Appropriately labels the data set
##    with descriptive variable names
##========================================
names(data)<-meanAndStdNames

##========================================
## 5. From the data set in step 4,
##    creates a second, independent tidy
##    data set with the average of each
##    variable for each activity and each
##    subject
##========================================
# Get the toatl number of subjects and activities
subjects <- sort(unique(data$subjects))
activities <- sort(unique(data$activities))

# Create the new tidy data frame
newData <- data.frame(matrix(NA, nrow = (length(subjects) * length(activities)), ncol=ncol(data)))
names(newData) <- names(data)
indx <- 1
                      
for(subject in subjects){
  for(activity in activities){
    tmpData <- subset(data, (data$subjects == subject) & (data$activities == activity))
    meanValues <- apply(tmpData[1:(length(tmpData)-2)], 2, mean)
    newData[indx, ] <- c(meanValues, subject, activity)
    indx <- indx + 1
  }
}

# Writing new tidy data set to output file - "tidyData.txt"
write.table(newData, file="tidyData.txt", row.names=FALSE)
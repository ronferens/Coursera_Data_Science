# Getting and Cleaning Data
# Course Project - README File

##Setup
The run_analysis.R script "assumes" that the **UCI HAR Dataset** data set is located in the same working directory (with the script)
and is located under a folder named "Data".
Note: If a folder named "Data" is already exist, the UCI repository will not be downloaded by the script!

##Running the script
This file describe how to run the run_analysis.R script:
1. Update your working directory in **setwd()** command in the first line of the script.
2. Please make sure to remove (or rename) a folder named "Data", in case it already exist.
	Note: in case you don't want to re-download the *UCI HAR Dataset*, please comment out lines  29-38.
3. Run the **run_analysis.R** script.
4. Once the script is done, a new output file will be created named - **tidyData.txt**.
	This is the tidy processed data set with the average of each variable for each activity and each subject.
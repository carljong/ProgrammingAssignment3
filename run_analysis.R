library(reshape2)


datazipname <- "getdataset.zip"

## Download, create the data:
if (!file.exists(datazipname)){
      fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip "
      download.file(fileURL, datazipname, method="curl")
    }
if (!file.exists("UCI HAR Dataset")) {
      unzip(datazipname)
    }




# Load activity labels + features
activitylbls <- read.table("UCI HAR Dataset/activity_labels.txt")
activitylbls[,2] <- as.character(activitylbls[,2])
myfeatures <- read.table("UCI HAR Dataset/features.txt")
myfeatures[,2] <- as.character(myfeatures[,2])
  
# Get only mean and standard deviation
featuresub <- grep(".*mean.*|.*std.*", myfeatures[,2])
featuresub.names <- myfeatures[featuresub,2]
featuresub.names <- gsub('-mean', 'Mean', featuresub.names)
featuresub.names <- gsub('-std', 'Std', featuresub.names)
featuresub.names <- gsub('[-()]', '', featuresub.names)
    
      
# Load the datasets
train <- read.table("UCI HAR Dataset/train/X_train.txt")[featuresub]
trainactivity <- read.table("UCI HAR Dataset/train/Y_train.txt")
trainsubject <- read.table("UCI HAR Dataset/train/subject_train.txt")
train <- cbind(trainsubject, trainactivity, train)
      
test <- read.table("UCI HAR Dataset/test/X_test.txt")[featuresub]
testactivity <- read.table("UCI HAR Dataset/test/Y_test.txt")
testsubject <- read.table("UCI HAR Dataset/test/subject_test.txt")
test <- cbind(testsubject, testactivity, test)
        
# combine data and put labels
allData <- rbind(train, test)
colnames(allData) <- c("subject", "activity", featuresub.names)
          
# make activity, subjects into factors
allData$activity <- factor(allData$activity, levels = activitylbls[,1], labels = activitylbls[,2])
allData$subject <- as.factor(allData$subject)
            
allDatamelt <- melt(allData, id = c("subject", "activity"))
allDatamean <- dcast(allDatamelt, subject + activity ~ variable, mean)
              
write.table(allDatamean, "tidy.txt", row.names = FALSE, quote = FALSE) 
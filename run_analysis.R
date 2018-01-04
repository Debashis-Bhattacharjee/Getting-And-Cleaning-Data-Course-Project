library(plyr)

## setting the base path of the files
setwd(
  "C:/Users/A611558/Work/Data Science/Coursera/Getting and Cleaning Data/Week4/Assignments/UCI HAR Dataset"
)

## Read the activity test and training files

dataActivityTest  <-
  read.table("./test/Y_test.txt" , header = FALSE)
dataActivityTrain <-
  read.table("./train/Y_train.txt", header = FALSE)


## Read the subject  test and training files

dataSubjectTrain <-
  read.table("./train/subject_train.txt", header = FALSE)
dataSubjectTest  <-
  read.table("./test/subject_test.txt", header = FALSE)

## Read the features  test and training files

dataFeaturesTest  <- read.table("./test/X_test.txt", header = FALSE)
dataFeaturesTrain <-
  read.table("./train/X_train.txt", header = FALSE)


## merge all subject , training and features files

dataSubject <- rbind(dataSubjectTrain, dataSubjectTest)
dataActivity <- rbind(dataActivityTrain, dataActivityTest)
dataFeatures <- rbind(dataFeaturesTrain, dataFeaturesTest)

## change the names 

names(dataSubject) <- c("subject")
names(dataActivity) <- c("activity")
dataFeaturesNames <- read.table("./features.txt", head = FALSE)
names(dataFeatures) <- dataFeaturesNames$V2

dataCombine <- cbind(dataSubject, dataActivity)
Data <- cbind(dataFeatures, dataCombine)


## we need only the mean and sd
subdataFeaturesNames <-
  dataFeaturesNames$V2[grep("mean\\(\\)|std\\(\\)", dataFeaturesNames$V2)]
selectedNames <-
  c(as.character(subdataFeaturesNames), "subject", "activity")
Data <- subset(Data, select = selectedNames)

## get the description of activities
activityLabels <- read.table("activity_labels.txt", header = FALSE)
activityLabels[, 2] <- as.character(activityLabels[, 2])

## factor the activity description
Data$activity <-
  factor(Data$activity, levels = activityLabels[, 1], labels = activityLabels[, 2])

## replace with meaningful descriptions

names(Data) <- gsub("^t", "time", names(Data))
names(Data) <- gsub("^f", "frequency", names(Data))
names(Data) <- gsub("Acc", "Accelerometer", names(Data))
names(Data) <- gsub("Gyro", "Gyroscope", names(Data))
names(Data) <- gsub("Mag", "Magnitude", names(Data))
names(Data) <- gsub("BodyBody", "Body", names(Data))


Data2 <- aggregate(. ~ subject + activity, Data, mean)
Data2 <- Data2[order(Data2$subject, Data2$activity), ]
write.table(Data2, file = "./tidydata.txt", row.name = FALSE)

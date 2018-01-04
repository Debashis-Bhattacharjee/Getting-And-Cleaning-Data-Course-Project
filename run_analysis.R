library(plyr)


## Read the activity test and training files

dataActivityTest  <-
  read.table("./UCI HAR Dataset/test/Y_test.txt" , header = FALSE)
dataActivityTrain <-
  read.table("./UCI HAR Dataset/train/Y_train.txt", header = FALSE)


## Read the subject  test and training files

dataSubjectTrain <-
  read.table("./UCI HAR Dataset/train/subject_train.txt", header = FALSE)
dataSubjectTest  <-
  read.table("./UCI HAR Dataset/test/subject_test.txt", header = FALSE)

## Read the features  test and training files

dataFeaturesTest  <- read.table("./UCI HAR Dataset/test/X_test.txt", header = FALSE)
dataFeaturesTrain <-
  read.table("./UCI HAR Dataset/train/X_train.txt", header = FALSE)


## merge all subject , training and features files

dataSubject <- rbind(dataSubjectTrain, dataSubjectTest)
dataActivity <- rbind(dataActivityTrain, dataActivityTest)
dataFeatures <- rbind(dataFeaturesTrain, dataFeaturesTest)

## change the names 

names(dataSubject) <- c("subject")
names(dataActivity) <- c("activity")
dataFeaturesNames <- read.table("./UCI HAR Dataset/features.txt", head = FALSE)
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
activityLabels <- read.table("./UCI HAR Dataset/activity_labels.txt", header = FALSE)
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


DataAggregrate <- aggregate(. ~ subject + activity, Data, mean)
DataAggregrate <- DataAggregrate[order(DataAggregrate$subject, DataAggregrate$activity), ]
write.table(DataAggregrate, file = "./tidydata.txt", row.name = FALSE)

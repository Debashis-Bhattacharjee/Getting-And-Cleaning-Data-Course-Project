## Description
The script `run_analysis.R` performs the following

- Merges the training and the test sets to create one data set.
- Extracts only the measurements on the mean and standard deviation for each measurement.
- Uses descriptive activity names to name the activities in the data set
- Appropriately labels the data set with descriptive variable names.
- From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

## Variables


- `dataActivityTest` variable to hold the test data for Activity
- `dataActivityTrain` variable to hold the training data for Activity
- `dataSubjectTrain` variable to hold the test data for Subject
- `dataSubjectTest` variable to hold the training data for Subject
- `dataFeaturesTest` variable to hold the test data for Features
- `dataFeaturesTrain` variable to hold the training data for Features
- `dataSubject`  variable to hold the merged training and test subject data
- `dataActivity` variable to hold the merged training and test activity data
- `dataFeatures` variable to hold the merged training and test feature data
- `subdataFeaturesNames` contains only the features for mean and standard deviation
- `activityLabels` descriptive activity names from “activity_labels.tx
- `Data` variable holding the concatenated subject and activity data
- `DataAggregrate` independent tidy data set with the average of each variable for each activity and each subject.
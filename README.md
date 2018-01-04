# Getting and Cleaning Data Course Project
## Input Data Sets
The dataset includes the following files:

- `features_info.txt`: Shows information about the variables used on the feature vector.

- `features.txt`: List of all features.

- `activity_labels.txt`: Links the class labels with their activity name.

- `train/X_train.txt`: Training set.

- `train/y_train.txt`: Training labels.

- `test/X_test.txt`: Test set.

- `test/y_test.txt`: Test labels.

The following files are available for the train and test data. Their descriptions are equivalent. 

- `train/subject_train.txt`: Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 

## Output Data Sets

- tidydata.txt

## Program 

**run_analysis.R**
The program reads the  input datasets and merges the data with a meaningful description and also creates 
independent tidy data set with the average of each variable for each activity and each subject.

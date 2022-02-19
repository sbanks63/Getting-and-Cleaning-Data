# Getting and Cleaning Data

## Create a Tidy Dataset

Prepare tidy data that can be used for later analysis, thereby demonstrating the ability to collect, work with, and clean a data set.

**Obtain the Data:**

Information about the raw data can be found here: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

A link to the raw data: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip


**Raw Data Description:**

Data were collected from a group of 30 volunteers, age 19-48. Each person performed 6 activities (walking, walking upstairs, walking downstairs, sitting, standing and laying).  During the experiment, 3-axial linear acceleration and 3-axial angular velocity data were captured using the accelerometer and gyroscope of the Samsung Galaxy S smartphone worn at the waste of each participant. The obtained dataset was randomly partitioned into two sets, where 70% of the volunteers were selected for generating the training data and 30% the test data.


The data are comprised of a series of text files:

- A file containing the activity categories

- A file of feature names

- Files for the "test" group including:
  - A file indicating the subject identifiers.
  - A file indicating the activity performed.
  - A 561-feature vector file with time and frequency domain variables.
  - 9 Inertial Signal files (not included in the project since they do not contain the mean and standard deviation measurements needed for the final data set)

- Files for the "train" group including:
  - A file indicating the subject identifiers.
  - A file indicating the activity performed.
  - A 561-feature vector file with time and frequency domain variables.
  - 9 Inertial Signal files (not included in the project since they do not contain the mean and standard deviation measurements needed for the final data set)


**Process the Data:**

- Merge the training and the test sets to create one data set.
- Appropriately label the data set with descriptive variable names.
- Use descriptive activity names to name the activities in the data set.
- Extract only the measurements on the mean and standard deviation for each measurement.
- Create a second, independent tidy data set with the average of each variable for each activity and each subject.

More information about the data processing: **"CodeBook.Rmd"**

The final script: **"run_analysis.R"**

**The Final Dataset:**

The final dataset is comprised of 59 variables (subject, activity, and 57 features), and 180 observations.  All columns are descriptively named, as are all activities.  Each observation corresponds to the mean of the mean and standard deviation measurements from the original datasets.  The observations are grouped by subject and activity.  There are 6 observations per subject (1-30), each corresponding to one activity (e.g. walking, walking upstairs, walking downstairs, sitting, standing and laying).  

The final data set: **"final_dataset.txt"**

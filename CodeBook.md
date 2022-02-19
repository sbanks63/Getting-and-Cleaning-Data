# Code Book - Getting and Cleaning Data

## Project Description
Prepare a tidy dataset from accelerometer data that can be used for later analysis

## Study Design 

Data were collected from a group of 30 volunteers, age 19-48. Each person performed 6 activities (walking, walking upstairs, walking downstairs, sitting, standing and laying).  During the experiment, 3-axial linear acceleration and 3-axial angular velocity data were captured using the accelerometer and gyroscope of the Samsung Galaxy S smartphone worn at the waste of each participant. The obtained dataset was randomly partitioned into two sets, where 70% of the volunteers were selected for generating the training data and 30% the test data. A full description is available at the site where the data were obtained:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

Link to the data for the project:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip  
 
 
### The Raw Data
The raw data consist of the following:

- "features.txt" 
  - Time and frequency domain variables
  
- "activity_labels.txt"
  - Descriptive activity names
  
- "X_test.txt"
  - Measurements for the "test" sets
  
- "y_test.text"
  - Activity designations for the "test" sets
  
- "subject_test.txt"
  - Subject number for the "test" sets
  
- "X_train.txt"
  - Measurements for the "train" sets
  
- "y_train.text"
  - Activity designations for the "train" sets
  
- "subject_train.txt"
  - Subject number for the "train" sets
  
  
### Additional Raw Data Notes 
The raw data also contain Intertial Signals for both test and training sets. These data were not included in the project since they did not contain the mean and standard deviation data required for the final tidy dataset.

The "features_info.txt" and "README.txt" files included with the raw dataset provide more information about the data.


## The Tidy Dataset

### Creating the Primary Tidy Dataset

The files were downloaded from the source and read into R in the following tables:

| Dataframe | Source | Dim | Notes |
|:--------:|:------:|:---:|:------|
| activities | "activity_labels.txt" | 6, 2 | contains a number column that matches the label files and a column with a corresponding descriptive activity name
| features | "features.txt" | 561, 2 | contains a number column and a feature column
| labels_test | "y_test.text" | 2947, 1 | activity designation (test set) |
| labels_train | "y_train.text" | 7352, 1 | activity designation (train set) |
| set_test | "X_test.txt" | 2947, 1 | set data (test set) |
| set_train | "X_train.txt" | 7352, 1 set data (train set) |
| subject_test | "subject_test.txt" | 2947, 1 | subject designations (test set) |
| subject_train | "subject_train.txt" | 7352, 1 | subject designations (train set) |

The observations in the feature column of the features table were cleaned to remove reserved characters.
The features table was used for the column names of the set_test and set_train tables.

The label, set and subject tables were combined into the following tables:

| Dataframe | Source | Dim |
|:--------:|:------:|:---:|
| all_labels | labels_test & labels_train | 10299, 1 |
| all_sets | set_test & set_train | 10299, 561 |
| all_subjects | subject_test & subject_train | 10299, 1 |

The activity designation numbers in the all_labels table were replaced with their corresponding descriptive names from the activities table.

all_subjects, all_labels and all_sets were combined into one data set called **all_data** (dim: 10299, 563) with the following variables:

* *subject* (integer): the subject's designated number
* *activity* (character): the name of the activity performed
* 561 time and frequency domain variables (numeric): corresponding to the activity performed


### Creating the Secondary Tidy Dataset

The 57 time and frequency domain variables corresponding to mean and standard deviation measurements were extracted from the all_data dataset for each subject and activity.

| Dataframe | Source | Dim |
|:--------:|:------:|:---:|
| mean_sd_data | all_data | 10299, 59 |


* Note: only the straight means and standard deviations were included in the dataset (i.e. those variables ending in mean() or std().  Other variables containing "mean" (i.e. gravityMean or meanFreq()) were not included.


A new table (**sub_act_means**) was created with the averages of each mean and standard deviation measurement for each subject and activity.

| Dataframe | Source | Dim |
|:--------:|:------:|:---:|
| sub_act_means | mean_sd_data | 180, 59 |

Variables:

* *subject* (integer): the subject's designated number
* *activity* (character): the activity performed
* 57 mean variables (numeric): means of the selected time and frequency domain variables

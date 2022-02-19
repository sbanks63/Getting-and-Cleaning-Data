## load libraries
library(dplyr)

## Assumes that the data has been downloaded locally

## Read in the activity_labels.txt into R
## Use the col.names property to assign readable variable names.  "num" indicates the number designation of the activity.  "activity" is the descriptive name of the activity.

activities <- read.csv("UCI HAR Dataset/activity_labels.txt", sep = " ", header = FALSE, col.names = c("num","activity"))


## Read the "features.txt" file into R
## Use the col.names property to assign readable variable names.  "num" is the number of the feature.  "feature" is the descriptive name of the feature.

features <- read.csv("UCI HAR Dataset/features.txt", sep = " ", header = FALSE, col.names = c("num","feature"))

## Clean up the features data by removing the "(", ")", "-", "." and ","
features$feature <- gsub("\\(\\)", "", features$feature)
features$feature <- gsub("\\-", "_", features$feature)
features$feature <- gsub("\\(", "_", features$feature)
features$feature <- gsub("\\,", "_", features$feature)
features$feature <- gsub("\\)", "", features$feature)


## Read the set data into R
## The set data is in fixed width format (width = 16), so use read.fwf()
## The data README file specifies 561 features (columns) in the set data
## Use the col.names property to assign the feature names (from the features table) as the column names.

set_train <- read.fwf("UCI HAR Dataset/train/X_train.txt", widths = rep(16,561), header = FALSE, col.names = features$feature)

set_test <- read.fwf("UCI HAR Dataset/test/X_test.txt", widths = rep(16,561), header = FALSE, col.names = features$feature)


## Read the "subject_train.txt", "subject_test.txt", "y_train.txt" and "y_test.txt" files into R
## Use the col.names property to assign readable variable names. "subject" indicates the subject's designated number. "activity" indicates the designate activity number.

subject_train <- read.csv("UCI HAR Dataset/train/subject_train.txt", header = FALSE, col.names = "subject")
subject_test <- read.csv("UCI HAR Dataset/test/subject_test.txt", header = FALSE, col.names = "subject")

labels_train <-  read.csv("UCI HAR Dataset/train/y_train.txt", header = FALSE, col.names = "activity")
labels_test <- read.csv("UCI HAR Dataset/test/y_test.txt", header = FALSE, col.names = "activity")


## Combine data sets into one dataframe

all_sets <- rbind(set_test, set_train)
all_subjects <- rbind(subject_test, subject_train)
all_labels <- rbind(labels_test,labels_train)


## Rename activities
## Create a function that loops through all_labels and replaces the numbers with the corresponding activity name

replaceLabels <- function(activities, labels) {
  
  x <- 1 ## Count variable
  returnLabels <- vector()  # vector to store activities corresponding to the label numbers
  
  ## Loop through 
  for (x in 1:nrow(labels)){
    y <- 1
    
    for (y in 1:nrow(activities)){
      if (labels$activity[x] == activities$num[y]){
        returnLabels <- c(returnLabels, activities$activity[y])
      }
    }
  }
  
  returnLabels
}


## Call the replaceLabels() function to replace the labels in all_labels
all_labels$activity <- replaceLabels(activities, all_labels)


## Combine subjects, activities and sets into a single data frame
all_data <- cbind(all_subjects, all_labels, all_sets)

## Order all_data by subject number
all_data <- arrange(all_data, subject)


## Extract mean and standard deviation measurements
## meanFreq() and gravityMean not included

mean_sd_data <- select(all_data, 1:2, grep("_mean_", names(all_data))|grep("_std", names(all_data)))


## Create a table of the means of each variable grouped by subject and activity

sub_act_means <- mean_sd_data %>% group_by(subject, activity) %>% summarize_at(.vars = names(mean_sd_data[3:57]), .funs = mean)


## Save tidy dataset to a file
write.table(sub_act_means, "final_dataset.txt", row.name = FALSE)

# Getting and Cleaning Data Course Project

This repository is the result of Getting and Cleaning Data Course Project, the third course in Coursera's Data Science Specialization, provided by Johns Hopkins University. Here you will find all the instructions for completing the task.

## Instructions

The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis. You will be graded by your peers on a series of yes/no questions related to the project. You will be required to submit: 1) a tidy data set as described below, 2) a link to a Github repository with your script for performing the analysis, and 3) a code book that describes the variables, the data, and any transformations or work that you performed to clean up the data called CodeBook.md. You should also include a README.md in the repo with your scripts. This repo explains how all of the scripts work and how they are connected.

One of the most exciting areas in all of data science right now is wearable computing - see for example this article . Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Here are the data for the project:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

You should create one R script called run_analysis.R that does the following.

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names.
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
Good luck!

## Review criteria

1. The submitted data set is tidy.
2. The Github repo contains the required scripts.
3. GitHub contains a code book that modifies and updates the available codebooks with the data to indicate all the variables and summaries calculated, along with units, and any other relevant information.
4. The README that explains the analysis files is clear and understandable.
5. The work submitted for this project is the work of the student who submitted it.

## Code

Library dplyr added for the last trasformation with group_by, summarise_each and the pipe operator.
```R
  library(dplyr)
```

A simple call to read.table transforms the data in the txt files into data frames.
With no need to use X_test.txt and X_train.txt separately, we save space with only one data frame.
```R
# 1.Merges the training and the test sets to create one data set.
joint_data <- rbind(read.table("UCI HAR Dataset//test//X_test.txt"),
                    read.table("UCI HAR Dataset//train//X_train.txt"))
```

features.txt is read to select and extract the columns of interest.
```R
# 2.Extracts only the measurements on the mean and standard deviation for each 
# measurement.
features <- as.character(read.table("UCI HAR Dataset//features.txt")[, 2])
indexes <- grepl("mean|std", features)
joint_data <- joint_data[, indexes]
```

Columns activity and subject are read. The identication for activity is changed for the descriptive name available in activity_labels.txt.
```R
# 3.Uses descriptive activity names to name the activities in the data set
activity <- rbind(read.table("UCI HAR Dataset//test//y_test.txt"),
                  read.table("UCI HAR Dataset//train//y_train.txt"))
activity_labels <- read.table("UCI HAR Dataset//activity_labels.txt")
activity <- activity_labels$V2[activity$V1]
subject <- rbind(read.table("UCI HAR Dataset//test//subject_test.txt"),
                 read.table("UCI HAR Dataset//train//subject_train.txt"))
```

features was saved before and now is used to label the variables in the data frame.
```R
# 4.Appropriately labels the data set with descriptive variable names.
joint_data <- cbind(subject, activity, joint_data)
names(joint_data) <- c("subject", "activity", features[indexes])
```

Now we use the loaded dplyr package, solving a relatively large task in one line of code.
```R
# 5.From the data set in step 4, creates a second, independent tidy data set
# with the average of each variable for each activity and each subject.
tidy_data_set <- joint_data %>% 
  group_by(subject, activity) %>% 
  summarise_each(funs(mean))
```

The instructions were very specific about the output for this code: "a txt file created with write.table() using row.name=FALSE".
```R
# Export tidy_data_set as a txt file
write.table(tidy_data_set, "tidy_data_set.txt", row.name = FALSE)
```

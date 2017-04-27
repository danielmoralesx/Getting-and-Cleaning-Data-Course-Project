# The Data - Human Activity Recognition Using Smartphones Data Set 

See http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones. A detailed description can be found in README.txt, within the data set, available in https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip.

# Transformations Performed

Assuming the data is downloaded and extracted, you will have the folder "UCI HAR Dataset". The steps to obtain the dataset in tidy_data_set.txt are:

1. Merge the tables in test/X_test.txt and train/X_train.txt to get a data frame with 10299 rows and 561 columns.
2. Extract the columns corresponding to means or standart deviations.
3. Add the column subject, an ID for each subject in the research, from the files test/subject_test.txt and train/subject_train.txt.
4. Add the column activity, identifying wich activity the data in the row corresponds to, from the files test/y_test.txt and train/y_train.txt.
5. Label all columns appropriately, with features.txt
6. Use this organized data to create a data frame with the average of each variable for each activity and each subject.

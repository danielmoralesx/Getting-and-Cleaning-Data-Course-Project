library(dplyr)

# 1.Merges the training and the test sets to create one data set.
joint_data <- rbind(read.table("UCI HAR Dataset//test//X_test.txt"),
                    read.table("UCI HAR Dataset//train//X_train.txt"))

# 2.Extracts only the measurements on the mean and standard deviation for each 
# measurement.
features <- as.character(read.table("UCI HAR Dataset//features.txt")[, 2])
indexes <- grepl("mean|std", features)
joint_data <- joint_data[, indexes]

# 3.Uses descriptive activity names to name the activities in the data set
activity <- rbind(read.table("UCI HAR Dataset//test//y_test.txt"),
                  read.table("UCI HAR Dataset//train//y_train.txt"))
activity_labels <- read.table("UCI HAR Dataset//activity_labels.txt")
activity <- activity_labels$V2[activity$V1]
subject <- rbind(read.table("UCI HAR Dataset//test//subject_test.txt"),
                 read.table("UCI HAR Dataset//train//subject_train.txt"))

# 4.Appropriately labels the data set with descriptive variable names.
joint_data <- cbind(subject, activity, joint_data)
names(joint_data) <- c("subject", "activity", features[indexes])

# From the data set in step 4, creates a second, independent tidy data set with 
# the average of each variable for each activity and each subject.
tidy_data_set <- joint_data %>% 
  group_by(subject, activity) %>% 
  summarise_each(funs(mean))

# Export tidy_data_set as a txt file
write.table(tidy_data_set, "tidy_data_set.txt", row.name = FALSE)

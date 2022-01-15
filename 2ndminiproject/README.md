# Mini Project: Run Analysis

The full description of the data set is from:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Also, you can download the data here:
https://archive.ics.uci.edu/ml/machine-learning-databases/00240/UCI%20HAR%20Dataset.zip

## About the Project
The objective of the Run Analysis Mini Project is to clean and extract data from a larger dataset, which is the Human Activity Recognition Using Smartphones. Therefore, this project does the following:
* 	Merges the training and the test sets to create one data set.
* 	Extracts only the measurements on the mean and standard deviation for each measurement
* 	Uses descriptive activity names to name the activities in the dataset.
* 	Appropriately labels the dataset with descriptive variable names.
* 	Create a second, independent tidy data set with the average of each variable for each activity and each subject. 

### In this project, you will find:
* 	R script called run_analysis.R that runs the code on the data set
* 	README.md file that explains the code in run_analysis.R

## Procedure

### Library Used
    library("data.table")
   The library used in this project is *data.table* since it is efficient in dealing with large data.

### Read the data
    #test
    subject_test <- read.table("test/subject_test.txt", header = FALSE)
    x_test <- read.table("test/X_test.txt", header = FALSE)
    y_test <- read.table("test/Y_test.txt", header = FALSE)

    #training
    subject_train <- read.table("train/subject_train.txt", header = FALSE)
    x_train <- read.table("train/X_train.txt", header = FALSE)
    y_train <- read.table("train/y_train.txt", header = FALSE)
   Both test and train data sets are classified into three files: *subject, x, and y*. The *read.table function* reads these files into data frame in table format.

### Combine the data
    subject <- rbind(subject_test, subject_train)
    features <- rbind(x_test, x_train)
    activity <- rbind(y_test, y_train)
   The files of these two data sets are combined using *rbind* and the results are stored in *subject, features, and utilities*.

### Change the header
    colnames(subject) <- "Subject"
    feature_names <- read.table("features.txt", header = FALSE)
    colnames(features) <- feature_names[,2]
    colnames(activity) <- "Activity"
   Column names are specified through the *colnames* function. 

### 1. Merges the training and test tests to create one data set
    merged_data <- cbind(subject, activity, features)
   The data in subject, activity, and features are merged together and merged data is stored in *merged_data*.

### 2. Extracts only the measurements on the mean and standard deviation for each measurement
    extracted_names <- grepl("mean|std", feature_names[,2])
    extracted_data <- cbind(subject, activity, features[, extracted_names])
   The grepl function searches for matches of mean or standard deviation in the features set and the result is stored in *extracted_names*. Extracted names from the features set is then combined with the subject and activity sets. Now, the combined data are stored in *extracted_data*.

### 3. Uses descriptive activity names to name the activities in the dataset
    activity_labels <- read.table("activity_labels.txt", header = FALSE)
    activity_in_labels <- activity_labels[extracted_data$Activity, 2]
    extracted_data$Activity <- activity_in_labels
   First, read the data from the *activity_labels.txt* and store it in *activity_labels*. Second, extract the data from the selected column and row of *activity_labels* and store the result in *activity_in_labels*. Lastly, the activity labels are assigned to the Activity set from the extracted data.

### 4. Appropriately labels the dataset with descriptive variable names
    names(extracted_data) <- gsub("Acc", "Accelerometer", names(extracted_data))
    names(extracted_data) <- gsub("Gyro", "Gyroscope", names(extracted_data))
    names(extracted_data) <- gsub("BodyBody", "Body", names(extracted_data))
    names(extracted_data) <- gsub("Mag", "Magnitude", names(extracted_data))
    names(extracted_data) <- gsub("^t", "Time", names(extracted_data))
    names(extracted_data) <- gsub("^f", "Frequency", names(extracted_data))
    names(extracted_data) <- gsub("tBody", "Time Body", names(extracted_data))
    names(extracted_data) <- gsub("fBody", "Frame Body", names(extracted_data))
    names(extracted_data) <- gsub("-mean()", "Mean", names(extracted_data), ignore.case = TRUE)
    names(extracted_data) <- gsub("-std()", "Standard Deviation", names(extracted_data), ignore.case = TRUE)
    names(extracted_data) <- gsub("-freq()", "Frequency", names(extracted_data), ignore.case = TRUE)
    names(extracted_data) <- gsub("angle", "Angle", names(extracted_data))
    names(extracted_data) <- gsub("gravity", "Gravity", names(extracted_data))
    names(extracted_data) <- gsub("tgravity", "Time Gravity", names(extracted_data))
   Labels are set using the *gsub function*. In this way, it looks for the pattern in the string and replaces it with the desired names. Now, *extracted_data* is updated with appropriate labels. 

### 5. Create a second, independent tidy data set with the average of each variable for each activity and each subject
    extracted_data$Subject <- as.factor(extracted_data$Subject)
    extracted_data <- data.table(extracted_data)
    tidy_data <- aggregate(.~Subject + Activity, extracted_data, mean)
    tidy_data[order(tidy_data$Subject, tidy_data$Activity),]
   Convert the *Subject* column from the extracted data into factor variable. Then, create a data set called *tidy_data* that contains the average of each variable for each activity and subject. Lastly, rearrange the arguments using the order function in *tidy_data* and there have it, you can now have your independent tidy data.
   

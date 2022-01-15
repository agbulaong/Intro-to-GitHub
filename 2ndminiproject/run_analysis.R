# Sets working directory
setwd("C:/Users/andre/Desktop/CMSC197/specdata/UCI HAR Dataset")

#Packages 
library("data.table")

#Read data in Test
subject_test <- read.table("test/subject_test.txt", header = FALSE)
x_test <- read.table("test/X_test.txt", header = FALSE)
y_test <- read.table("test/Y_test.txt", header = FALSE)

#Read data in Training
subject_train <- read.table("train/subject_train.txt", header = FALSE)
x_train <- read.table("train/X_train.txt", header = FALSE)
y_train <- read.table("train/y_train.txt", header = FALSE)

#Combine each utility of Test and Train
subject <- rbind(subject_test, subject_train)
features <- rbind(x_test, x_train)
activity <- rbind(y_test, y_train)

#Change header
colnames(subject) <- "Subject"
feature_names <- read.table("features.txt", header = FALSE)
colnames(features) <- feature_names[,2]
colnames(activity) <- "Activity"

#Merging into one dataset
merged_data <- cbind(subject, activity, features)

#Extracts only the measurement
extracted_names <- grepl("mean|std", feature_names[,2])
extracted_data <- cbind(subject, activity, features[, extracted_names])

#Uses descripted activity names
activity_labels <- read.table("activity_labels.txt", header = FALSE)
activity_in_labels <- activity_labels[extracted_data$Activity, 2]
extracted_data$Activity <- activity_in_labels

#Appropriately labels the data
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

#Create a second, independent tiny data with average for each activity and subject
extracted_data$Subject <- as.factor(extracted_data$Subject)
extracted_data <- data.table(extracted_data)
tidy_data <- aggregate(.~Subject + Activity, extracted_data, mean)
tidy_data[order(tidy_data$Subject, tidy_data$Activity),]


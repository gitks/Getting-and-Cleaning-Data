# Source of data for the project:
# https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
# This R script does the following:
# 1. Merges the training and the test sets to create one data set.

trainData <- read.table("train/X_train.txt")
testData <- read.table("test/X_test.txt")
X.data <- rbind(trainData, testData)

trainData <- read.table("train/subject_train.txt")
testData <- read.table("test/subject_test.txt")
Sub.data <- rbind(trainData, testData)

trainData <- read.table("train/y_train.txt")
testData <- read.table("test/y_test.txt")
Y.data <- rbind(trainData, testData)

# 2. Extracts only the measurements on the mean and standard deviation for each measurement.

features <- read.table("features.txt")
indices_of_good_features <- grep("-mean\\(\\)|-std\\(\\)", features[, 2])
X.data <- X.data[, indices_of_good_features]
names(X.data) <- features[indices_of_good_features, 2]
names(X.data) <- gsub("\\(|\\)", "", names(X.data))
names(X.data) <- tolower(names(X.data))  # see last slide of the lecture Editing Text Variables (week 4)

# 3. Uses descriptive activity names to name the activities in the data set

activities <- read.table("activity_labels.txt")
activities[, 2] = gsub("_", "", tolower(as.character(activities[, 2])))
Y.data[,1] = activities[Y.data[,1], 2]
names(Y.data) <- "activity"

# 4. Appropriately labels the data set with descriptive activity names.

names(Sub.data) <- "subject"
cleaned <- cbind(Sub.data, Y.data, X.data)
write.table(cleaned, "merged_clean_data.txt")

# 5. Creates a 2nd, independent tidy data set with the average of each variable for each activity and each subject.

uniqueSubjects = unique(Sub.data)[,1]
numSubjects = length(unique(Sub.data)[,1])
numActivities = length(activities[,1])
numCols = dim(cleaned)[2]
result = cleaned[1:(numSubjects*numActivities), ]

row = 1
for (s in 1:numSubjects) {
  for (a in 1:numActivities) {
    result[row, 1] = uniqueSubjects[s]
    result[row, 2] = activities[a, 2]
    tmp <- cleaned[cleaned$subject==s & cleaned$activity==activities[a, 2], ]
    result[row, 3:numCols] <- colMeans(tmp[, 3:numCols])
    row = row+1
  }
}
# 6. creating the tidy data set for uploading to project submission
write.table(result, "tidy_data_set_with_the_averages.txt")


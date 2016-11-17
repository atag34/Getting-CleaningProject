##You should create one R script called run_analysis.R that does the following.

##  1. Merges the training and the test sets to create one data set.
##  2. Extracts only the measurements on the mean and standard deviation for each measurement.
##  3. Uses descriptive activity names to name the activities in the data set
##  4. Appropriately labels the data set with descriptive variable names.
##  5. From the data set in step 4, creates a second, independent tidy data set with the average 
##  of each variable for each activity and each subject.
##  Good luck!
library(dplyr)
fileurl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileurl,"./UCIHAR_Dataset.zip")
unzip("./UCIHAR_Dataset.zip")
features <- read.table("./UCI HAR Dataset/features.txt", header = FALSE);
activityTypes <- read.table("./UCI HAR Dataset/activity_labels.txt", header = FALSE);
trainSubjects <- read.table("./UCI HAR Dataset/train/subject_train.txt", header = FALSE);
Xtrain <- read.table("./UCI HAR Dataset/train/X_train.txt", header = FALSE);
Ytrain <- read.table("./UCI HAR Dataset/train/y_train.txt", header = FALSE);

## add column headings
colnames(activityTypes) = c('act_ID', 'act_label');
colnames(trainSubjects) =  "sub_id";
colnames(Xtrain) =  features[, 2];
colnames(Ytrain) = "act_ID";

##combine
Train_data <- cbind.data.frame(trainSubjects,Xtrain,Ytrain)

## Test Sets
testsubjects <- read.table("./UCI HAR Dataset/test/subject_test.txt", header = FALSE);
xtest <- read.table("./UCI HAR Dataset/test/X_test.txt", header = FALSE);
ytest <- read.table("./UCI HAR Dataset/test/y_test.txt", header = FALSE);
## add column headings
colnames(testsubjects) =  "sub_id";
colnames(xtest) =  features[, 2];
colnames(ytest) = "act_ID";

##  Combine
Test_data <- cbind.data.frame(testsubjects,xtest,ytest)

##  Combine all
alldata <- cbind.data.frame(Train_data, Test_data)

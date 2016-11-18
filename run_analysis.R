##You should create one R script called run_analysis.R that does the following.

##  1. Merges the training and the test sets to create one data set.
##  2. Extracts only the measurements on the mean and standard deviation for each measurement.
##  3. Uses descriptive activity names to name the activities in the data set
##  4. Appropriately labels the data set with descriptive variable names.
##  5. From the data set in step 4, creates a second, independent tidy data set with the average 
##  of each variable for each activity and each subject.
##  Good luck!
library(dplyr)
filename <- "UCIHAR_Dataset.zip"
if (!file.exists(filename)){ 
fileurl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileurl,"./UCIHAR_Dataset.zip")
unzip("./UCIHAR_Dataset.zip")
}

## Pull in Train Data, Features and Activity Names
features <- read.table("./UCI HAR Dataset/features.txt", header = FALSE);
activityTypes <- read.table("./UCI HAR Dataset/activity_labels.txt", header = FALSE);
trainSubjects <- read.table("./UCI HAR Dataset/train/subject_train.txt", header = FALSE);
Xtrain <- read.table("./UCI HAR Dataset/train/X_train.txt", header = FALSE);
Ytrain <- read.table("./UCI HAR Dataset/train/y_train.txt", header = FALSE);

## add column headings
colnames(activityTypes) = c('action', 'act_label');
colnames(trainSubjects) =  "subject";
colnames(Xtrain) =  features[, 2];
colnames(Ytrain) = "action";

##combine
Train_data <- cbind.data.frame(trainSubjects,Ytrain,Xtrain);

## Test Sets
testsubjects <- read.table("./UCI HAR Dataset/test/subject_test.txt", header = FALSE);
xtest <- read.table("./UCI HAR Dataset/test/X_test.txt", header = FALSE);
ytest <- read.table("./UCI HAR Dataset/test/y_test.txt", header = FALSE);
## add column headings
colnames(testsubjects) =  "subject";
colnames(xtest) =  features[, 2];
colnames(ytest) = "action";

##  Combine
Test_data <- cbind.data.frame(testsubjects,ytest,xtest);

##  Combine all
alldata <- rbind.data.frame(Train_data, Test_data);

## Create vector of Columns needed and new matrix from alldata containing only those columns.
cols <- colnames(alldata)
cols <- grep(".*subject.*|.*action.*|.*mean.*|.*std.*",cols, value = TRUE);
wanteddata <- subset(alldata, select = cols);

## Clean variable names and activity names
colnames(wanteddata) = tolower(gsub("\\(\\)-", "", colnames(wanteddata)));
colnames(wanteddata) = gsub("\\(\\)", "", colnames(wanteddata));
wanteddata$action <- factor(wanteddata$action, levels = activityTypes[,1], labels = activityTypes[,2]);

## Create Tidydata Set 
Tidydata <- summarise_all(group_by(wanteddata, action, subject), .funs = mean);

##  write out .txt version of tidy data set
write.table(Tidydata, "./tidydata.txt", row.names = FALSE)


library(dplyr)
library(tidyr)

##  Create directory if none exists
if(!file.exists("./data"))
	{dir.create("./data")}

##  Get ZIP file from website and unZIP the file
DataUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(DataUrl, destfile = "./data/ActivityData.zip")
ActivityDataUnZip <- unzip("./data/ActivityData.zip", exdir = "./data")

##  Read the unZIPed training and testing tables and the features and activity vectors
test.x <- read.table("./data/UCI HAR Dataset/test/X_test.txt")
train.x <- read.table("./data/UCI HAR Dataset/train/X_train.txt")

test.y <- read.table("./data/UCI HAR Dataset/test/y_test.txt")
train.y <- read.table("./data/UCI HAR Dataset/train/y_train.txt")

test.subject <- read.table("./data/UCI HAR Dataset/test/subject_test.txt")
train.subject <- read.table("./data/UCI HAR Dataset/train/subject_train.txt")

features <- read.table("./data/UCI HAR Dataset/features.txt")
activity <- read.table("./data/UCI HAR Dataset/activity_labels.txt")

##  Merge the training and testing tables
AllSubject <- rbind(train.subject, test.subject)
AllActivity <- rbind(train.y, test.y)
AllFeatures <- rbind(train.x, test.x)

##  Assign variables names
names(AllSubject)<-c("subject")
names(AllActivity)<- c("activity")
names(AllFeatures)<- features$V2

##  Combine into one data file
AllSubjectActivity <- cbind(AllSubject, AllActivity)
AllData <- cbind(AllFeatures, AllSubjectActivity)

##  Get the SD and Mean values
FeatureNames <- features$V2[grep("mean\\(\\)|std\\(\\)", features$V2)]
NamesSelected <- c(as.character(FeatureNames), "subject", "activity" )
SelectedData <- subset(AllData, select = NamesSelected)

##  Use descriptive variable names
names(SelectedData) <- gsub("^t", "time", names(SelectedData))
names(SelectedData) <- gsub("^f", "frequency", names(SelectedData))
names(SelectedData) <- gsub("Acc", "Accelerometer", names(SelectedData))
names(SelectedData) <- gsub("Gyro", "Gyroscope", names(SelectedData))
names(SelectedData) <- gsub("Mag", "Magnitude", names(SelectedData))
names(SelectedData) <- gsub("BodyBody", "Body", names(SelectedData))

##  Create tidy text file
SelectedDataTidy <- aggregate(. ~subject + activity, SelectedData, mean)
SelectedDataTidy <- SelectedDataTidy[order(SelectedDataTidy$subject, SelectedDataTidy$activity),]
write.table(SelectedDataTidy, file = "tidydata.txt", row.name=FALSE)


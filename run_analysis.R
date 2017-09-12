# courseproject3
Getting and Cleaning Data Course Project

## download the zipfile
if(!file.exists("./data")){dir.create("./data")}
fileZipUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
require(downloader)
download(fileZipUrl,"data/Dataset.zip", mode ="wb")


## unzip Dataset to Data directory
unzip(zipfile = "data/Dataset.zip",exdir = "./data" ) 


## loading required library 
library(dplyr)
library(data.table)


                   
## reading the  sets

filepath <- "C:/HARD/work/JohnH/c3/getdata%2Fprojectfiles%2FUCI HAR Dataset/UCI HAR Dataset"
setwd(filepath)

trainingset <- tbl_df(read.table(file.path (filepath,"train", "X_train.txt")))
traininglabels<- tbl_df( read.table(file.path (filepath,"train", "y_train.txt")))
tarinigsubject<- tbl_df( read.table(file.path (filepath,"train", "subject_train.txt")))
 
testset <- tbl_df(read.table(file.path (filepath,"test", "X_test.txt")))
testlabels <- tbl_df(read.table(file.path (filepath,"test", "y_test.txt")))
testsubject <- tbl_df(read.table(file.path (filepath,"test", "subject_test.txt")))
 
 
## merging the data
 
subjectcombonition <- rbind(testsubject,tarinigsubject)

setnames(subjectcombonition,"V1","Subject") ## change the name of first row to SUBJETC

labelescombonition <- rbind(traininglabels ,testlabels)
setnames(labelescombonition,"V1","activity") ## change the name of first row to activity


allcombonition <-rbind(testset, trainingset)

features <- tbl_df(read.table(file.path(filepath, "features.txt")))
setnames(features,names(features), c("Features.NO","Feature.Name")) ## how to name more than two rows
colnames(allcombonition) <- features$Feature.Name


activityLabels<- tbl_df(read.table(file.path(filepath, "activity_labels.txt")))
setnames(activityLabels, names(activityLabels), c("activity.NO","activityName"))

datasubact <- cbind(subjectcombonition,labelescombonition)
allcombonition <- cbind(datasubact,allcombonition)

extcractfeatuename <- grep("mean|std",features$Feature.Name, value = TRUE) ## extarc variable with mean or std

datameanstd <- union(c("Subject","activity"),extcractfeatuename)

library(dplyr)

allcombonition <- subset(allcombonition, select = datameanstd)

##edit(allsetscombonitions)## show a table if all data

## Uses descriptive activity names to name the activities in the data set

ActivityNametable <- fread(file.path(filepath, "activity_labels.txt")) ## fread is used to  import data from regular delimited files directly into R 
setnames(ActivityNametable, names(ActivityNametable), c("activity.No", "activity.Name"))

##Appropriately labels the data set with descriptive variable names.

names(allcombonition)<-gsub("std()", "SD", names(allcombonition)) ## change std to SD
names(allcombonition) <- gsub("mean","MEAN", names(allcombonition)) ## chanign mean to MEAN
names(allcombonition) <- gsub("^t","Time", names(allcombonition))
names(allcombonition) <- gsub("Acc","Accelerometer", names(allcombonition))
names(allcombonition) <- gsub("Mag","Magnititude", names(allcombonition))
names(allcombonition) <- gsub("Minimumimum","maximum", names(allcombonition))


names(allcombonition) <- gsub("^f","Frequency",names(allcombonition))
names(allcombonition) <- gsub("BodyBody","Body", names(allcombonition))
names(allcombonition) <- gsub("Gyro","Gyroscope", names(allcombonition))

head(str(allcombonition),10)


##From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

Tidydata <- aggregate(. ~Subject + activity, allcombonition, mean)

write.table(Tidydata,"Tidydata.txt", row.names = FALSE)  ## covert set to a .TXT  file





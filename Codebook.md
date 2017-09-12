## Code Book

### Source of Data
The below link is the source of data for the project.
      https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
      
Dataset consists of two data sets called "test" and "train". And each one has "subject", "activity", and "features".
To have one dataset, all the datasets were merged.
The process of merging datasets is listed below:
•	Merging test subject and train subject
•	Merging data of test and data of train
•	Reading the Feature.txt file and extract measurements which have the mean and standard deviation and merge it with dataset of second stage


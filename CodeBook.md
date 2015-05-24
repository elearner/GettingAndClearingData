# Code book

This code book that describes the variables, the data, and any transformations or work that was performed to clean up the original data.

## Original data

Original data was taken from
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
Discription of this data can be found at
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

## Tidy data

Tidy data was created from original data using run_analysis.R script. This script transform data in the following way:

- Unzips original data to current directory.
- Merges the training and the test sets to create one data set.
- Appropriately labels the data set with descriptive variable names. 
- Extracts only the measurements on the mean and standard deviation for each measurement.
- Uses descriptive activity names to name the activities in the data set
- Creates independent tidy data set with the average of each variable for each activity and each subject.
- Writes tidy data set into current folder.
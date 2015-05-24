# Check and install required packages if needed.
if (!require("reshape")) {
    install.packages("reshape")
}

# Load required packeges.
library(reshape)

# Extract data.
unzip("./getdata-projectfiles-UCI HAR Dataset.zip")

# Load common dictionaries.
activityLabels <- read.table("./UCI HAR Dataset/activity_labels.txt")
features <- read.table("./UCI HAR Dataset/features.txt")

# 1. Merges the training and the test sets to create one data set.
xtest <- read.table("./UCI HAR Dataset/test/X_test.txt")
ytest <- read.table("./UCI HAR Dataset/test/y_test.txt")
stest <- read.table("./UCI HAR Dataset/test/subject_test.txt")
test <- cbind(stest, ytest, xtest)

xtrain <- read.table("./UCI HAR Dataset/train/X_train.txt")
ytrain <- read.table("./UCI HAR Dataset/train/y_train.txt")
strain <- read.table("./UCI HAR Dataset/train/subject_train.txt")
train <- cbind(strain, ytrain, xtrain)

mergedData <- rbind(test, train)

# 4. Appropriately labels the data set with descriptive variable names. 
features <- read.table("./UCI HAR Dataset/features.txt")
dataNames <- c(c("subjectId", "activityId"), as.vector(features[, 2]))
names(mergedData) <- dataNames

# 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
featuresToExtract <- c(TRUE, TRUE, grepl("mean|std", features[, 2]))
extractedData <- mergedData[, featuresToExtract]

# 3. Uses descriptive activity names to name the activities in the data set
activityLabels <- read.table("./UCI HAR Dataset/activity_labels.txt")
extractedData$activityLabel <- activityLabels[extractedData$activityId, 2]

# 5. From the data set in step 4, creates a second, independent tidy data set
#    with the average of each variable for each activity and each subject.
idVars <- c("subjectId", "activityId", "activityLabel")
measureVars <- setdiff(colnames(extractedData), idVars)
meltedData <- melt(extractedData, id.vars = idVars, measure.vars = measureVars)
tidyData <- cast(meltedData, subjectId + activityId + activityLabel ~ variable, mean)

# Write tidy data to file.
write.table(tidyData, file = "./tidyData.txt", row.name = FALSE)
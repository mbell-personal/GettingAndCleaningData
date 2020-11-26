library(dplyr)

# Read the labels that will be used on both the test and training data sets
activityLabelsDF <- read.table("UCI HAR Dataset/activity_labels.txt")
featureLabelsDF <- read.table("UCI HAR Dataset/features.txt")

####################################################################
# Read and process the Test Data Set.

testDataDF <- read.table("UCI HAR Dataset/test/X_test.txt")
testActivitiesDF <- read.table("UCI HAR Dataset/test/y_test.txt")
testSubjectsDF <- read.table("UCI HAR Dataset/test/subject_test.txt")

# Set the labels on the test data file from the Feature Labels.  This will
# better identify the measurement.  While the names seem a bit cryptic, the labels
# are more meaningful than V1, V2, V3, etc.
names(testDataDF) <- featureLabelsDF$V2

# Add RowNumber  to the Test Data Set
testDataDF$RowNumber  <- seq.int(nrow(testDataDF))

# Add RowNumber to the Activities Data Set
testActivitiesDF$RowNumber  <- seq.int(nrow(testActivitiesDF))

# Add RowNumber to the Test Subjects Data Set
testSubjectsDF$RowNumber  <- seq.int(nrow(testSubjectsDF))

# Rename the column for the ActivityNumber
names(testActivitiesDF)[names(testActivitiesDF) ==  "V1"] <- "ActivityNumber"

# Merge the Activities with the Test Data Set.  This will show to which activity
# each measurement applies.
testDataWithActivityDF <- merge(testDataDF, testActivitiesDF, by.x = "RowNumber", by.y = "RowNumber")

# Merge the Activity Labels with the Test Data Set.
testDataWithActivityLabelDF <- merge(testDataWithActivityDF, activityLabelsDF, by.x = "ActivityNumber", by.y = "V1")

# Rename the column for the ActivityLabel
names(testDataWithActivityLabelDF)[names(testDataWithActivityLabelDF) ==  "V2"] <- "ActivityLabel"

# Merge the Subjects with the Test Data Set.
testDataWithActivityLabelAndSubjectDF <- merge(testDataWithActivityLabelDF, testSubjectsDF, by.x = "RowNumber", by.y = "RowNumber")

# Rename the column for the Subject
names(testDataWithActivityLabelAndSubjectDF)[names(testDataWithActivityLabelAndSubjectDF) ==  "V1"] <- "Subject"

# Add DataType column to indicate that the data is test  data
testDataWithActivityLabelAndSubjectDF$dataSource  <- 'Test'
####################################################################

####################################################################
# Read and process the Train Data Set.

trainDataDF <- read.table("UCI HAR Dataset/train/X_train.txt")
trainActivitiesDF <- read.table("UCI HAR Dataset/train/y_train.txt")
trainSubjectsDF <- read.table("UCI HAR Dataset/train/subject_train.txt")

# Set the labels on the train data file from the Feature Labels.  This will
# better identify the measurement.  While the names seem a bit cryptic, the labels
# are more meaningful than V1, V2, V3, etc.
names(trainDataDF) <- featureLabelsDF$V2

# Add RowNumber  to the Train Data Set
trainDataDF$RowNumber  <- seq.int(nrow(trainDataDF))

# Add RowNumber to the Activities Data Set
trainActivitiesDF$RowNumber  <- seq.int(nrow(trainActivitiesDF))

# Add RowNumber to the Train Subjects Data Set
trainSubjectsDF$RowNumber  <- seq.int(nrow(trainSubjectsDF))

# Rename the column for the ActivityNumber
names(trainActivitiesDF)[names(trainActivitiesDF) ==  "V1"] <- "ActivityNumber"

# Merge the Activities with the Train Data Set.  This will show to which activity
# each measurement applies.
trainDataWithActivityDF <- merge(trainDataDF, trainActivitiesDF, by.x = "RowNumber", by.y = "RowNumber")

# Merge the Activity Labels with the Train Data Set.
trainDataWithActivityLabelDF <- merge(trainDataWithActivityDF, activityLabelsDF, by.x = "ActivityNumber", by.y = "V1")

# Rename the column for the ActivityLabel
names(trainDataWithActivityLabelDF)[names(trainDataWithActivityLabelDF) ==  "V2"] <- "ActivityLabel"

# Merge the Subjects with the Train Data Set.
trainDataWithActivityLabelAndSubjectDF <- merge(trainDataWithActivityLabelDF, trainSubjectsDF, by.x = "RowNumber", by.y = "RowNumber")

# Rename the column for the Subject
names(trainDataWithActivityLabelAndSubjectDF)[names(trainDataWithActivityLabelAndSubjectDF) ==  "V1"] <- "Subject"

# Add DataType column to indicate that the data is train  data
trainDataWithActivityLabelAndSubjectDF$dataSource  <- 'Train'
####################################################################

# Combine the Train and Test Data Sets
combinedDataWithActivityLabelAndSubjectDF <- rbind(testDataWithActivityLabelAndSubjectDF, trainDataWithActivityLabelAndSubjectDF)

# Extract the standard deviation and mean values
combinedStdAndMeanDF <- select(combinedDataWithActivityLabelAndSubjectDF, Subject, ActivityLabel, grep("mean", names(combinedDataWithActivityLabelAndSubjectDF), ignore.case = TRUE), grep("std", names(combinedDataWithActivityLabelAndSubjectDF), ignore.case = TRUE))

# Create more user-friendly column names
columnNames <- names(combinedStdAndMeanDF)
columnNames <- gsub("tBodyAcc", "TimeBodyAcceleration", columnNames)
columnNames <- gsub("tGravityAcc", "TimeGravityAcceleration", columnNames)
columnNames <- gsub("tBodyGyro", "TimeBodyAngularVelocity", columnNames)
columnNames <- gsub("fBodyAcc", "FrequencyBodyAcceleration", columnNames)
columnNames <- gsub("fBodyBodyAcc", "FrequencyBodyAcceleration", columnNames)
columnNames <- gsub("fBodyGyro", "FrequencyBodyAngularVelocity", columnNames)
columnNames <- gsub("fBodyBodyGyro", "FrequencyBodyAngularVelocity", columnNames)
columnNames <- gsub("Mag", "Magnitude", columnNames)
columnNames <- gsub("-mean\\(\\)", "_Mean", columnNames)
columnNames <- gsub("-meanFreq\\(\\)", "_MeanFrequency", columnNames)
columnNames <- gsub("-std\\(\\)", "_StandardDeviation", columnNames)
columnNames <- gsub("-X", "_XAxis", columnNames)
columnNames <- gsub("-Y", "_YAxis", columnNames)
columnNames <- gsub("-Z", "_ZAxis", columnNames)
columnNames <- gsub("gravity", "Gravity", columnNames)
columnNames <- gsub("angle\\(TimeBodyAccelerationMean,Gravity\\)", "AverageOfTimeBodyAccelerationMeanAndGravity", columnNames)
columnNames <- gsub("angle\\(TimeBodyAccelerationJerkMean\\),GravityMean\\)", "AverageOfTimeBodyAccelerationJerkMeanAndGravityMean", columnNames)
columnNames <- gsub("angle\\(TimeBodyAngularVelocityMean,GravityMean\\)", "AverageOfTimeBodyAngularVelocityMeanAndGravityMean", columnNames)
columnNames <- gsub("angle\\(TimeBodyAngularVelocityJerkMean,GravityMean\\)", "AverageOfTimeBodyAngularVelocityJerkMeanAndGravityMean", columnNames)
columnNames <- gsub("angle\\(X,GravityMean\\)", "AverageOfXAxisAndGravityMean", columnNames)
columnNames <- gsub("angle\\(Y,GravityMean\\)", "AverageOfYAxisAndGravityMean", columnNames)
columnNames <- gsub("angle\\(Z,GravityMean\\)", "AverageOfZAxisAndGravityMean", columnNames)
names(combinedStdAndMeanDF) <- columnNames

# Create the summarized data set grouping by Activity and Subject showing the
# average or mean of each variable.
summarizedDF <- combinedStdAndMeanDF %>%
                    group_by(ActivityLabel, Subject) %>%
                    summarize(across(everything(), list(mean)))

# Adjust the column names to remove the '_1' that was appended to the end of each
# column name with the summarize function above.
columnNames <- names(summarizedDF)
columnNames <- gsub("_1", "", columnNames)
names(summarizedDF) <- columnNames

# Finally, write the summarized data to the workign directory.
write.table(summarizedDF, "Samsung-SummarizedData.txt", row.names = FALSE)

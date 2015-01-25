## Load, label, merge, subset, reshape, and summarize the training and test data 
## to generate a tidy data set.
run_analysis <- function() {
     
     ## Load required libraries
     library(data.table)
     library(plyr)
     library(dplyr)
     library(reshape2)
     
     #### LOAD BASIC DATA ####
     
     ## Read feature names into data frame (separated by space)
     feat <- read.table("./UCI HAR Dataset/features.txt",sep=" ")
     
     ## Read activity names into data frame (separated by space)
     activity <- read.table("./UCI HAR Dataset/activity_labels.txt",sep=" ")
     
     ## Set activity column names to allow for joining with plyr
     setnames(activity,names(activity),c("activityLabel","activityName"))
     
     #### LOAD TRAINING DATA ####
     
     ## Read subjects in the training set into a data frame
     subjTrain <- read.table("./UCI HAR Dataset/train/subject_train.txt")
     
     ## Read activity labels in the training set into a data frame
     yTrain <- read.table("./UCI HAR Dataset/train/y_train.txt")
     
     ## Create training set data table of subjects and activity labels
     trainDT <- data.table(dataset=rep("train",length(subjTrain[,1])),
                              subject=subjTrain[,1],activityLabel=yTrain[,1])
     
     ## Join training set data table and activity names (left join)
     trainDT <- join(trainDT,activity)
     
     ## Read fixed width training data into data.table
     ## Widths vector is 16 repeated 561 times (561 columns of 16 characters)
     ## Use reduced buffer size to prevent memory issues
     xTrain <- data.table(
                    read.fwf("./UCI HAR Dataset/train/X_train.txt",
                             widths=rep(16,561),buffersize=400))
     
     ## Set column names of xtrain data.table to feature names
     setnames(xTrain,names(xTrain),as.character(feat[,2]))
     
     ## Column bind xTrain dataset to training data table
     trainDT <- cbind(trainDT,xTrain)
     
     #### LOAD TEST DATA ####
     
     ## Read subjects in the test set into a data frame
     subjTest <- read.table("./UCI HAR Dataset/test/subject_test.txt")
     
     ## Read activity labels in the test set into a data frame
     yTest <- read.table("./UCI HAR Dataset/test/y_test.txt")
     
     ## Create test set data table of subjects and activity labels
     testDT <- data.table(dataset=rep("test",length(subjTest[,1])),
                           subject=subjTest[,1],activityLabel=yTest[,1])
     
     ## Join test set data table and activity names (left join)
     testDT <- join(testDT,activity)
     
     ## Read fixed width test data into data.table
     ## Widths vector is 16 repeated 561 times (561 columns of 16 characters)
     ## Use reduced buffer size to prevent memory issues
     xTest <- data.table(
                  read.fwf("./UCI HAR Dataset/test/X_test.txt",
                         widths=rep(16,561),buffersize=400))
     
     ## Set column names of xTest data.table to feature names
     setnames(xTest,names(xTest),as.character(feat[,2]))
     
     ## Column bind xTest dataset to test data table
     testDT <- cbind(testDT,xTest)
     
     #### COMBINE & RESHAPE DATA ####
     
     ## Combine training and test data set into a consolidated data table
     consDT <- rbind(trainDT, testDT)
     
     ## Get column indices where the column name contains "mean()"
     meanCols <- grep("mean\\(\\)",names(consDT))
     
     ## Get column indices where the column name contains "std()"
     stdCols <- grep("std\\(\\)",names(consDT))
     
     ## Create subset data table of columns 1-4, mean columns, and std columns
     subsetDT <- select(consDT,c(1:4,meanCols,stdCols))
     
     ## Convert the subset data table to a skinny data table using melt
     skinnyDT <- melt(subsetDT,id=c("dataset","subject","activityLabel",
                                        "activityName"))
     
     ## Rename the columns with descriptive column names
     setnames(skinnyDT,names(skinnyDT),
               c("SourceDataset",
                 "SubjectNumber",
                 "ActivityNumber",
                 "ActivityName",
                 "FeatureName",
                 "FeatureValue"))
     
     #### SUMMARIZE & OUTPUT DATA ####
     
     # Set group by parameters for dplyr query
     groupDT <- group_by(skinnyDT, SubjectNumber, ActivityName, FeatureName)
     
     ## Use summarize to calculate averages for each variable
     resultDT <- summarize(groupDT, VariableAverage = mean(FeatureValue))
     
     ## Write the result data table to "tidy_data.txt"
     write.table(resultDT,file="tidy_data.txt",row.names=FALSE)
     
     ## Return result data table for use in other operations as needed
     resultDT
     
}
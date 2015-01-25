# Accelerometer Tidy Data Codebook
=========
## Variables in Tidy Data Set

The variables (or columns) comprising the tidy data set from the accelerometer data set are:

1. SubjectNumber - The number identifying which subject the data was collected from.
2. ActivityName - A description of the activity that was being performed for the group of data (e.g. "WALKING").
3. FeatureName - The feature name for the data group (e.g. "tBodyAcc-mean()-X"). The data set is skinny (or narrow), meaning that each of the features is contained in a separate row rather than having a separate column for each. The name contained in FeatureName identifies which feature the row corresponds to. For more information on narrow data, see: http://en.wikipedia.org/wiki/Wide_and_narrow_data#Narrow
4. VariableAverage - The average of each variable for the corresponding FeatureName, ActivityName, and SubjectNumber. This column contains the data values, while the other columns are identifiers.

=========
## Data Cleaning & Transformation Steps

All of the steps below are contained in the run_analysis.R code file inside the run_analysis() function.

First, load the following R packages for use in subsequent steps:
* data.table - to be used in storing large data sets in a data table.
* plyr - to be used in joining two data tables with a left join.
* dplyr - to be used in selecting a subset of data, grouping by columns, and summarizing over those columns.
* reshape2 - to be used in melting a wide data table into a narrow / skinny data table.

The following steps are then performed for both the training and test data sets to create two data tables:

1. Read the feature names and numbers into a data frame.
2. Read the activity names and numbers into a data frame. Rename the columns of the activity data frame to activityLabel and activityName to allow for future joins using plyr.
3. Read the subjects for the data set into a data frame.
4. Read the activity labels (number code for activity) for the data set (either training or test data) into a data frame.
5. Create a data table for the data set (either training or test data) with the subjects and activity labels as columns.
6. Left joins the data table for the data set (either training or test data) with the activity names in order to provide a description of the activity.
7. Reads the fixed width data values for the data set (either training or test data) into a data table using read.fwf specifying 561 columns of 16 characters (i.e. widths=rep(16,561)) and a reduced buffer size of 400 lines to read at one time.
8. Set the column names of the data values table to correspond to the feature names.
9. Column bind the data table created in Step 5 with the data values data table created in Step 7 to generate a data table with four identifier columns (the source data set ("training" or "test"), the subject, the activity label / number, and the activity name) and 561 data value columns corresponding to each of the features.

After both the training and test data sets are loaded, the two data sets are combined into one data table and reshaped. This involves the following steps:

1. Row bind the training and test data tables into one consolidated data table. This data table has four identifier columns (the source data set ("training" or "test"), the subject, the activity label / number, and the activity name) and 561 data value columns corresponding to each of the features.
2. Use grep to obtain the column indices matching "mean()". These are the columns extracted for the measurement means. The meanFreq() and angle( ... ,gravityMean) features were not included as they do not appear to represent means of a data variable, but instead are different data transformations (i.e. weighted average frequency, angle between two vectors).
3. Use grep to obtain the column indices matching "std()". These are the columns extracted for the measurement standard deviations.
4. Use select command from the dplyr package to create a subset data table containing only the four identifier columns, the mean columns, and the standard deviation columns.
5. Use melt command from the reshape2 package to transform the data from wide (one column for each of the 561 features) to narrow / skinny (two columns total for 561 features: one containing the feature name and a second containing the data point value). 
6. Rename the columns of the melted data set with descriptive column names ("SourceDataset", "SubjectNumber", "ActivityNumber", "ActivityName", "FeatureName", and "FeatureValue").

After the skinny data set is created, the summary data is generated and output according to the steps below:

1. Use group_by command from the dplyr package to set "SubjectNumber", "ActivityName", and "FeatureName" columns as columns to average over.
2. Use summarize command from the dplyr package to generate a summary data table providing the mean of the "FeatureValue" column for each group / strata. Set the name of the resulting column to "VariableAverage".
3. Output the summary data table into "tidy_data.txt" without writing row names.
4. Return the summary data table from the function for use as needed.

The result of the function is the tidy data set with averages over the selected features, grouped by subject and activity.

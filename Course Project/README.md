# Getting and Cleaning Data - Course Project

This readme file explains the the files in this repository for the course project, as well as the procedure for performing the analysis.

The project instructions were to create one R script called run_analysis.R that does the following
1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the data set.
4. Appropriately labels the data set with descriptive variable names.
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

The raw data (not posted to this repository) were obtained from:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

The direct link for a zip of this data:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

Within the repository you'll find the run_analysis.R file that performs the data cleaning activities described above, a codebook explaining the variables in the data, along with a tidy data set, created in step 5 above.

## run_analysis.R script
The script includes comments for each step, but this readme provides an overview of the steps completed. 

The run_analysis.R script begins by looking for the zip file above, and if not found will download it. The code extracts the data to the default directories. Upon unzipping, the data will be in a directory called "UCI HAR Dataset" which will contain the train and test subfolders
(For details on the data, please see the Codebook.md file in this repository.)

The script then reads in a series of data tables.

1. features imports the variable names for the main datasets
  * The script identifies the variables of interest from step 2 above.
  * Only those variable names with "mean()" or "std()" will be used.

2. train_data imports the data from the "train" subfolder, in the file "X_train.txt"
  * This data is immediately subsetted by the variables of interest, creating train_sub
  
3. test_data / test_sub do the same from step 2, using the "test" subfolder
4. train_acty & test_acty import the activity data from "Y_train.txt" and "Y_test.txt" respectively
5. train_subj & test_subj import the subject data from "subject_train.txt" and "subject_test.txt" respectively

The script then performs column binds to join all of the test data together and all of the train data together, and then performs a row bind for those two complete data sets.

Using the data in the activity labels text file, the script then applies these activity names as factors for the activity data (Step 3 of the assignment)
For step 4, the script performs three steps to clean up variable names:

1. Replace "BodyBody" with just "Body" in some variable names
2. Replace "mean()" with "Mean" and "std()" with "StdDev" to clarify the variable measure
3. Replace the leading "t" with "Time-" and "f" with "Frequency" to explain the data captured in each variable

From this cleaned dataset, we now make the tidy dataset described in step 5 above. To do this, I use the "reshape2" package, so the script first ensures it is installed.
With the reshape2 package, the data is first melted and then recast. The melt creates a tall, thin dataset with 679734 rows from 10299 obs * 66 variables; 4 columns are subject, activity, variable, value.
From this narrow data, dcast reshapes it to provide the specified output - the mean of each variable for each subject / activity pairing. 
This results in a wide form dataset, with 180 rows (30 subjects * 6 activities) and 68 columns (Subject, Activity and 66 variables of means and standard deviations).

The script completes by writing the tidy data set to a file called "tidy_data.txt". This file is included in this repository.

The code to read in this tidy dataset are included as comments in the script, and repeated here as well:
```
## To read the data, use the following code:
data <- read.table("tidy_data.txt", header = TRUE)
```
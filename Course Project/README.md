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

The R script requires that the data be downloaded and unzipped in your working directory.
Keep the file structure the same as in the zip file, meaning that within your working directory there should be a directory called "UCI HAR Dataset" that contains the train and test folders
(For details on the data, please see the Codebook.md file in this repository.)

Within the repository you'll find the run_analysis.R file that performs the data cleanign activities described above. In addition, there are two datasets:
1. The tidy data set created from steps 1-4, working from the raw data, and
2. The data set created in step five with only the average for each variable for each activity and subject



--- Need to make it clear that (1) I ignored the inertial data folders, (2) I only included mean() and std(), not the overall means - why? and (3) my tidy data set is wide form


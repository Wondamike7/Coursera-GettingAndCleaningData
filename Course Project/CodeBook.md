# Code Book
This code book provides details on the data used for the Course Project for Getting and Cleaning Data. This project uses data from the Human Activity Recognition Using Smartphones Dataset [1].

## UCI HAR Dataset Readme
From the readme that came with the data:
> The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 
>
> The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. See 'features_info.txt' for more details. 
>
>For each record it is provided:
>
> Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
> Triaxial Angular velocity from the gyroscope. 
> A 561-feature vector with time and frequency domain variables. 
> Its activity label. 
> An identifier of the subject who carried out the experiment.

The features_info.txt file accompanying the data provide detail about the variables measured:
> The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 
>
>Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 
>
>Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 

## Data files
The data for the project were spread across several files:
* train/X_train.txt: Training set of 561 time and frequency variables
* test/X_test.txt: Test set of 561 time and frequency variables
* train/Y_train.txt: Activities aligned with the data measurements for the training set
* test/Y_test.txt: Activities aligned with the data measurements for the test set
* train/subject_train.txt: Subject id for the training set
* test/subject_test.txt: Subject id for the test set

The dataset also came with data on Inertial Signals, but these were not used for this course project.

## Cleaned data
The project involved capturing only those variables on mean and standard deviation. There were 66 variables with those measurements. Some additional variables that were obtained by averaging the signals in a signal window sample (and had "Mean" in the title", but these were excluded as they were not directly measuring the mean of a signal.

After merging the test and training data, along with the subjects and activities, the resulting data frame had 10299 observations and 68 columns.

1. Subject - integer variable representing the id of the subject, from 1 to 30
2. Activity - factor variable with 6 levels: 

1. WALKING
2. WALKING_UPSTAIRS
3. WALKING_DOWNSTAIRS
4. SITTING
5. STANDING
6. LAYING

The remaining variables were all numeric, with values between -1 and 1:

-	Time-BodyAcc-Mean-X
-	Time-BodyAcc-Mean-Y
-	Time-BodyAcc-Mean-Z
-	Time-GravityAcc-Mean-X
-	Time-GravityAcc-Mean-Y
-	Time-GravityAcc-Mean-Z
-	Time-BodyAccJerk-Mean-X
-	Time-BodyAccJerk-Mean-Y
-	Time-BodyAccJerk-Mean-Z
-	Time-BodyGyro-Mean-X
-	Time-BodyGyro-Mean-Y
-	Time-BodyGyro-Mean-Z
-	Time-BodyGyroJerk-Mean-X
-	Time-BodyGyroJerk-Mean-Y
-	Time-BodyGyroJerk-Mean-Z
-	Time-BodyAccMag-Mean
-	Time-GravityAccMag-Mean
-	Time-BodyAccJerkMag-Mean
-	Time-BodyGyroMag-Mean
-	Time-BodyGyroJerkMag-Mean
-	Frequency-BodyAcc-Mean-X
-	Frequency-BodyAcc-Mean-Y
-	Frequency-BodyAcc-Mean-Z
-	Frequency-BodyAccJerk-Mean-X
-	Frequency-BodyAccJerk-Mean-Y
-	Frequency-BodyAccJerk-Mean-Z
-	Frequency-BodyGyro-Mean-X
-	Frequency-BodyGyro-Mean-Y
-	Frequency-BodyGyro-Mean-Z
-	Frequency-BodyAccMag-Mean
-	Frequency-BodyAccJerkMag-Mean
-	Frequency-BodyGyroMag-Mean
-	Frequency-BodyGyroJerkMag-Mean
-	Time-BodyAcc-StdDev-X
-	Time-BodyAcc-StdDev-Y
-	Time-BodyAcc-StdDev-Z
-	Time-GravityAcc-StdDev-X
-	Time-GravityAcc-StdDev-Y
-	Time-GravityAcc-StdDev-Z
-	Time-BodyAccJerk-StdDev-X
-	Time-BodyAccJerk-StdDev-Y
-	Time-BodyAccJerk-StdDev-Z
-	Time-BodyGyro-StdDev-X
-	Time-BodyGyro-StdDev-Y
-	Time-BodyGyro-StdDev-Z
-	Time-BodyGyroJerk-StdDev-X
-	Time-BodyGyroJerk-StdDev-Y
-	Time-BodyGyroJerk-StdDev-Z
-	Time-BodyAccMag-StdDev
-	Time-GravityAccMag-StdDev
-	Time-BodyAccJerkMag-StdDev
-	Time-BodyGyroMag-StdDev
-	Time-BodyGyroJerkMag-StdDev
-	Frequency-BodyAcc-StdDev-X
-	Frequency-BodyAcc-StdDev-Y
-	Frequency-BodyAcc-StdDev-Z
-	Frequency-BodyAccJerk-StdDev-X
-	Frequency-BodyAccJerk-StdDev-Y
-	Frequency-BodyAccJerk-StdDev-Z
-	Frequency-BodyGyro-StdDev-X
-	Frequency-BodyGyro-StdDev-Y
-	Frequency-BodyGyro-StdDev-Z
-	Frequency-BodyAccMag-StdDev
-	Frequency-BodyAccJerkMag-StdDev
-	Frequency-BodyGyroMag-StdDev
-	Frequency-BodyGyroJerkMag-StdDev
	
## Tidy Data Set
The tidy data set created upon completion of the project had the same variables, but only 180 observations. Each observation provided the average for the variable for the given subject and activity pair (30 subjects * 6 activities = 180 observations).

## References
[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

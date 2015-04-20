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

3.	Time-BodyAcc-Mean-X
4.	Time-BodyAcc-Mean-Y
5.	Time-BodyAcc-Mean-Z
6.	Time-GravityAcc-Mean-X
7.	Time-GravityAcc-Mean-Y
8.	Time-GravityAcc-Mean-Z
9.	Time-BodyAccJerk-Mean-X
10.	Time-BodyAccJerk-Mean-Y
11.	Time-BodyAccJerk-Mean-Z
12.	Time-BodyGyro-Mean-X
13.	Time-BodyGyro-Mean-Y
14.	Time-BodyGyro-Mean-Z
15.	Time-BodyGyroJerk-Mean-X
16.	Time-BodyGyroJerk-Mean-Y
17.	Time-BodyGyroJerk-Mean-Z
18.	Time-BodyAccMag-Mean
19.	Time-GravityAccMag-Mean
20.	Time-BodyAccJerkMag-Mean
21.	Time-BodyGyroMag-Mean
22.	Time-BodyGyroJerkMag-Mean
23.	Frequency-BodyAcc-Mean-X
24.	Frequency-BodyAcc-Mean-Y
25.	Frequency-BodyAcc-Mean-Z
26.	Frequency-BodyAccJerk-Mean-X
27.	Frequency-BodyAccJerk-Mean-Y
28.	Frequency-BodyAccJerk-Mean-Z
29.	Frequency-BodyGyro-Mean-X
30.	Frequency-BodyGyro-Mean-Y
31.	Frequency-BodyGyro-Mean-Z
32.	Frequency-BodyAccMag-Mean
33.	Frequency-BodyAccJerkMag-Mean
34.	Frequency-BodyGyroMag-Mean
35.	Frequency-BodyGyroJerkMag-Mean
36.	Time-BodyAcc-StdDev-X
37.	Time-BodyAcc-StdDev-Y
38.	Time-BodyAcc-StdDev-Z
39.	Time-GravityAcc-StdDev-X
40.	Time-GravityAcc-StdDev-Y
41.	Time-GravityAcc-StdDev-Z
42.	Time-BodyAccJerk-StdDev-X
43.	Time-BodyAccJerk-StdDev-Y
44.	Time-BodyAccJerk-StdDev-Z
45.	Time-BodyGyro-StdDev-X
46.	Time-BodyGyro-StdDev-Y
47.	Time-BodyGyro-StdDev-Z
48.	Time-BodyGyroJerk-StdDev-X
49.	Time-BodyGyroJerk-StdDev-Y
50.	Time-BodyGyroJerk-StdDev-Z
51.	Time-BodyAccMag-StdDev
52.	Time-GravityAccMag-StdDev
53.	Time-BodyAccJerkMag-StdDev
54.	Time-BodyGyroMag-StdDev
55.	Time-BodyGyroJerkMag-StdDev
56.	Frequency-BodyAcc-StdDev-X
57.	Frequency-BodyAcc-StdDev-Y
58.	Frequency-BodyAcc-StdDev-Z
59.	Frequency-BodyAccJerk-StdDev-X
60.	Frequency-BodyAccJerk-StdDev-Y
61.	Frequency-BodyAccJerk-StdDev-Z
62.	Frequency-BodyGyro-StdDev-X
63.	Frequency-BodyGyro-StdDev-Y
64.	Frequency-BodyGyro-StdDev-Z
65.	Frequency-BodyAccMag-StdDev
66.	Frequency-BodyAccJerkMag-StdDev
67.	Frequency-BodyGyroMag-StdDev
68.	Frequency-BodyGyroJerkMag-StdDev

 
## Tidy Data Set
The tidy data set created upon completion of the project had the same variables, but only 180 observations. Each observation provided the average for the variable for the given subject and activity pair (30 subjects * 6 activities = 180 observations).

### References
[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

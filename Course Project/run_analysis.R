## This is the code for the Course Project in Getting and Cleaning Data

## first look for the zip file, if not found, download
setInternet2(use=TRUE) ## needed for accessing https on Windows
filename <- "getdata_projectfiles_UCI HAR Dataset.zip"
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
if(!filename %in% list.files()) {
	download.file(url, destfile=filename)
}
unzip(filename) ## unzips the file using the default directory "UCI HAR Dataset" and subdirectories
	
## Read in the features table, which will provide the variable names
features <- read.table("./UCI HAR Dataset/features.txt",header=FALSE,sep="",quote="",stringsAsFactors = FALSE)

## First find all variable names in the features dataset with "mean()" , then all with "std()"
## Subset the features list, keeping only those (66) columns; use this later to subset the data
mean_vars <- grep("mean\\(\\)",features$V2)
std_vars <- grep("std\\(\\)",features$V2)
var_list <- append(mean_vars,std_vars)

# Step 1. Merge the training and test data sets & Step 2. Extract only measurements with mean and standard deviation
## First pull in both data sets
train_data <- read.table("./UCI HAR Dataset/train/X_train.txt",header=FALSE,sep="",quote="")
	## dim(train_data) yield [1] 7352  561
names(train_data) <- features[,2]
train_sub <- train_data[,var_list] ## subsets to only mean & std dev variables

test_data <- read.table("./UCI HAR Dataset/test/X_test.txt",header=FALSE, sep="", quote="")
	## dim(test_data) yields [1] 2947  561
names(test_data) <- features[,2]
test_sub <- test_data[,var_list] ## subsets to only mean & std dev variables
	
## Pulling in the activity and subject data as well	
train_acty <- read.table("./UCI HAR Dataset/train/Y_train.txt",header=FALSE,sep="",quote="", col.names=c("Activity"),colClasses=c("factor"))
    ## dim(train_acty) yields [1] 7352  1
test_acty <- read.table("./UCI HAR Dataset/test/Y_test.txt",header=FALSE,sep="",quote="", col.names=c("Activity"),colClasses=c("factor"))
    ## dim(test_acty) yields [1] 2947  1	
train_subj <- read.table("./UCI HAR Dataset/train/subject_train.txt",header=FALSE,sep="",quote="",col.names=c("Subject"))
    ## dim(train_subj) yields [1] 7352  1
test_subj <- read.table("./UCI HAR Dataset/test/subject_test.txt",header=FALSE,sep="",quote="",col.names=c("Subject"))
    ## dim(test_subj) yields [1] 2947  1

## Create a full train and full test first, and then merge
test_full <- cbind(test_subj,test_acty,test_sub) ## dim = 2947  563
train_full <- cbind(train_subj,train_acty,train_sub) ## dim = 7352  563

full_data <- rbind(test_full,train_full) ## dim = 10299  563, no missing values anywhere

# Step 3. Use descriptive activity names to name the activities in the data set
## read in activity labels
acty_labels <- read.table("./UCI HAR Dataset/activity_labels.txt",header=FALSE,sep="",quote="",col.names=c("Activity_ID","Activity_Labels"),stringsAsFactors=FALSE)
full_data$Activity <- factor(full_data$Activity,levels=acty_labels$Activity_ID, labels = acty_labels$Activity_Labels) 
    ## factors the activity level, assigning the levels and labels from the activity_labels table

# Step 4. Appropriately labels the data set with descriptive variable names
z <- names(full_data) ## for ease of writing/understanding, first pulling names into a new vector

## Some variable names unnecessarily repeated the word "Body" - Clean "BodyBody" to just "Body" 
z<-gsub("BodyBody","Body",z)

## Clean up mean() to Mean, std(), to StdDev
z <- gsub("mean[(][)]","Mean",z)
z <- gsub("std[(][)]","StdDev",z)

## Explain first character of variables: t = Time, f = Frequency
z[substring(z,1,1)=="t"] <- paste("Time-",substring(z[substring(z,1,1)=="t"],2),sep="")
	## takes subset of variable names that start with "t" and pastes "Time-" with the 2nd character forward of those variable names
z[substring(z,1,1)=="f"] <- paste("Frequency-",substring(z[substring(z,1,1)=="f"],2),sep="")
	## takes subset of variable names that start with "f" and pastes "Frequency-" with the 2nd character forward of those variable names

names(full_data)<-z  ## pulls the cleaned up vector of names into the full_data set

## write.table(full_data, file="Cleaned dataset.txt",row.name=FALSE) ## not necessary

# Step 5. From data set in step 4, create a second, independent tidy data set with the average of each variable for each activity and each subject.
## I used the reshape library to melt the data and then cast it as a wide dataset with 180 observations (30 subj * 6 acty) and 68 columns (subj, acty, 66 vars)
if(!require(reshape2)) { 
	install.packages("reshape2")
	} else {library(reshape2)}

melted_data <- melt(full_data,id=c("Subject","Activity"))  
	## use the melt to create a tall, thin dataset. 
	## By not specifying measure.vars, it uses all other variables in the set as measurement variables
	## dim(melted_data) results in [1] 679734    4  --> 679734 rows from 10299 obs * 66 variables; 4 columns are subject, activity, variable, value
tidy_set <- dcast(melted_data, Subject + Activity ~ variable,mean)
	## the dcast takes the melted data above and reshapes it so that it gives me the specified output (variable mean) for all subject/activity pairs
	## dim(tidy_set) gives [1] 180  68 --> 180 is 30 subjects times 6 activities; subject + activity + 66 variables = 68 columns
	
write.table(tidy_set,file="tidy_data.txt",row.name=FALSE)

## To read the data, use the following code:
## data <- read.table("tidy_data.txt", header = TRUE)
## QUIZ3
## question 1
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
download.file(url,destfile="quiz3_q1.csv")
q1 <- read.csv("quiz3_q1.csv")
head(q1)
agricultureLogical <- (q1$ACR == 3 & q1$AGS==6)
which(agricultureLogical) ## 125 238 262 are first three values

## Q2
install.packages("jpeg")
library(jpeg)
url2 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg"
download.file(url2,destfile="jeff.jpg", mode="wb") ## need to download as binary or it doesn't work properly
jeff <- readJPEG("jeff.jpg", native=TRUE) ## native=TRUE was included in the question
quantile(jeff,prob=c(.3,.8)) ## result was -15259150 -10575416

## Q3
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
download.file(url,destfile="quiz3_q3.csv")
q3a <- read.csv("quiz3_q3.csv") ## needed a lot more parameters than this; need to explore the csv in notepad++ before importing
## see below for some more code trying to figure this out - eventually asked question on forum
## couldn't figure out how to bring in the GDP value as numeric. In csv it's format is this " 16,822,300 "
url2 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv"
download.file(url2,destfile="quiz3_q3b.csv")
q3_b <- read.csv("quiz3_q3b.csv")

head(q3_a);head(q3_b) ## blanks in header of q3_a

q3_a <- read.csv("quiz3_q3.csv",skip=4) ## this cleaned up one portion of the error
head(q3_a) 
dim(q3_a) ## 234 rows rather than 190 as explained in the question/forum
q3_a <- read.csv("quiz3_q3.csv",skip=4,nrows=190,stringsAsFactors=FALSE) ## this is the code I eventually used, but didn't solve all problems
head(q3_a)
tail(q3_a)
q3_a<-q3_a[,c(1,2,4,5)] ## cutting out garbage columns (lots of trailing commas in csv)

q3_b<-read.csv("quiz3_q3b.csv",stringsAsFactors=FALSE) ## re-enter data
q3_b<-q3_b[,c(1,3,4,31)] ## cut to only variables of interest

q3_merge<-merge(q3_a,q3_b,by.x="X",by.y="CountryCode",all=TRUE)
dim(q3_a) ##190
dim(q3_b) ##234
dim(q3_merge) ##235 - so I know one of the 190 didn't match, making it 189 matches
## I found that it was SSD (South Sudan) that existed in the list of 190 that wasn't on the education stats list.
q3_arr <- arrange(q3_merge,desc(X.1)) ## arrange descending by the GDP rank
q3_arr[13,] ## St. Kitts & Nevis is 13th "worst" by GDP

## Question 4
table(q3_arr$Income.Group) ## just making sure the data are grouped by these factors
?sapply
q3_split <- split(q3_arr$X.1,q3_arr$Income.Group) ## split the data in GDP rank by Income Group
sapply(q3_split,mean,na.rm=TRUE) ## need to remember how to add args to the sapply function, simply pass as ... after the fx
## the split/sapply worked for q4. OECD is 32.97, nonOECD is 91.91

## Question 5
q3_arr$GDP_rank <- cut(q3_arr$X.1,quantile(q3_arr$X.1,length=6, na.rm=TRUE)) ## bad code, need to use length inside sequence for quantile
q3_arr$GDP_rank <- cut(q3_arr$X.1,quantile(q3_arr$X.1,probs=seq(0,1,length=6), na.rm=TRUE)) ## There were only 37 in lowest group b/c it auto-excludes #1
table(q3_arr$GDP_rank,q3_arr$Income.Group)
q3_arr$GDP_rank <- cut(q3_arr$X.1,quantile(q3_arr$X.1,probs=seq(0,1,length=6), na.rm=TRUE),include.lowest=TRUE) ## Forced to include.lowest. Didn't change answer
table(q3_arr$GDP_rank,q3_arr$Income.Group) ## 5 are lower middle income and in lowest GDP rank category (meaning highest GDP)

## add'l code from Q3
?read.csv
q3_a <- read.csv("quiz3_q3.csv",skip=4,quote="",nrows=190,stringsAsFactors=FALSE) ## error due to different number of columns
## after bringing it back in per above code, tried to get GDP value to numeric
q3_a$X.4 <- as.numeric(q3_a$X.4) ## all NAs, probably due to commas in character variable?
## could I use gsub for all commas, and bring that in as numeric?
q3_a$X.4 <- as.numeric(gsub(",","",q3_a$X.4)) ## This worked!
q3_a <- read.csv("quiz3_q3.csv",skip=4,nrows=190,stringsAsFactors=FALSE,
colClasses=c("character","integer","logical","character","numeric","character",rep("logical",4))) ## couldn't force X.4 as numeric, said it was expecting 'a real' but got " 16"

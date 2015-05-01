## Quiz 4
## Question 1, split names by "wgtp" and list element 123
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
download.file(url,destfile="quiz4q1.csv")
q1 <- read.csv("quiz4q1.csv")
names(q1)
q1split <- strsplit(names(q1),"wgtp")
q1split[123]
## "" "15"

## Question 2, give average of gdp means
url2 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
download.file(url2,destfile="quiz4q2.csv")
q2 <- read.csv("quiz4q2.csv",skip=4,stringsAsFactors=FALSE,nrows=190)
head(q2,3)
q2$X.4 <- as.numeric(gsub(",","",q2$X.4))
head(q2,3)
mean(q2$X.4)
## 377652.4

## Question 3, same gdp data, how many countries start with "United" and what is the code to figure that out
grep("^United",q2$X.3)
## grep("^United",q2$X.3) resulted in three found (1 6 32)
grep("^United",q2$X.3, value=TRUE)
## United States, United Kingdom, United Arab Emirates

## Question 4, How many fiscal years end in June
url4a <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
url4b <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv"
download.file(url4a,destfile="quiz4q4a.csv")
download.file(url4b,destfile="quiz4q4b.csv")
q4a <- read.csv("quiz4q4a.csv",skip=4,stringsAsFactors=FALSE,nrows=190)
head(q4a)
tail(q4a)
q4b <- read.csv("quiz4q4b.csv")
head(q4b) ## found fiscal year end info in "Special.Notes" column
tail(q4b)
q4merge <- merge(q4a,q4b,by.x="X",by.y="CountryCode",all=TRUE) ## merge data
grepl("Fiscal year end",q4merge$Special.Notes) ## vector of TRUE/FALSE
grep("Fiscal year end",q4merge$Special.Notes,value=TRUE) ## exploring the values
q4sub <- q4merge[grepl("Fiscal year end",q4merge$Special.Notes),] ## subset data to only those with fiscal year data
grep("June",q4sub$Special.Notes,value=TRUE) ## look for June in subset with FY data
## 13 found with June as the fiscal year end (first subsetted to any that listed Fiscal year end, then used grep to find June)

## Question 5, how many values in 2012, how many on Mondays in 2012
install.packages("quantmod")
library(quantmod)
amzn = getSymbols("AMZN",auto.assign=FALSE)  ## code provided
sampleTimes = index(amzn) ## code provided
head(sampleTimes)
year(sampleTimes[1]) ## test of code
q5 <- sampleTimes[year(sampleTimes)==2012] ## subset to those with 2012 as the year
head(q5) ## test of subset
length(q5) ## length of vector will provide answer to first portion of question
## 250
weekdays(q5[1]) ## test of code
q5b <- q5[weekdays(q5)=="Monday"] ## subset of those in 2012 with Monday as the weekday
length(q5b) ## length to get answer for second portion
## 47

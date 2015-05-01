## QUIZ 1
## Question 1
## could not download files using HTTPS. Need to figure out curl or RCurl to enable this. Was able to get everything by dropping to HTTP
library(curl)
fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv" 
download.file(fileURL,"ACS.csv",method="curl")
download.file(fileURL,"ACS.csv")

fileURL <- "http://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv" 
download.file(fileURL,"ACS.csv")
data <- read.csv("ACS.csv")
dim(data)
str(data)
head(data)
summary(data$VAL==24)	## this gave me the number of FALSE, TRUE, and NA for that statement. 53 were TRUE.

## Question 2
## The code book notes that there are multiple conditions nested in the same variable (FES). 
## This violates the tidy data concept of a single variable per column.

## Question 3
## download.file(fileURL,"NGAP.xlsx") - there were many errors because I didn't specify the mode as 'wb'.
## something about binary, and java giving errors about ZIP exceptions or something.
library(xlsx)
fileURL <- "http://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx"
download.file(fileURL,"NGAP.xlsx", mode='wb')
colIndex <- 7:15
rowIndex <- 18:23
data1 <- read.xlsx("NGAP.xlsx",sheetIndex=1,colIndex = colIndex, rowIndex = rowIndex)
str(data1)
sum(data1$Zip*data1$Ext,na.rm=T)  ## 36534720

## Question 4
## still errors with https...
library(XML)
fileURL <- "http://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml"
a <- xmlTreeParse(fileURL, useInternalNodes = TRUE)
rootNode <- xmlRoot(a)
xmlName(rootNode)
names(rootNode)
xpathSApply(rootNode, "//zipcode", xmlValue)
zips <- xpathSApply(rootNode, "//zipcode", xmlValue)
table(zips) ## this presented a table of the various zip codes. Looking up 21231 showed 127 observations.

## Question 5
fileURL <- "http://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv"
download.file(fileURL,"ACS_2006.csv")
DT <- fread("ACS_2006.csv")
head(DT)
system.time(rowMeans(DT)[DT$SEX==1]) + system.time(rowMeans(DT)[DT$SEX==2]) ## error with the RowMeans function, not sure what I was doing wrong
system.time(tapply(DT$pwgtp15,DT$SEX,mean) )
system.time(DT[,mean(pwgtp15),by=SEX])
system.time(mean(DT[DT$SEX==1,]$pwgtp15)) + system.time(mean(DT[DT$SEX==2,]$pwgtp15))
system.time(sapply(split(DT$pwgtp15,DT$SEX),mean) )
system.time(mean(DT$pwgtp15,by=DT$SEX))
## probably should have done a test running multiple observations since a couple of the system.times were zero.
## instead took a guess that DT[,mean] was fastest.
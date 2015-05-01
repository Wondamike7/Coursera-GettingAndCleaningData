options(digits=4)

set.seed(13435)
X <- data.frame("var1"=sample(1:5),"var2"=sample(6:10),"var3"=sample(11:15))
X <- X[sample(1:5),]
X$var2[c(1,3)] = NA
X  ## created a randomized data frame

X[,1] ## subset to only column 1, returns a vector rather than a list/data.frame column
X[,"var1"] ## same thing
X$var1 ## same thing

X[1:2,"var2"] ##first two rows, column 2

## can use logicals too
X[(X$var1<=3 & X$var3 > 11),]
X[(X$var1<=3 | X$var3>15),]

## using which allows you to deal with NAs
## which returns the index of rows where the condition is met
X[which(X$var2>8),]

## check to see what code without using which returns:
X[X$var2>8,]
## that code returned NA rows with all variables written as NA, along with the two correct rows

## Sorting:
sort(X$var1)
## outputs a vector of sorted values
sort(X$var1, decreasing=TRUE) ## same as before, but in decreasing order
sort(X$var2,na.last=TRUE) ## puts NAs at end

## order by variable, orders entire data frame not just sorting the column values
X[order(X$var1),]
X[order(X$var1,X$var3),] ## sorts first by var1 then by var3 (no difference here)

library(plyr)
arrange(X,var3)
arrange(X,desc(var1)) ## arrange seems to just do "order"

## adding rows and columns
X$var4 <- rnorm(5)
Y <- cbind(X,rnorm(5)) ## binds a column to the right side of X

## rbind adds rows
Y1 <- rbind(Y,rnorm(5))

## Tested some code to see how R behaved.
Y1 <- rbind(Y,rnorm(3))
Y1 <- rbind(Y,c(1:4))
Y1 <- rbind(Y,c(1:6))
## extrapolates in first two cases, adding rnorms for first, restarting sequence in second; drops the sixth for c(1:6)

## Summarizing the Data
url <- "https://data.baltimorecity.gov/api/views/k5ry-ef3g/rows.csv?accessType=DOWNLOAD"
setInternet2(use=TRUE)
setwd("./Getting and Cleaning Data")
if(!file.exists("./data")){dir.create("./data")}
download.file(url,destfile="./data/restaurants.csv")
restData<-read.csv("./data/restaurants.csv")
head(restData)
## followed their method for looking for data directory and if not found, create
## downloaded and read in the csv. Had to first use the setinternet2 command to use https

head(restData,3)
tail(restData,3)
summary(restData)
str(restData)
dim(restData)

quantile(restData$councilDistrict,na.rm=TRUE)
quantile(restData$councilDistrict,probs=c(0.5,0.75,0.9))

table(restData$zipCode,useNA="ifany") ## include the useNA to group all the NAs into a category and show in table; default is to hide
table(restData$councilDistrict,restData$zipCode)
colMeans(restData[,c(2,4)])
## that worked to get the means of each column
colMeans(restData[,c(2,4)],na.rm=TRUE)

## check for missing values
sum(is.na(restData$councilDistrict)) ## 0 (no NAs in data)
any(is.na(restData$councilDistrict)) ## FALSE (no NAs in data)
all(restData$zipCode>0) ## last returned FALSE because we have a single negative zip code

## row and column sums
colSums(is.na(restData)) ## all zeros returned, no NAs in table
all(colSums(is.na(restData))==0)
table(restData$zipCode %in% c("21212"))
table(restData$zipCode == "21212") ## last two returned same
table(restData$zipCode %in% c("21212","21213")) ## easier to use in with multiple values
restData[restData$zipCode %in% c("21212","21213"),]
restData[restData$zipCode %in% c("21212","21213"),]

data(UCBAdmissions)
DF = as.data.frame(UCBAdmissions)
summary(DF)
xt <- xtabs(Freq~Gender + Admit,data=DF)
xt
warpbreaks$replicate <- rep(1:9,len=54)
warpbreaks
xt <- xtabs(breaks~.,data=warpbreaks)
xt ## long row of cross-tabs for each replicate value (1 through 9)
ftable(xt) ## flat table

object.size(warpbreaks)
object.size(restData)
print(object.size(restData),units="Mb")
print(object.size(restData),units="Kb")

## Creating New Vars
## using restaurant data again
restData<-read.csv("./data/restaurants.csv")
head(restData,2)
s1 <- seq(1,10,by=2); s1 ## sequence by 2 - 1, 3, 5, 7, 9
s2 <- seq(1,10,length=3); s2 ## sequence of length 3 - 1, 5.5, 10
x <- c(1,3,8,25,100); seq(along=x) ## ordered vector - 1,2,3,4,5 to allow subsetting to access x

restData$nearMe = restData$neighborhood %in% c("Roland Park","Homeland") 
## created a true/false variable for the condition specified and added it to the data frame
## it's a way of creating a subsetting variable
table(restData$nearMe)
table(restData$zipCode,restData$nearMe)

restData$zipWrong = ifelse(restData$zipCode<0,TRUE,FALSE) ## creates T/F for the condition. TRUE if zip is negative (1 case)
table(restData$zipWrong,restData$zipCode<0)
restData$zipWrong = ifelse(restData$zipCode<0,1,0)
table(restData$zipWrong,restData$zipCode<0) ## test to see using other values for ifelse...could then factor the created variable

restData$zipGroups = cut(restData$zipCode,breaks=quantile(restData$zipCode))
table(restData$zipGroups)
table(restData$zipGroups,restData$zipCode)
table(restData$zipCode) ## for some reason the -21226 zip code has a 0 for all zipGroups

## running some checks here
restData[restData$zipCode==-21226,]
## zipGroups is NA
?cut
## looks like it defaults to NOT include lowest value. Not sure why (asked in forum)

install.packages("Hmisc")
library(Hmisc)
restData$zipGroups = cut2(restData$zipCode, g= 4)
table(restData$zipGroups)
table(restData$zipGroups,restData$zipCode) ## cut2 defaulted to including all values (it seems) (included lowest)
## also has better display for the factors

restData$zcf <- factor(restData$zipCode)
class(restData$zcf) ## factor
summary(restData$zcf)
table(restData$zcf) ## last two lines did exact same thing (must be factor variable specific)

as.numeric(restData$zcf[1:10])
restData$zcf[1:10]

yesno<-sample(c("yes","no"),size=10,replace=TRUE)
yesno
yesnofac <- factor(yesno,levels=c("yes","no")) ## will default to alphabetic ordering if you don't specify levels
as.numeric(yesnofac)
relevel(yesnofac,ref="yes") ## don't know why we relevel, already set for "yes" to baseline
yesnofac <- factor(yesno)
as.numeric(yesnofac) ## no is 1, yes is 2 now
relevel(yesnofac,ref="yes") ## now releveling changes it
as.numeric(relevel(yesnofac,ref="yes")) ## shows the flip, yes is 1

library(plyr)
restData2 = mutate(restData,zipGroups=cut2(zipCode,g=4))
table(restData2$zipGroups)

## reshaping data
library(reshape2)
head(mtcars)
mtcars$carname <- rownames(mtcars)
head(mtcars)
carMelt <- melt(mtcars,id=c("carname","gear","cyl"),measure.vars=c("mpg","hp")) ## need to learn more about "melt"
head(carMelt)
str(mtcars)
str(carMelt) ## carMelt has two times the rows, but fewer vars (tall & skinny dataset)
cylData <- dcast(carMelt, cyl ~ variable) ## summarizes data showing counts of variable (mpg & hp) for the values of cyl
cylData <- dcast(carMelt, cyl ~ variable, mean) ## summarizes data, now I've specified mean as the function, so provides mean of mpg and hp, by cylinder

head(InsectSprays)
tapply(InsectSprays$count,InsectSprays$spray, sum)
spIns <- split(InsectSprays$count, InsectSprays$spray)
sprCount <- lapply(spIns,sum)
unlist(sprCount)
## split - apply - combine methodology 

## to combine last two steps:
sapply(spIns,sum)

## from plyr pkg:
ddply(InsectSprays,.(spray),summarise,sum=sum(count)) ## summarize wasn't working but summarise did
ddply(InsectSprays,.(spray),summarise,sum=ave(count,FUN=sum)) ## ave matches the length of the input
spraySums <- ddply(InsectSprays,.(spray),summarise,sum=ave(count,FUN=sum))
dim(spraySums)

## DPLYR lecture
install.packages("dplyr")
library(dplyr)
chicago <- readRDS("chicago.rds")
dim(chicago)
str(chicago)
head(chicago)
names(chicago)
## dplyr select lets you use the names directly
head(select(chicago,city:dptp))
## the city:dptp notation won't work in base R
head(select(chicago,-(city:dptp))) ## selects all EXCEPT those noted
## to do in base r, have to get index of columns - use MATCH()
i <- match("city", names(chicago))
j <- match("dptp",names(chicago))
head(chicago[,-(1:3)])

chic.f <- filter(chicago,pm25tmean2>30)
head(chic.f, 10)
chic.f <- filter(chicago,pm25tmean2>30 & tmpd > 80) ## filter subsets rows based on conditional statement
head(chic.f, 10)

chicago <- arrange(chicago, date) ## arrange reorders data
chicago <- arrange(chicago, desc(date))
chicago <- rename(chicago, pm25 = pm25tmean2, dewpoint = dptp)

## mutate transforms variables or creates new
chicago <- mutate(chicago,pm25detrend = pm25-mean(pm25, na.rm = TRUE))
head(select(chicago, pm25, pm25detrend))

## group by splits data frame by categorical variables
chicago <- mutate(chicago,tempcat = factor(1*(tmpd>80),labels=c("cold","hot")))
head(chicago[chicago$tmpd>80,])

hotcold <- group_by(chicago,tempcat)
summarize(hotcold, pm25 = mean(pm25, na.rm=TRUE), o3 = max(o3tmean2), no2 = median(no2tmean2))
chicago <- mutate(chicago,year = as.POSIXlt(date)$year + 1900)
years <- group_by(chicago,year)
summarize(years, pm25 = mean(pm25, na.rm=TRUE), o3 = max(o3tmean2), no2 = median(no2tmean2))

## pipeline operator %>%; chain a bunch of operations in one sequence - readable and powerful (???)
chicago %>% mutate(month=as.POSIXlt(date)$mon + 1) %>% group_by(month) %>% summarize(pm25 = mean(pm25,na.rm=TRUE),o3 = max(o3tmean2),no2=median(no2tmean2))

## merging data
url1 <- "https://dl.dropboxusercontent.com/u/7710864/data/reviews-apr29.csv"
url2 <- "https://dl.dropboxusercontent.com/u/7710864/data/solutions-apr29.csv"
download.file(url1,destfile="./data/reviews.csv")
download.file(url2,destfile="./data/solutions.csv")
reviews <- read.csv("./data/reviews.csv")
solutions <- read.csv("./data/solutions.csv")
head(reviews,2); head(solutions,2)
## solution id in reviews relates to id in solutions csv
names(reviews)
names(solutions)

mergedData <- merge(reviews,solutions,by.x="solution_id",by.y="id",all=TRUE)
head(mergedData)

intersect(names(reviews),names(solutions)) ## shows what columns in both sets
mergedData2 = merge(reviews,solutions,all=TRUE) ## tries to merge on all common columns, no valid merges
dim(mergedData);dim(mergedData2)

## can also merge with "join" from plyr package
df1 = data.frame(id=sample(1:10),x=rnorm(10))
df2 = data.frame(id=sample(1:10),y=rnorm(10))
arrange(join(df1,df2),id) ## requires same column name in both data sets
df3 = data.frame(id=sample(1:10),z=rnorm(10))
dfList = list(df1,df2,df3)
join_all(dfList)
join_all(list(df1,df2,df3)) ## works as well
## the list option worked, others failed
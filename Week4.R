## Week 4 lectures for Getting and Cleaning Data
cameraData <- read.csv("cameras.csv") ## already had data from prior lecture
names(cameraData)
tolower(names(cameraData))
splitNames <- strsplit(names(cameraData),"\\.")
splitNames
splitNames[[5]]
splitNames[[6]]
## that split the strings if they had a period in them, creating Location and 1 for the sixth name Location.1

## Next we're doing a refresh on lists
mylist <- list(letters=c("A","B","C"),numbers = 1:3, matrix(1:25,ncol=5))
head(mylist)
## list has letters, numbers, and a matrix
mylist[1] ## returns first element of the list (letters)
mylist$letters ## same as above, using the named element
mylist[[1]] ## just the vector, not the vector and the name
## want to use the split string function and only keep the first portion of the variable name
firstelement <- function(x){x[1]}
sapply(splitNames,firstelement)

sapply(splitNames,tolower(firstelement))
sapply(splitNames,tolower(as.character(firstelement)))
## tried to force tolower into the sapply but got an error that said cannot coerce type 'closure' to vector of type 'character'

reviews <- read.csv("./data/reviews.csv") ## already had data
solutions <- read.csv("./data/solutions.csv") ## already had data
head(reviews, 2)
head(solutions, 2)
names(reviews)
sub("_","",names(reviews)) ## removes first "_" in column names
testname <- "this_is_a_test"
sub("_","",testname) ## replaces only first "_"
gsub("_","",testname) ## replaces all "_"

grep("Alameda",cameraData$intersection) ## find Alameda in intersection column, provides locations
table(grepl("Alameda",cameraData$intersection)) ## table of TRUE/FALSE for whether Alameda found
## grepl is boolean, table was FALSE 77, TRUE 3
cameraData2 <- cameraData[!grepl("Alameda",cameraData$intersection),] ## subset to only where Alameda is not in the intersection

grep("Alameda",cameraData$intersection, value=TRUE)
## that returned the value, rather than the location
grep("JeffStreet",cameraData$intersection) ## integer(0)
length(grep("JeffStreet",cameraData$intersection)) ## length was zero. This gives an easy way to check for certain values

library(stringr)
nchar("Jeffrey Leek") ## number of chars, 13
substr("Jeffrey Leek",1,7) ## substring, with string, start, and numchars, "Jeffrey"
paste("Jeffrey","Leek") ## pastes together, "Jeffrey Leek"
paste0("Jeffrey","Leek") ## paste with no spaces, without needing sep=""
str_trim("Jeff        ") ## trims trailing spaces; also trims leading spaces apparently

## Moving to lecture 2, Regular Expressions
## nothing from Reg Expressions in R

## Moving to lecture 4, Working with Dates
d1 = date()
d1
class(d1) ## character
d2 = Sys.Date()
d2
class(d2) ## Date
## date() returns char, Sys.Date() returns Date class
format(d2,"%a %b %d") ## list of date formats in notes

x <- c("1jan1960","2jan1960","31mar1960","30jul1960")
z <- as.Date(x, "%d%b%Y")
z
class(z) ## Date
class(z[4])
z[1]-z[2] ## time difference of -1 days
as.numeric(z[1]-z[2]) ## -1

weekdays(d2)
months(d2)
julian(d2) ## number of days since origin, 1970-01-01

library(lubridate)
ymd("20141008")
mdy("08/04/2013")
dmy("03-04-2013")
ymd_hms("2011-08-03 10:15:03")
ymd_hms("2011-08-03 10:15:03", tz="Pacific/Auckland")
?Sys.timezone
Sys.timezone() ## America/Los Angeles

wday(z[1]) ## 6
wday(z[1],label=TRUE) ## Fri
## label adds abbreviated weekday label ("Fri")
class(dmy("03-04-2013"))
## want dates to be class POSIXct or POSIXlt. See ?POSIXlt for more info
?POSIXlt
## will be relevant in prediction class, modeling with dates
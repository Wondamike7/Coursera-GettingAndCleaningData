library(httr)
install.packages("httpuv")
install.packages("Rcpp")
library(httpuv)
library(Rcpp)

## question 1
## all of the below taken from the instructions, using my own content key and secret, obviously
## I still have very little idea what this was all about...
oauth_endpoints("github")
myapp <- oauth_app("github", "b2986969b8bfd7bbaa78","my secret")
github_token <- oauth2.0_token(oauth_endpoints("github"), myapp)
gtoken <- config(token = github_token)

## access the specific API provided using my token
req <- GET("https://api.github.com/users/jtleek/repos", gtoken)
content <- content(req)
library(jsonlite)
clean <- fromJSON(toJSON(content)) ## turn the concent from the API into a clean JSON frame
clean
names(clean)
clean$full_name ## to see the specific values and find my example
clean[c("full_name","created_at")]
clean[5,c("full_name","created_at")] ## jtleek / datasharing 2013-11-07T13:25:07Z

## question 2 & 3
acs <- read.csv("getdata_data_ss06pid.csv")
install.packages("sqldf")
library(sqldf)
sqldf("select pwgtp1 from acs where AGEP < 50") ## just verifying that the one I thought was correct worked
unique(acs$AGEP)
sqldf("select distinct AGEP from acs") ## just verifying again

## Question 4
?nchar
con <- url("http://biostat.jhsph.edu/~jleek/contact.html") ## the con thing didn't work for me, not sure why

readLines("http://biostat.jhsph.edu/~jleek/contact.html") ## this worked, when I put the url right in there rather than trying to open up a connection
x <- readLines("http://biostat.jhsph.edu/~jleek/contact.html")
nchar(x,type="chars")
z <- nchar(x,type="chars")
z[c(10,20,30,100)] ## 45 31 7 25

## Question 5
install.packages("readr") ## internet search said this would be a better package for reading in a fixed-width file like .for
library(readr)

?read_fwf
a <- fwf_empty("getdata_wksst8110.for",skip=4,col_names=NULL) ## I think this tries to guess at where the columns start/stop
## it didn't work very well, because the columns touched up against each other

read_fwf("getdata_wksst8110.for",a) ## forgot to specify the skip again

## used fwf_positions to specify the start and end, rather than using fwf_empty
## I opened the data in Notepad++ and used the column count shown at bottom to figure out what I wanted
data <- read_fwf("getdata_wksst8110.for",fwf_positions(c(29,59),c(32,62)),skip=4) ## Only read in columns 4 & 9 (only needed column 4)
data ## first time I had the wrong end-columns, looking at the data made it pretty obvious
sum(data$X1+data$X2) ## I was reading the question incorrectly and thought it wanted the sum of 4th and 9th columns, but it just wanted 4th
sum(data$X1) ## 32426.7
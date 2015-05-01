## Reading data from MySQL
install.packages("RMySQL")
library(RMySQL)

## connect to genome database and get query (MySQL command line)
ucscDb <- dbConnect(MySQL(),user="genome",host="genome-mysql.cse.ucsc.edu")
result<- dbGetQuery(ucscDb,"show databases;"); dbDisconnect(ucscDb)
result ## printed a list of 199 databases

## connect to specific table
hg19 <- dbConnect(MySQL(),user="genome",db="hg19",host="genome-mysql.cse.ucsc.edu")
allTables <- dbListTables(hg19)
length(allTables) ## 11012
allTables[1:5] ## listed first five tables

dbListFields(hg19,"affyU133Plus2") ## listed fields (columns) for specified table
dbGetQuery(hg19,"select count(*) from affyU133Plus2")
affyData <- dbReadTable(hg19, "affyU133Plus2")
warnings() ## 16 warnings in reading the table, all about INTEGERs
head(affyData)
query <- dbSendQuery(hg19, "select * from affyU133Plus2 where misMatches between 1 and 3")
small <- fetch(query, n=10)
head(small)
dim(small)
summary(small$misMatches) ## checks that the query acted properly

dbClearResult(query) ## have to clear query - not sure why
dbDisconnect(hg19) ## always remember to disconnect

## Reading data from HDF5
source("http://bioconductor.org/biocLite.R")
biocLite("rhdf5")
library(rhdf5)
created = h5createFile("example.h5")
created ## TRUE
created = h5createGroup("example.h5","foo")
created = h5createGroup("example.h5","baa")
created = h5createGroup("example.h5","foo/foobaa")
h5ls("example.h5") ## lists the three groups

## creating matrix to write to h5 group
A = matrix(1:10, nr=5, nc=2)
h5write(A, "example.h5","foo/A")
B = array(seq(0.1,2.0,by=0.1),dim=c(5,2,2))
attr(B,"scale")<-"liter"
h5write(B, "example.h5","foo/foobaa/B")
h5ls("example.h5")

## writing a data frame to the top-level group
df = data.frame(1L:5L, seq(0,1,length.out=5),
c("ab","cde","fghi","a","s"),stringsAsFactors=FALSE)
h5write(df,"example.h5","df") ## the third argument here isn't a group, so it gets stored in the top-level group with the arg as its name
h5ls("example.h5")

readA = h5read("example.h5","foo/A")
readA
readB = h5read("example.h5","foo/foobaa/B")
readB
h5write(c(12,13,14),"example.h5","foo/A",index=list(1:3,1)) ## wrote the values in the first three rows of the first column of A
h5read("example.h5","foo/A")

## moving on to "Reading data from the Web"
con = url("http://scholar.google.com/citations?user=HI-I6C0AAAAJ&hl=en")
htmlCode <- readLines(con)
close(con)
htmlCode
library(XML)
url <- "http://scholar.google.com/citations?user=HI-I6C0AAAAJ&hl=en"
html <- htmlTreeParse(url, useInternalNodes=TRUE)
xpathSApply(html,"//title",xmlValue)
xpathSApply(html,"//td[@class='gsc_a_c']",xmlValue) ## had a lot of trouble replicating this. Need to better understand XML and how to use this parser

library(httr)
html2 <- GET(url)
content2 <- content(html2, as="text")
content2 ## one long line of text
parsedHtml <- htmlParse(content2,asText=TRUE)
parsedHtml ## table of text, like in XML
xpathSApply(parsedHtml,"//title",xmlValue)
xpathSApply(parsedHtml,"//td[@class='gsc_a_c']",xmlValue)

## just playing with the results, turning the text returned into values. 
## The 18th value (which happened to be 18) had an asterisk, which I replaced with the real number manually
c <- as.numeric(xpathSApply(parsedHtml,"//td[@class='gsc_a_c']",xmlValue))
c
c[18]<-18
c

pg2 = GET("http://httpbin.org/basic-auth/user/passwd",authenticate("user","passwd"))
pg2
names(pg2)
## I didn't really track the names from pg2, but it must have something to do with what GET returns
## tried to use names for other thigns - html, parsedHTML, but all were NULL

## moving on to the APIs portion
## don't have twitter account, so didn't follow the lecture in the code
## nothing to track from the other sources lecture
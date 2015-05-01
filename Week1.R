## Practice using data.table
library(data.table)
DT <- data.table(x=rnorm(9),y=rep(c("a","b","c"),each=3),z=rnorm(9))
DT
DT[2,]
DT[2]
DT[2:4]
DT[2:4,]
DT[,2]
DT[,x]
DT[,y]
DT[,table(y)]
DT[,sum(z)]
DT[,summary(z)]
DT[,list(summary(x),summary(z))]
DT[,w:=z^2]

DT1 <- data.table(x=c('a','a','b','dt1'),y=1:4)
DT1
DT2 <- data.table(x=c('a','b','dt2'),z=5:7)
DT2
setkey(DT1,x) ## what did this do???
setkey(DT2,x)
DT1['a']
DT2['a']
merge(DT1,DT2)
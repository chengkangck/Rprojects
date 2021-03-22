# case sensitive
x <- 1 # assignment
x <- 1:20

class(1)
class(1L)
?class

Inf
1/0
1/Inf
NaN

# Vector
x <- vector("character", length = 10)
x <- c(1,2,3)
x <- c(1+2i, 3+4i)

x <- c(TRUE,10,"a")
x <- c(FALSE, 10)

x <- 0:10
class(x)
as.logical(x)
as.numeric(x)
as.character(x)

x <- c("a","b")
as.numeric(x)

# vector's name
x <- 1:4
names(x)
names(x) <- c("a","b","c","d")
names(x)


# Matrix
x <- matrix(nrow = 3, ncol = 2)
dim(x)
attributes(x)

x <- matrix(1:10, nrow=5, ncol=2)

x <- 1:6
x
dim(x) <- c(2,3)
x

x <- 1:4
y <- 5:8
cbind(x,y)
rbind(x,y)

# array
x <- array(1:24, dim = c(4,6))
x <- array(1:24, dim = c(2,3,4))

# List
x <- list("a", 2, 10L, 3+4i, TRUE)
x <- list(1,2,3,4)
x <- list(a=1,b=2,c=3,d=4)
x <- list(c("a","b"),c("c","d","e"))

x <- matrix(1:6, nrow=2, ncol=3)
dimnames(x) <- list(c("a","b"),c("c","d","e"))

# Factor

x <- factor(c("female","male","male","female","female"))
x <- factor(c("female","male","male","female","female"), levels = c("male","female"))

table(x)
unclass(x)
class(unclass(x))

# Missing Value

x <- c(1, NA, 2, NA, 3)
is.na(x)
is.nan(x)

x <- c(1, NaN, 2, NaN, 3)
is.na(x)
is.nan(x)


# data frame

x <- data.frame(id = c(1:4), name = c("a","b","c","d"), gender = c(T,T,F,F))

nrow(x)
ncol(x)

data.matrix(x)

# Date & Time
x <- date()
class(x)
x <- Sys.Date()
class(x)

x <- as.Date("1970-01-01")
y <- as.Date("2015-01-01")
x-y
as.numeric(x-y)

weekdays(y)
months(y)
quarters(y)
julian(y)

x <- Sys.time()

p <- as.POSIXlt(x)
names(unclass(p)) # returns its argument with its class attribute removed
p$sec
p$min


p <- as.POSIXct(x)
unclass(x)

# in case dates are written in a different format
dstr <- c("Jan 1, 2015 01:01", "Dec 31, 2015 11:59")
dstr
x <- strptime(dstr, "%B %d, %Y %H:%M")
x

x <- as.Date("2015-01-01")
y <- strptime("Jan 1, 2014 01:01:01", "%B %d, %Y %H:%M:%S")
x-y
x <- as.POSIXlt(x)
x-y








#-----------------------------------------------------------------
# subsetting

x <- 1:10
x[1]
x[2]
x[1:5]
x[x>5]
x>5
x[x>5 & x<7]
x[x<3 | x>7]

x <- 1:4
names(x) <- c("a","b","c","d")
x["b"]

# subsetting a matrix
x <- matrix(1:6, nrow=2, ncol=3)
x[1,2]
x[2,1]
x[1,]
x[,1]
x[,c(1,3)]

x[1,2]
x[1,2, drop=FALSE]

x[1,]
x[1,, drop=FALSE]

# subsetting data frame

x <- data.frame(v1=1:5, v2=6:10, v3=11:15)
x <- x[sample(1:5),]
x$v3[c(2,4)] = NA

x[,2]
x[,"v2"]
x[1:3,"v3"]
x[(x$v1<4 & x$v2>=8),]
x[(x$v1<4 | x$v2>=8),]

x[which(x$v1>2),]
x[x$v1>2,]

# subsetting vector, matrices, data frames
subset(x,x$v1>2)

# subsetting list

x <- list(id=1:4, height=170, gender="male")
x[1]
x["id"]
x[[1]]
x[["id"]]
x$id

x[c(1,3)]

y <- "id"
x[[y]] # [[]] can be used with computed indices
x$y
x$id #$ only literal names

# subsetting nested elements of a list
x <- list(a = list(1,2,3,4), b=c("Monday","Tuesday"))

x[[c(1,3)]]
x[[1]][[3]]
x[[1]][3]
x[[c(2,2)]]


# partial matching

x <- list(asdfghj = 1:10)
x$a
x[["a"]]
x[["a", exact = FALSE]]

x <- list(asdfghj = 1:10, b = 1:2, aaa = 3:5)
x$a
x[["a", exact=FALSE]]
x$as

# removing NA values

x <- c(1, NA, 2, NA, 3)
b <- is.na(x)
x[!b]

x <- c(1, NA, 2, NA, 3)
y <- c("a","b",NA,"c",NA)
z <- complete.cases(x,y)
z
x[z]
y[z]

library(datasets)
head(airquality)
tail(airquality)
dim(airquality)
attributes(airquality)
g <- complete.cases(airquality)

airquality[g,][1:10,]

# Vectorized

x <- 1:5
y <- 6:10
x+y
x*y
x/y

x < 3
y == 7

x <- matrix(1:4, nrow=2, ncol=2)
y <- matrix(rep(2,4), nrow=2, ncol=2)
x*y
x/y
x %*% y # true matrix multiplication



#-----------------------------------------------------------------
# lapply
lapply # if x is not a list, then as.list(x)
str(lapply)

x <- list(a=1:10, b=c(11,21,31,41,51))
lapply(x,mean)

x <- 1:4
lapply(x, runif)
lapply(x, runif, min=0, max=100)

# make heavy use of anonymous functions
x <- list(a=matrix(1:6,2,3), b=matrix(4:7,2,2)) 
lapply(x, function(m) m[1,])

# sapply
x <- list(a=1:10, b=c(11,21,31,41,51))
lapply(x,mean)
sapply(x,mean)

# apply
x <- matrix(1:16, 4, 4)
apply(x,2,mean) #apply mean to columns
apply(x,1,sum) # apply sum to rows

apply(x,1,sum) # rowSums
rowSums(x) # much faster
apply(x,1,mean) # rowMeans
rowMeans(x)
apply(x,2,sum) # colSums
colSums(x)
apply(x,2,mean) #colMeans
colMeans(x)

x <- matrix(rnorm(100),10,10)
apply(x, 1, quantile, probs=c(0.25,0.75))

x <- array(rnorm(2*3*4), c(2,3,4))
apply(x,c(1,2),mean)
apply(x,c(1,3),mean)
apply(x,c(2,3),mean)

# mapply
list(rep(1,4),rep(2,3),rep(3,2),rep(4,1))
mapply(rep, 1:4, 4:1)

x <- function(n,mean,std){
        rnorm(n,mean,std)
}

x(4,0,1)

mapply(x, 1:5, 5:1, 2)
# equals to
list(x(1,5,2),x(2,4,2),x(3,3,2),x(4,2,2),x(5,1,2))

# tapply
x <- c(rnorm(5), runif(5), rnorm(5,1))
f <- gl(3,5)
tapply(x,f,mean)
tapply(x,f,mean, simplify=FALSE)
tapply(x,f,range)

# split
x <- c(rnorm(5), runif(5), rnorm(5,1))
f <- gl(3,5)
split(x,f)
lapply(split(x,f),mean)

# split a data frame
head(airquality)
s <- split(airquality, airquality$Month)
lapply(s, function(x) colMeans(x[,c("Ozone","Wind","Temp")]))
table(airquality$Month)

sapply(s, function(x) colMeans(x[,c("Ozone","Wind","Temp")]))
sapply(s, function(x) colMeans(x[,c("Ozone","Wind","Temp")],na.rm=TRUE))

# split on more than one level
x <- runif(10)
f1 <- gl(2,5)
f2 <- gl(5,2)
interaction(f1,f2)
str(split(x, list(f1,f2))) # interaction can create empty levels
str(split(x, list(f1,f2), drop=TRUE)) # empty levels can be dropped

# sorting
x <- data.frame(v1=1:5, v2=c(10,7,9,6,8), v3=11:15, v4=c(1,1,2,2,1))
x <- x[sample(1:5),]
x$v3[c(2,4)] = NA

sort(x$v1)
sort(x$v1, decreasing = TRUE)
sort(x$v3)
sort(x$v3, na.last=TRUE)

# ordering
x[order(x$v2),]
x[sort(x$v2),]

x[order(x$v4,x$v2),]
x[order(x$v4,x$v2,decreasing = TRUE),]

# summarize data
head(airquality)
tail(airquality)
head(airquality,10)

summary(airquality)
str(airquality)

quantile(airquality$Wind, na.rm=TRUE)
quantile(airquality$Wind, probs=c(0.6,0.8), na.rm=TRUE)

table(airquality$Month)
table(airquality$Ozone, useNA = "ifany")
table(airquality$Month,airquality$Day)

any(is.na(airquality$Ozone))
any(is.na(airquality$Month))
sum(is.na(airquality$Ozone))
all(airquality$Month<12) # are all values true?
all(airquality$Month<7) 
 
colSums(is.na(airquality))
all(colSums(is.na(airquality))==0)

table(airquality$Month)
table(airquality$Month %in% c(5,6))

airquality[airquality$Month %in% c(5,7),]

titanic <- as.data.frame(Titanic)
head(titanic)
dim(titanic)
summary(titanic)

xtabs(Freq ~ Class + Age, data=titanic)

x <- xtabs(Freq ~ Class + Age + Sex, data=titanic)
ftable(x) # flat table

# size of dataset
object.size(airquality)
print(object.size(airquality), units="Kb")

# calculate mean, median, variance, and standard variance
x <- c(1,9,2,8,3,9,4,5,7,6)
mean(x)
median(x)
var(x)
sd(x)
summary(x)

#-----------
library(RColorBrewer)
cols <- brewer.pal(3,"Accent")
pal <- colorRampPalette(cols)
library(lattice)
## histogram and dotplot
x <- rnorm(1000)
histogram(x, col=pal(1), breaks=50)
library(ggplot2)
ggplot(airquality, aes(x = Wind)) + 
        geom_dotplot(col=pal(1),fill=pal(1), binwidth=0.5) +
        theme_classic()
## boxplot
cols <- brewer.pal(3,"Pastel1")
pal <- colorRampPalette(cols)
boxplot(Temp~Month, data=airquality, col=pal(1))
boxplot(airquality$Temp, col=pal(1))

## scatter plot
set.seed(1)
x <- rnorm(100)
y1 <- rnorm(100)
y2 <- 2*x
y2[73] <- 5
y3 <- -3*x
y4 <- x*x
par(mfrow=c(2,4))
plot(x,y1, pch=19, col=pal(1))
plot(x,y2, pch=19, col=pal(1))
plot(x,y3, pch=19, col=pal(1))
plot(x,y4, pch=19, col=pal(1))
smoothScatter(x,y1)
smoothScatter(x,y2)
smoothScatter(x,y3)
smoothScatter(x,y4)

# Categorical Variable
df <- data.frame(Etype = c("Tornado","Excessive Heat","Flash Flood",
                           "Heat","Lightning","TSTM Wind"), Count = c(5633,1903,978,937,816,504))
barplot(height=df$Count, names.arg=df$Etype, col=heat.colors(10))

library(UsingR)
data(Titanic)
str(Titanic)
class(Titanic) # table
Titanic[1,,,]
Titanic[,1,,]
Titanic[,,1,]
Titanic[,,,1]

seqs <- brewer.pal(4,"Accent")
df2 <- data.frame(low=c(128,54,17,3),middle=c(63,71,7,6),high=c(31,61,27,6))
barplot(as.matrix(df2),col=seqs,xlab = "Income")
legend("topright",legend=c("not at all","not very","somewhat", "very"),fill=seqs[4:1])

df3 <- data.frame(low=c(128,54,17,3)/202,middle=c(63,71,7,6)/147,high=c(31,61,27,6)/125)
barplot(as.matrix(df3),col=seqs,
        xlab = "Income", xlim = c(0,7), width=1.5,
        legend=c("not at all","not very","somewhat", "very"))

df4 <- data.frame(very=c(128,63,31),somewhat=c(54,71,61),
                  "not very"=c(17,7,27),"not at all"=c(3,6,6))
rownames(df4) <- c("low","middle","high")
## mosaicplot need a contingency table
mosaicplot(df4,color=seqs,main="",las=1)

#------------

# Base Plot
hist(airquality$Temp) # draw a new plot; histogram
with(airquality, plot(Wind,Temp)) # scatter plot
boxplot(Temp~Month, airquality, xlab = "Month", 
        ylab = "Temp (mph)")

## examples: base graphics parameters
par("bg")
par("col")
par("mar") # (bottom, left, top, right)
par("mfrow")
par(mfrow = c(1,2))
hist(airquality$Temp)
hist(airquality$Wind)
par(mfrow = c(1,1))

## Examples: Base Plotting Functions
with(airquality, plot(Wind,Temp))
### add a title
title(main="Wind and Temp in NYC")
with(airquality, plot(Wind,Temp,main="Wind and Temp in NYC"))
### add points
with(subset(airquality, Month==9), 
     points(Wind,Temp,col="red"))

### Step by step
with(airquality, plot(Wind,Temp,
     main="Wind and Temp in NYC", type = "n"))
with(subset(airquality, Month==9), 
     points(Wind,Temp,col="red"))
with(subset(airquality, Month==5), 
     points(Wind,Temp,col="blue"))
with(subset(airquality, Month %in% c(6,7,8)), 
     points(Wind,Temp,col="black"))

fit <- lm(Temp ~ Wind, airquality) # fit a model
abline(fit,lwd=2)

legend("topright", pch=1, col=c("red","blue","black"), 
       legend=c("Sep","May","Other"))

## mulitple base plots
par(mfrow = c(1,2), mar=c(4,4,2,1), oma=c(0,0,2,0))
with(airquality, {
     plot(Wind,Temp,main="Wind and Temp")
     plot(Ozone, Temp, main="Wind and Temp")
     mtext("Temp and Weather in NYC", outer=TRUE)
})

# mar: inner margin (in lines of text) 
# oma: outer margin (in lines of text)
par(mfrow=c(1,1), mar=c(4,4,2,1), oma=c(2,2,2,2))
hist(airquality$Ozone)
mtext("Test", outer=TRUE)


# Graphics Devices
## open PDF device; create myfig.pdf in working directory
pdf(file = "myfig.pdf")
getwd()
## create plot and send to the file
with(airquality, plot(Wind,Temp,main="Wind and Temp in NYC"))
dev.off()

## copy plots
with(airquality, plot(Wind,Temp,main="Wind and Temp in NYC"))
dev.copy(png, file="mycopy.png")
dev.off()


# Lattice Plot
library(lattice)
## simple scatterplot
xyplot(Temp ~ Wind, data = airquality)
## convert Month to a factor
airquality$Month <- factor(airquality$Month)
xyplot(Temp ~ Wind | Month, data = airquality,
       layout = c(5, 1))

q <- xyplot(Temp ~ Wind, data = airquality)
print(q)
xyplot(Temp ~ Wind, data = airquality) # auto-printing

## Lattice Panel Functions
set.seed(1)
x <- rnorm(100)
f <- rep(0:1, each = 50)
y <- x + f - f * x  + rnorm(100, sd = 0.5)
f <- factor(f, labels = c("Group 1", "Group 2"))
xyplot(y ~ x | f, layout = c(2, 1)) ## Plot with 2 panels

## Custom panel function
xyplot(y ~ x | f, panel = function(x, y) {
        panel.xyplot(x, y) # call the default panel function
        panel.abline(v = mean(x), h = mean(y), lty = 2) # add lines
        panel.lmline(x, y, col = "red") # overlay a simple linear regression line
})

## other plots
barchart(Day ~ Temp | Month, data = airquality,
         layout = c(5, 1))

bwplot(Temp ~ Month, data = airquality)
dotplot(Temp ~ Month, data = airquality)
stripplot(Temp ~ Month, data = airquality)
histogram(airquality$Ozone)


# ggplot2 Plot
library(ggplot2)
qplot(Wind, Temp, data = airquality) # x,y,data
## modify aesthetics
qplot(Wind, Temp, data = airquality, color=Month)
## note: factors are important for indicating
## subsets of the data
airquality$Month <- factor(airquality$Month)
## color/shape/legend
qplot(Wind, Temp, data = airquality, color=Month)
qplot(Wind, Temp, data = airquality, shape=Month)

## add a geom
qplot(Wind, Temp, data = airquality,
      geom = c("point","smooth"), method="lm")
qplot(Wind, Temp, data = airquality, color=Month,
      geom = c("point","smooth"), method="lm")
## Facets
qplot(Wind, Temp, data = airquality,
      geom = c("point","smooth"), method="lm",
      facets = .~Month)
## histogram
qplot(Wind, data = airquality)
qplot(Wind, data = airquality[airquality$Month==7,])
## stacked
qplot(Wind, data = airquality, fill=Month)
qplot(Wind, data = airquality, geom = "density")
qplot(Wind, data = airquality, geom = "density",
      color=Month)
## Facets
qplot(Wind, Temp, data = airquality, facets = .~Month)
qplot(Wind, Temp, data = airquality, facets = Month~.)
qplot(Wind, data = airquality, facets = Month~., binwidth=2)

## build up in layers
head(airquality)
g <- ggplot(airquality, aes(Wind,Temp))
summary(g)
print(g)
p <- g + geom_point()
print(p)
g + geom_point() # auto print

## First plot with Point layer
g <- ggplot(airquality, aes(Wind,Temp))
g + geom_point()
## Add a layer: smooth
g + geom_point() + geom_smooth(method="lm")
# Add a layer: facets
g + geom_point() + geom_smooth(method="lm") + 
    facet_grid(.~Month)

## Modify aesthetics
g + geom_point(color="steelblue", size=4, alpha=0.6)
## do not forget aes which describes how variables
## in the data are mapped to visual properties of geoms
g + geom_point(aes(color=Month), size=4, alpha=0.6)
## Modify labels
g + geom_point(aes(color=Month), size=4, alpha=0.6) + 
        labs(title="Temp vs. Wind", x="Wind (mph)", 
             y="Temperature")
## Modify smooth
g + geom_point(aes(color=Month), size=4, alpha=0.6) +
        geom_smooth(method="lm",se=FALSE,
                    linetype=3, size=2)

## change the theme
g + geom_point(aes(color=Month), size=4, alpha=0.6) +
        theme_classic()

## axis limits
test <- data.frame(x=1:50, y=sin(1:50))
plot(test$x,test$y,type="l",ylim=c(-2,2))
test[25,2] <- 50 # outlier
plot(test$x,test$y,type="l",ylim=c(-2,2))

g <- ggplot(test,aes(x=x, y=y))
g + geom_line()
g + geom_line() + ylim(-2,2) # outlier missing
g + geom_line() + coord_cartesian(ylim=c(-2,2))


# How does the relationship between Ozone and Temp
# vary by Month (categorical) and Wind (numerical)
cutpoints <- quantile(airquality$Wind, seq(0,1,length=3), na.rm=TRUE)
## cut the data and create a new factor variable
airquality$Wind2 <- cut(airquality$Wind, cutpoints)
## see the levels
levels(airquality$Wind2)
## plot
good <- complete.cases(airquality)
g <- ggplot(airquality[good,], aes(Ozone,Temp))
g + geom_point(size=3,alpha=0.6) + 
    facet_wrap(Month ~ Wind2, nrow=5, ncol=2) +
    geom_smooth(method="lm",se=FALSE,aes(color=Month)) +
    theme_bw(base_family="Times", base_size=14) +
    labs(title="Airquality")

# R Color
par(mfrow=c(1,1))
plot(airquality$Temp, col=airquality$Month, pch=19)

devAskNewPage(ask=FALSE)
n <- 10
r <- rainbow(n, s = 1, v = 1, start = 0, end = max(1, n - 1)/n, alpha = 1)
image(volcano, col = r)

h <- heat.colors(n, alpha = 1)
image(volcano, col = h)

ter <- terrain.colors(n, alpha = 1)
image(volcano, col = ter)

topo <- topo.colors(n, alpha = 1)
image(volcano, col = topo)

cm <- cm.colors(n, alpha = 1)
image(volcano, col = cm)


## colorRamp
pal <- colorRamp(c("red","blue"))
pal(0) # red
pal(1) # blue
pal(0.5) # green
pal(seq(0,1,len=10))

## colorRampPalette
pal <- colorRampPalette(c("red","yellow"))
pal(1)
pal(2)
pal(10)

## RColorBrewer and colorRampPalette
library(RColorBrewer)
brewer.pal.info
# make ColorBrewer palette available as R paletter
cols <- brewer.pal(3,"Greens")
pal <- colorRampPalette(cols)
image(volcano, col = pal(20))
## smoothScatter: colramp use colorRampPalette
x <- rnorm(1000)
y <- rnorm(1000)
par(mfrow=c(1,2))
plot(x,y)
smoothScatter(x,y, colramp = pal)

## create a sequential palette for usage and show colors
mypalette<-brewer.pal(7,"Greens")
image(1:7,1,as.matrix(1:7),col=mypalette,xlab="Greens (sequential)",
      ylab="",xaxt="n",yaxt="n",bty="n")
display.brewer.pal(7,"Greens")

## display a divergent palette
display.brewer.pal(7,"BrBG")
devAskNewPage(ask=TRUE)
## display a qualitative palette
display.brewer.pal(7,"Accent")
## display a palettes simultanoeusly
display.brewer.all(n=10, exact.n=FALSE)
display.brewer.all(n=10)
display.brewer.all()
display.brewer.all(type="div")
display.brewer.all(type="seq")
display.brewer.all(type="qual") 
display.brewer.all(n=5,type="div",exact.n=TRUE)
display.brewer.all(colorblindFriendly=TRUE)
brewer.pal.info
brewer.pal.info["Blues",]
brewer.pal.info["Blues",]$maxcolors

## some other plotting notes
### 1. The rgb function can be used to produce any
### color via red, green, blue proportions
### 2. Color transparency can be added via the alpha parameter to rgb
### 3. The colorspace package can be used for a different control over colors
x <- rnorm(100)
y <- rnorm(100)
par(mfrow=c(1,2))
plot(x,y,pch=19)
plot(x,y,pch=19,col=rgb(0,0,1,0.2))






temp5 <- subset(airquality$Temp,airquality$Month==5)
boxplot(temp5)
boxplot(airquality$Temp~airquality$Month)
hist(airquality$Ozone)


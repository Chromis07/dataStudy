library(MASS)
library(ISLR)
data(Boston)
dim(Boston)
.libPaths()
install.packages("ISLR")

fix(Boston)
View(Boston)
?Boston
names(Boston)
lm.fit=lm(medv~lstat)
lm.fit=lm(medv~lstat, data=Boston)
attach(Boston)
lm.fit=lm(medv~lstat)
lm.fit
summary(lm.fit)
names(lm.fit)
coef(lm.fit)
confint(lm.fit)
predict(lm.fit, data.frame(lstat=c(5,10,15)), interval="confidence")
predict(lm.fit, data.frame(lstat=c(5,10,15)), interval="prediction")
plot(lstat, medv)

help(abline)
abline(lm.fit)
abline(lm.fit,lwd=3)
abline(lm.fit,lwd=3,col="red")
plot(lstat,medv,col="red")
plot(lstat,medv,pch=20)
plot(lstat,medv,pch="+")
plot(1:20,1:20,pch=1:20)
par(mfrow=c(2,2))
plot(lm.fit)
plot(predict(lm.fit),residuals(lm.fit))
plot(predict(lm.fit),rstudent(lm.fit))

lm.fit=lm(medv~lstat+age,data=Boston)
summary(lm.fit)


install.packages("car")
library(car)
data(car)
dim(car)
vif(lm.fit)
lm.fit1=lm(medv~.-age,data=Boston)
summary(lm.fit1)
summary(lm(medv~lstat*age, data=Boston))

help(I)
lm.fit2=lm(medv~lstat+I(lstat ^2))
summary(lm.fit2)

lm.fit=lm(medv~lstat)
anova(lm.fit,lm.fit2)
par(mfrow=c(2,2))
plot(lm.fit2)
lm.fit5=lm(medv~poly(lstat,5))
summary(lm.fit5)
lm.fit6=lm(medv~poly(lstat,6))
summary(lm.fit6)
summary(lm(medv~log(rm),data=Boston))


fix(Carseats)
data(Carseats)
names(Carseats)
lm.fit=lm(Sales~.+Income:Advertising+Price:Age, data=Carseats)

attach(Carseats)
contrasts(ShelveLoc)

LoadLibraries=function(){
  library(ISLR)
  library(MASS)
  print("The libraries have been loaded.")
  }

LoadLibraries
LoadLibraries()
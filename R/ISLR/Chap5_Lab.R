library(ISLR)
set.seed(1)
?sample

# 196개 랜덤
idx.train=sample(392,196)
#fit training data set
lm.fit=lm(mpg~horsepower ,data=Auto ,subset=idx.train)
attach(Auto)
mean((mpg -predict (lm.fit ,Auto))[-idx.train ]^2)

lm.fit2=lm(mpg~poly(horsepower ,2),data=Auto , subset=idx.train)
mean((mpg -predict (lm.fit2 ,Auto ))[- idx.train]^2)

lm.fit3=lm(mpg~poly(horsepower ,3),data=Auto , subset=idx.train)
mean((mpg -predict (lm.fit3 ,Auto ))[- idx.train]^2)

#LOOCV
rm(list=ls())
# cv를 사용하려면 glm 필요
glm.fit=glm(mpg~horsepower, data=Auto)
coef(glm.fit)

library(boot)
glm.fit=glm(mpg~horsepower, data=Auto)
cv.err=cv.glm(Auto,glm.fit)
# 여러가지 에러가 나오지만, >delta값< 중요
summary(cv.err)
# 두 개의 값이 거의 비슷
cv.err$delta

cv.error=rep(0,5)
for (i in 1:5){
  glm.fit=glm(mpg~poly(horsepower,i), data=Auto)
  cv.error[i]=cv.glm(Auto,glm.fit,K=10)$delta[1]
  }
cv.error

# K-fold cross validation
set.seed(17)
cv.error.10=rep(0.10)
for (i in 1:10){
  glm.fit = glm(mpg~poly(horsepower,i),data=Auto)
  cv.error.10[i]=cv.glm(Auto,glm.fit,K=10)$delta[1]
}
cv.error.10
plot(cv.error.10,type='o')
glm.fit=glm(mpg~poly(horsepower,6),data=Auto)

# Bootstrap
alpha.fn=function(data,index){
  X=data$X[index]
  Y=data$Y[index]
  return((var(Y)-cov(X,Y))/(var(X)+var(Y)-2*cov(X,Y)))
}

alpha.fn(Portfolio,1:100)
set.seed(1)
alpha.fn(Portfolio,sample(100,100,replace=T))

library(boot)
# 1000번 반복
boot(Portfolio,alpha.fn,R=1000)

# 다른 boot funtion 정의
boot.fn=function (data ,index)
  return(coef(lm(mpg~horsepower ,data=data , subset=index)))
boot.fn(Auto,1:392)

set.seed(1)
boot.fn(Auto,sample(392,392,replace=T))
boot.fn(Auto,sample(392,392,replace=T))

boot(Auto,boot.fn,1000)
summary(lm(mpg~horsepower,data=Auto))$coef
boot.fn=function(data,index)
coefficients(lm(mpg~horsepower+I(horsepower^2),data=data,
                subset=index))
set.seed(1)
boot(Auto,boot.fn,1000)
summary(lm(mpg~horsepower+I(horsepower ^2),data=Auto))$coef
library(ISLR)

names(Smarket)
?Smarket
dim(Smarket)
summary(Smarket)

cor(Smarket)
?cor

View(Smarket) 
cor(Smarket[,-9])
# 9번째변수가 숫자가 아니니 제외

attach(Smarket)
plot(Volume)
# x축은 데이터 순서

glm.fit=glm(Direction~Lag1+Lag2+Lag3+Lag4+Lag5+Volume,
            data=Smarket,family=binomial)
summary(glm.fit)
#Logistic regression 사용함

coef(glm.fit)
summary(glm.fit)$coef

glm.probs =predict(glm.fit, type = "response")
# 확률예측
glm.probs [1:10]
# 데이터가 많으니까 1~10까지만 표출
contrasts(Direction)
# up이 1이고 down이 0 이니 0.5를 기준으로 더 높으면 up 낮으면 down

?rep
glm.pred=rep("Down",1250)
glm.pred[glm.probs>.5]="Up"
table(glm.pred, Direction)

(145+507)/1250
# down일때 down, up일때 up이 맞는 correct 확률

Year
train=(Year<2005)
# 2005년전 데이터는 true, 2005년 데이터는 false

!train
Smarket.2005=Smarket [!train, ]
dim(Smarket.2005)
Direction.2005=Direction[!train]

glm.fit=glm(Direction~Lag1+Lag2+Lag3+Lag4+Lag5+Volume, data=Smarket, 
            family =binomial, subset=train)

glm.probs=predict(glm.fit,Smarket.2005, type="response")
glm.pred=rep("Down",252)
glm.pred[glm.probs>.5]="Up"
table(glm.pred,Direction.2005)
mean(glm.pred== Direction.2005)
# 맞출 확률 
mean(glm.pred!= Direction.2005)
# 틀릴 확률

glm.fit=glm(Direction~Lag1+Lag2,data=Smarket, family=binomial, subset=train)
# predictor 제외하고 lag1,2만 모델에 포함
glm.probs=predict(glm.fit,Smarket.2005, type="response")
glm.pred=rep("Down",252)
glm.pred[glm.probs>.5]="Up"
table(glm.pred,Direction.2005)
mean(glm.pred ==Direction.2005)
# 맞출 확률이 56%로 증가하였음
106/(106+76)

predict (glm.fit,newdata=data.frame(Lag1=c(1.2,1.5),Lag2=c(1.1,-0.8), type="response"))


library(MASS)   
?lda         
lda.fit=lda(Direction~Lag1+Lag2,data=Smarket,subset=train)
lda.fit
plot(lda.fit)
lda.pred=predict(lda.fit,Smarket.2005)
names(lda.pred)

lda.class=lda.pred$class
table(lda.class,Direction.2005)
mean(lda.class==Direction.2005)

sum(lda.pred$posterior[,1]>=.5)
sum(lda.pred$posterior[,1]<.5)

lda.pred$posterior[1:20,1]
lda.class[1:20]
sum(lda.pred$posterior[,1]>.9)

qda.fit=qda(Direction~Lag1+Lag2, data=Smarket, subset=train)
qda.fit
qda.class=predict(qda.fit,Smarket.2005)$class
table(qda.class,Direction.2005)
mean(qda.class==Direction.2005)


# KNN
library(class)
?knn
train.X=cbind(Lag1,Lag2)[train,]
train.Direction=Direction[train]
test.X=cbind(Lag1,Lag2)[!train,]
train.Direction=Direction[train]

set.seed(1)
knn.pred=knn(train.X,test.X,train.Direction,k=1)
table(knn.pred,Direction.2005)
(83+43)/252

knn.pred=knn(train.X, test.X, train.Direction,k=3)
table(knn.pred,Direction.2005)
mean(knn.pred==Direction.2005)

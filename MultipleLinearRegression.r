#Multiple Linear Regression

#import dataset
dataset <- read.csv("50_Startups.csv")
sapply(dataset, "class")

#encoding the categorical variable, state, to improve model
dataset$State = factor(dataset$State,
                         levels = c('New York', 'California', 'Florida'),
                         labels = c(1, 2, 3))

#split data set (training and testing)
library(caTools)
set.seed(123)
split = sample.split(dataset$Profit, SplitRatio = 0.8)
training_set = subset(dataset, split == T)
test_set = subset(dataset, split == F)

#Fitting Multiple Linear Regression to the training set
regressor <- lm(formula = Profit ~., data = training_set)
summary(regressor)
#using only highly significant features
regressor1 <- lm(formula = Profit ~ R.D.Spend, data = training_set)
summary(regressor)

#Predicting the test set results
y_pred = predict(regressor, newdata = test_set)
View(y_pred)
y_pred

y_pred1 = predict(regressor1, newdata = test_set)
View(y_pred1)
y_pred1

#building the optimal model using backward elimination significance level of 7% for each feature
regressor <- lm(formula = Profit ~ R.D.Spend + Administration + Marketing.Spend + State,
                data = dataset)
summary(regressor)
regressor <- lm(formula = Profit ~ R.D.Spend + Administration + Marketing.Spend,
                data = dataset)
summary(regressor)
regressor <- lm(formula = Profit ~ R.D.Spend + Marketing.Spend,
                data = dataset)
summary(regressor)

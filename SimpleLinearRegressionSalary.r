#Simple Linear Regression

#import the dataset
dataset <- read.csv("Salary_Data.csv")

#Splitting dataset into training and testing set
library(caTools)
set.seed(123)
split <- sample.split(dataset$Salary, SplitRatio = 2/3)
training_set <- subset(dataset, split == T)
testing_set <- subset(dataset, split == F)

#Fitting Simple Linear Regression to Training Set
regressor = lm(formula =  Salary ~ YearsExperience, 
               data = training_set)

#find the statistical significance and what not for the model
summary(regressor)
  #Multiple R-Squared: .9649
  #Adjusted R-Squared: .9630
  #pvalue = 1.524e-14 GOOD!
  #F-statistic is 494.8 on 1 and 18 DF GOOD!
  #Significance codes: 3 is best and none is worse

#Predicting the Test set Results
y_pred <- predict(regressor, newdata = testing_set)
y_pred

#Visualizing the training set results
library(ggplot2)
ggplot () +
  geom_point(aes(x = training_set$YearsExperience, y = training_set$Salary),
             color = 'red') +
  geom_line(aes(x = training_set$YearsExperience, y = predict(regressor, newdata = training_set)),
            color = 'blue') +
  ggtitle("Salary vs Years Experience (Training Set") +
  xlab("Years of Experience") +
  ylab("Salary")

#visualizing the testing set results
ggplot () +
  geom_point(aes(x = testing_set$YearsExperience, y = testing_set$Salary),
             color = 'red') +
  geom_line(aes(x = training_set$YearsExperience, y = predict(regressor, newdata = training_set)),
            color = 'blue') +
  ggtitle("Salary vs Years Experience (Testing Set") +
  xlab("Years of Experience") +
  ylab("Salary")

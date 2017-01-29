#############################################################################
## Session: Logistic Regression with Ad data
#############################################################################

# reading and splitting data and summary statistics

getwd()
setwd("C:/Users/jalee/Desktop/Machine Learning Course")

#import data
dataset <- read.csv('Social_Network_Ads.csv')
dataset <- dataset[,2:5]

#split dataset
library(caTools)
set.seed(123)
split <- sample.split(dataset$Purchased, SplitRatio = 0.8)
training_set <- subset(dataset, split == T)
test_set <- subset(dataset, split == F)
dataset$Gender <- as.factor(dataset$Gender)

#feature scaling
training_set[,2:3] = scale(training_set[,2:3])
test_set[,2:3] = scale(test_set[,2:3])

#fitting logistic regression to the training set
classifier <- glm(formula = Purchased ~ .,
                  family = binomial, data = training_set)

#predicting the test set results
prob_pred <- predict(classifier, type = 'response', 
                     newdata = test_set[-4])
summary(prob_pred)
summary(classifier) #Gender is not significant to predicting y


#re-import data
dataset <- read.csv('Social_Network_Ads.csv')
dataset <- dataset[,3:5]

#re-split dataset
library(caTools)
set.seed(123)
split <- sample.split(dataset$Purchased, SplitRatio = 0.75)
training_set <- subset(dataset, split == T)
test_set <- subset(dataset, split == F)

#re-feature scaling
training_set[,1:2] = scale(training_set[,1:2])
test_set[,1:2] = scale(test_set[1:2])

#re-fitting logistic regression to the training set
classifier <- glm(formula = Purchased ~ .,
                  family = binomial, data = training_set)

#re-predicting the test set results
prob_pred <- predict(classifier, type = 'response', 
                     newdata = test_set[-3])
prob_pred
#shows the probability of each observation being "Purchased"
y_pred <- ifelse(prob_pred > 0.5, 1, 0)
y_pred

#the predictions (greater than 50% = 1, less = 0)
prop.table(table(test_set$Purchased == y_pred))
#83% accurate

#make a confusion matrix
cm <- table(test_set[,3], y_pred)
cm #57 + 26 right and 10 + 7 wrong

#visualizing the training set results
install.packages("ElemStatLearn")
library(ElemStatLearn)
set = training_set
X1 = seq(min(set[, 1]) - 1, max(set[, 1]) + 1, by = 0.01)
X2 = seq(min(set[, 2]) - 1, max(set[, 2]) + 1, by = 0.01)
grid_set = expand.grid(X1, X2)
colnames(grid_set) = c('Age', 'EstimatedSalary')
prob_set = predict(classifier, type = 'response', newdata = grid_set)
y_grid = ifelse(prob_set > 0.5, 1, 0)
plot(set[, -3],
     main = 'Classifier (Training set)',
     xlab = 'Age', ylab = 'Estimated Salary',
     xlim = range(X1), ylim = range(X2))
contour(X1, X2, matrix(as.numeric(y_grid), length(X1), length(X2)), add = TRUE)
points(grid_set, pch = '.', col = ifelse(y_grid == 1, 'springgreen3', 'tomato'))
points(set, pch = 21, bg = ifelse(set[, 3] == 1, 'green4', 'red3'))

#visualizing the test set results
library(ElemStatLearn)
set = test_set
X1 = seq(min(set[, 1]) - 1, max(set[, 1]) + 1, by = 0.01)
X2 = seq(min(set[, 2]) - 1, max(set[, 2]) + 1, by = 0.01)
grid_set = expand.grid(X1, X2)
colnames(grid_set) = c('Age', 'EstimatedSalary')
prob_set = predict(classifier, type = 'response', newdata = grid_set)
y_grid = ifelse(prob_set > 0.5, 1, 0)
plot(set[, -3],
     main = 'Classifier (Test set)',
     xlab = 'Age', ylab = 'Estimated Salary',
     xlim = range(X1), ylim = range(X2))
contour(X1, X2, matrix(as.numeric(y_grid), length(X1), length(X2)), add = TRUE)
points(grid_set, pch = '.', col = ifelse(y_grid == 1, 'springgreen3', 'tomato'))
points(set, pch = 21, bg = ifelse(set[, 3] == 1, 'green4', 'red3'))

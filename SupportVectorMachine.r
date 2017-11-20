#Support Vector Machine

#import dataset
dataset = read.csv("Social_Network_Ads.csv")
dataset = dataset[3:5]

#encoding the target feature as factor
dataset$Purchased = factor(dataset$Purchased, levels = c(0,1))

#split the dataset (train and test)
library(caTools)
set.seed(123)
split = sample.split(dataset$Purchased, SplitRatio = 0.75)
train_set = subset(dataset, split == TRUE)
test_set = subset(dataset, split == FALSE)

#feature scaling
train_set[-3] = scale(train_set[-3])
test_set[-3] = scale(test_set[-3])

#fit classifier to the training set and predict test set results
library(e1071)
classifier = svm(formula = Purchased ~ .,
                 data = train_set,
                 type = 'C-classification',
                 kernel = 'linear')

y_pred = predict(classifier, newdata = test_set[-3])
y_pred

#make the confusion matrix
cm = table(test_set[,3], y_pred)
cm

#visualising the training set observations
library(ElemStatLearn)
set = train_set
X1 = seq(min(set[,1]) - 1, max(set[,1] + 1), by = 0.01)
X2 = seq(min(set[,2]) - 1, max(set[,2] + 1), by = 0.01)
grid_set = expand.grid(X1, X2)
colnames(grid_set) = c("Age", "EstimatedSalary")
y_grid = predict(classifier, newdata = grid_set)
plot(set[,-3],
     main = "SVM (Training Set)",
     xlab = "Age", ylab = "Estimated Salary",
     xlim = range(X1), ylim = range(X2)
)
contour(X1, X2, matrix(as.numeric(y_grid), length(X1), length(X2)), add = TRUE)
points(grid_set, pch = '.', col = ifelse(y_grid == 1, 'springgreen3', 'tomato'))
points(set, pch = 21, bg = ifelse(set[,3] == 1, 'green4', 'red3'))

#visualising the test set results
set = test_set
X1 = seq(min(set[,1]) - 1, max(set[,1] + 1), by = 0.01)
X2 = seq(min(set[,2]) - 1, max(set[,2] + 1), by = 0.01)
grid_set = expand.grid(X1, X2)
colnames(grid_set) = c("Age", "EstimatedSalary")
y_grid = knn(train = train_set[,-3],
             test = grid_set,
             cl = train_set[,3],
             k = 5)
plot(set[,-3],
     main = "SVM (Test Set)",
     xlab = "Age", ylab = "Estimated Salary",
     xlim = range(X1), ylim = range(X2)
)
contour(X1, X2, matrix(as.numeric(y_grid), length(X1), length(X2)), add = TRUE)
points(grid_set, pch = '.', col = ifelse(y_grid == 1, 'springgreen3', 'tomato'))
points(set, pch = 21, bg = ifelse(set[,3] == 1, 'green4', 'red3'))
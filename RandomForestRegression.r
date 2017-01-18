#Random Forest Regression

#importing the dataset
dataset <- read.csv("Position_Salaries.csv")
dataset <- dataset[2:3]

#splitting data into testing and training sets is not necessary
#feature scaling is handled

#fitting the Random Forest Regression model to the dataset
library(randomForest)
set.seed(123)
regressor <- randomForest(x = dataset[1],
                          y = dataset$Salary,
                          ntree = 1000)

#Predicting a new result  
y_pred <- predict(regressor, data.frame(Level = 6.5))  
  
#visualizing the Random Forest Regression Model
library(ggplot2)
x_grid = seq(min(dataset$Level), max(dataset$Level), 0.001)
ggplot()+ 
  geom_point(aes(x = dataset$Level, y = dataset$Salary),
             color = "red") +
  geom_line(aes(x = x_grid, y = predict(regressor, newdata = data.frame(Level = x_grid))),
            color = "blue") +
  ggtitle("Truth or Bluff (Random Forest Regression)") +
  xlab("Level") +
  ylab("Salary")

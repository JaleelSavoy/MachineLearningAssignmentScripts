#Support Vector Regression

#Import the dataset
dataset = read.csv("Position_Salaries.csv")
dataset = dataset[2:3]

#fitting the SVR to the dataset

regressor <- svm(formula = Salary ~.,
                 data = dataset,
                 type = "eps-regression",
                 kernel = "radial")

#predicting a new result
y_pred = predict(regressor, data.frame(Level = 6.5))

#visualizing the SVR results
library(ggplot2)
ggplot() + 
  geom_point(aes(x = dataset$Level, y = dataset$Salary),
             color = "red") +
  geom_line(aes(x = dataset$Level, y = predict(regressor, newdata = dataset)),
            color = "blue") +
  ggtitle("Truth or Bluff (SVR Model)") +
  xlab("Level") +
  ylab("Salary")
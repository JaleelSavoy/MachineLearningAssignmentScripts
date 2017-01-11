#Polynomial Regression

#Import dataset
dataset = read.csv("Position_Salaries.csv")
#we do not need the job title for this analysis
dataset <- dataset[2:3]

#small dataset and whatnot, no need to split into train/test sets
#feature scaling is handled

#fitting Linear Regression to the dataset (for comparison)
lin_reg <- lm(formula = Salary ~ ., 
             data = dataset)
summary(lin_reg)

#fitting the Polynomial Regression to the dataset
#build polynomial terms
dataset$Level2 <- dataset$Level^2
dataset$Level3 <- dataset$Level^3
dataset$Level4 <- dataset$Level^4
poly_reg <- lm(formula = Salary ~ .,
               data = dataset)
summary(poly_reg)

#visualizing the linear regression results
library(ggplot2)
ggplot() +
  geom_point(aes(x = dataset$Level, y = dataset$Salary), 
    colour = 'red') +
  geom_line(aes(x = dataset$Level, y = predict(lin_reg, dataset)),
            colour = 'blue') + 
  ggtitle("Truth of Bluff (Linear Regression)") +
    xlab("Level") +
    ylab("Salary")
  

#visualizing the polynomial regression results
ggplot() +
  geom_point(aes(x = dataset$Level, y = dataset$Salary), 
             colour = 'red') +
  geom_line(aes(x = dataset$Level, y = predict(poly_reg, dataset)),
            colour = 'blue') + 
  ggtitle("Truth of Bluff (Polynomial Regression)") +
  xlab("Level") +
  ylab("Salary")

#predict a new result with LinReg model
y_pred <- predict(lin_reg, data.frame(Level = 6.5))

#predict a new result with PolyReg model
y_pred2 <- predict(poly_reg, data.frame(Level = 6.5, 
                                        Level2 = 6.5^2, 
                                        Level3 = 6.5^3, 
                                        Level4 = 6.5^4))
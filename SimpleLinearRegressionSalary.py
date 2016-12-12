#Simple Linear Regression

#import libraries
import numpy as np
import matplotlib.pyplot as plt
import pandas as pd

#import dataset
dataset = pd.read_csv('Salary_Data.csv')
X = dataset.iloc[:, :-1].values
Y = dataset.iloc[:, 1].values

#splitting the dataset into train and test
from sklearn.cross_validation import train_test_split
X_train, X_test, y_train, y_test = train_test_split(X, Y, test_size = 1/3, random_state = 0)

#fitting simple linear regression to the training set
from sklearn.linear_model import LinearRegression
regressor = LinearRegression()
regressor.fit(X_train, y_train)

#predicting the test set results
y_pred = regressor.predict(X_test)

#visualizing the training set results
plt.scatter(X_train, y_train, color = 'red')
#add the regression line
plt.plot(X_train, regressor.predict(X_train), color = 'blue')
#add a title to the plot
plt.title('Salary vs. Experience (Training Set)')
#label to X-axis
plt.xlabel('Years of Experience')
#label to Y-axis
plt.ylabel('Salary')
plt.show()

#visualizing the test set predictions
plt.scatter(X_test, y_test, color = 'red')
#add the regression line
plt.plot(X_train, regressor.predict(X_train), color = 'blue')
#add a title to the plot
plt.title('Salary vs. Experience (Test Set)')
#label to X-axis
plt.xlabel('Years of Experience')
#label to Y-axis
plt.ylabel('Salary')
plt.show()
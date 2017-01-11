#Polynomial Regression

#Importing the three essential libraries
import numpy as np  #contains mathematical tools
import matplotlib.pyplot as plt  #imported sub-library to help plot nice charts
import pandas as pd  #best library to import & manage datasets

#importing the dataset
dataset = pd.read_csv('Position_Salaries.csv')

#create matrix of independent/explanatory variables
X = dataset.iloc[:, 1:2].values
Y = dataset.iloc[:, 2].values

#fitting linear regression to dataset for comparison
from sklearn.linear_model import LinearRegression
lin_reg = LinearRegression()
lin_reg.fit(X, Y)

#fitting polynomial regression to the dataset
from sklearn.preprocessing import PolynomialFeatures
poly_reg = PolynomialFeatures(degree = 3)
X_poly = poly_reg.fit_transform(X)
lin_reg2 = LinearRegression()
lin_reg2.fit(X_poly, Y)

#visualising the linear regression results
plt.scatter(X, Y, color = "red")
plt.plot(X, lin_reg.predict(X), color = "blue")
plt.title("Truth or Bluff (Linear Regression)")
plt.xlabel("Position Level")
plt.ylabel("Salary")
plt.show

#visualising the polynomial regression results
X_grid = np.arange(min(X), max(X), 0.1)
X_grid = X_grid.reshape((len(X_grid), 1))
plt.scatter(X, Y, color = "red")
plt.plot(X_grid, lin_reg2.predict(poly_reg.fit_transform(X_grid)), color = "blue")
plt.title("Truth or Bluff (Polynomial Regression)")
plt.xlabel("Position Level")
plt.ylabel("Salary")
plt.show
#a degree was added to make the PolyReg better

#predicting new result with Linear Regression
lin_reg.predict(6.5)

#predicting a new result with Polynomial Regression
lin_reg2.predict(poly_reg.fit_transform(6.5))

#when comparing the two models, PolyReg > LinReg
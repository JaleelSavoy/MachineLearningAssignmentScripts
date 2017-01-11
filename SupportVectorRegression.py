#Support Vector Regression

#import the libraries
import numpy as np
import matplotlib.pyplot as plt
import pandas as pd

#import the dataset
dataset = pd.read_csv("Position_Salaries.csv")
X = dataset.iloc[:, 1:2].values
y = dataset.iloc[:, 2].values

#feature scaling
from sklearn.preprocessing import StandardScaler
sc_X = StandardScaler()
X = sc_X.fit_transform(X)
sc_y = StandardScaler()
y = sc_y.fit_transform(y)


#fit the SVR model to the dataset
from sklearn.svm import SVR
#use gaussian RBF kernel (most common) instead of poly
regressor= SVR(kernel = "rbf")
regressor.fit(X, y)

#predict new result
y_pred = sc_y.inverse_transform(regressor.predict(sc_X.transform(X =np.array([[6.5]]))))

#visualize the SVR results
plt.scatter(X, y, color = "red")
plt.plot(X, regressor.predict(X), color = "blue")
plt.title("Truth or Bluff (SVR)")
plt.xlabel("Position Level")
plt.ylabel("Salary")
plt.show

#visualize the SVR results with higher resolution/smoother curve
X_grid = np.arange(min(X), max(X), 0.1)
X_grid = X_grid.reshape(len(X_grid), 1)
plt.scatter(X, y, color = "red")
plt.plot(X_grid, regressor.predict(X_grid), color = "blue")
plt.xlabel("Position Level")
plt.ylabel("Salary")
plt.show()
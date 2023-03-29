# installing packages
install.packages("psych")
install.packages("corrplot")
install.packages("RcolorBrewer")

# lmporting the packages
library(psych)
library(corrplot)
library(RColorBrewer)

# Import the dataset
data("iris")
x <-corr.test(iris[-5])
x
pairs.panels(iris[-5])

#import your dataset
data("iris")

m <- cor(iris[ , -5])
corPlot(m)
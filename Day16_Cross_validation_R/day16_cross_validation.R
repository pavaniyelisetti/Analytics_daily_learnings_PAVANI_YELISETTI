# PREDICTING EARNINGS FROM CENSUS DATA

# Problem 1.1 - A Logistic Regression Model
# Let's begin by building a logistic regression model to predict whether an 
# individual's earnings are above $50,000 (the variable "over50k") using all of
# the other variables as independent variables. First, read the dataset 
# census.csv into R.
census <- read.csv("./data_unit4_3/census.csv")
str(census)
summary(census)
# Then, split the data randomly into a training set and a testing set, setting 
# the seed to 2000 before creating the split. Split the data so that the 
# training set contains 60% of the observations, while the testing set contains
# 40% of the observations.
library(caTools)
set.seed(2000)
censusSplit = sample.split(census$over50k, SplitRatio = 0.6)
censusTrain = subset(census, censusSplit == TRUE)
censusTest = subset(census, censusSplit == FALSE)
nrow(censusTrain)
nrow(censusTest)


# Problem 4.1 - Selecting cp by Cross-Validation
# We now conclude our study of this data set by looking at how CART behaves with
# different choices of its parameters.
# Let us select the cp parameter for our CART model using k-fold cross 
# validation, with k = 10 folds. Do this by using the train function. Set the 
# seed beforehand to 2. Test cp values from 0.002 to 0.1 in 0.002 increments, by
# using the following command:
# cartGrid <- expand.grid( .cp = seq(0.002,0.1,0.002))
# Also, remember to use the entire training set "train" when building this 
# model. The train function might take some time to run.
# Which value of cp does the train function recommend?
library(caret)
library(e1071)
## Number of folds
tr.control = trainControl(method = "cv", number = 10)
## cp values
cartGrid <- expand.grid( .cp = seq(0.002,0.1,0.002))
cartGrid
## Cross-validation
set.seed(2)
tr = train(over50k ~ ., data = censusTrain, method = "rpart", 
           trControl = tr.control, tuneGrid = cartGrid)
tr
## cp = 0.002


# Problem 4.2 - Selecting cp by Cross-Validation
# Fit a CART model to the training data using this value of cp. What is the 
# prediction accuracy on the test set?
censusTree2 <- 
  rpart(over50k ~ ., data = censusTrain, method="class", cp = 0.002)
predictTree2 <- 
  as.vector(predict(censusTree2, newdata = censusTest, type = "class"))
table(censusTest$over50k, predictTree2)
(9178 + 1838) / nrow(censusTest)
## 0.8612306


# Problem 4.3 - Selecting cp by Cross-Validation
# Compared to the original accuracy using the default value of cp, this new CART
# model is an improvement, and so we should clearly favor this new model over 
# the old one -- or should we? Plot the CART tree for this model. How many 
# splits are there?
prp(censusTree2)
## 18

# This highlights one important tradeoff in building predictive models. By 
# tuning cp, we improved our accuracy by over 1%, but our tree became 
# significantly more complicated. In some applications, such an improvement in
# accuracy would be worth the loss in interpretability. In others, we may prefer
# a less accurate model that is simpler to understand and describe over a more
# accurate -- but more complicated -- model.
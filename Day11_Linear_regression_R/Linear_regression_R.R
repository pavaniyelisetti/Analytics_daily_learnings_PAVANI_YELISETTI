# CLIMATE CHANGE

climate <- read.csv("./data_unit2_1/climate_change.csv")
str(climate)
summary(climate)


# Problem 1.1 - Creating Our First Model
## We are interested in how changes in these variables affect future 
## temperatures, as well as how well these variables explain temperature changes 
## so far. To do this, first read the dataset climate_change.csv into R.

## Then, split the data into a training set, consisting of all the observations 
## up to and including 2006, and a testing set consisting of the remaining years
## (hint: use subset). A training set refers to the data that will be used to 
## build the model (this is the data we give to the lm() function), and a 
## testing set refers to the data we will use to test our predictive ability.
climate_train <- subset(climate, Year <= 2006)
climate_test <- subset(climate, Year > 2006)
str(climate_train)
summary(climate_train)
str(climate_test)
summary(climate_test)

## Next, build a linear regression model to predict the dependent variable Temp, 
## using MEI, CO2, CH4, N2O, CFC.11, CFC.12, TSI, and Aerosols as independent 
## variables (Year and Month should NOT be used in the model). Use the training 
## set to build the model.
fit.climate <- 
  lm(Temp ~ MEI + CO2 + CH4 + N2O + CFC.11 + CFC.12 + TSI + Aerosols, 
     data = climate_train)

## Enter the model R2 (the "Multiple R-squared" value):
summary(fit.climate)
## 0.7509


# Problem 1.2 - Creating Our First Model
## Which variables are significant in the model? We will consider a variable 
## signficant only if the p-value is below 0.05. (Select all that apply.) 
## MEI, CO2, CFC.11, CFC.12, TSI, Aerosols


# Problem 2.1 - Understanding the Model
## Current scientific opinion is that nitrous oxide and CFC-11 are greenhouse 
## gases: gases that are able to trap heat from the sun and contribute to the 
## heating of the Earth. However, the regression coefficients of both the N2O 
## and CFC-11 variables are negative, indicating that increasing atmospheric 
## concentrations of either of these two compounds is associated with lower 
## global temperatures.

## Which of the following is the simplest correct explanation for this 
## contradiction?
## All of the gas concentration variables reflect human development - N2O and 
## CFC.11 are correlated with other variables in the data set.


# Problem 2.2 - Understanding the Model
## Compute the correlations between all the variables in the training set. 
cor(climate_train)

## Which of the following independent variables is N2O highly correlated with 
## (absolute correlation greater than 0.7)? Select all that apply.
## CO2, CH4, CFC.12

## Which of the following independent variables is CFC.11 highly correlated 
## with? Select all that apply.
## CH4, CFC.12


# Problem 3 - Simplifying the Model
## Given that the correlations are so high, let us focus on the N2O variable and
## build a model with only MEI, TSI, Aerosols and N2O as independent variables. 
## Remember to use the training set to build the model.
fit.climate.2 <- 
  lm(Temp ~ MEI + N2O + TSI + Aerosols, 
     data = climate_train)

## Enter the coefficient of N2O in this reduced model:
summary(fit.climate.2)
## 2.532e-02

## (How does this compare to the coefficient in the previous model with all of the variables?)
## Enter the model R2:
## 0.7261


# Problem 4 - Automatically Building the Model
## We have many variables in this problem, and as we have seen above, dropping 
## some from the model does not decrease model quality. R provides a function, 
## step, that will automate the procedure of trying different combinations of 
## variables to find a good compromise of model simplicity and R2. This 
## trade-off is formalized by the Akaike information criterion (AIC) - it can be
## informally thought of as the quality of the model with a penalty for the 
## number of variables in the model.

## The step function has one argument - the name of the initial model. It 
## returns a simplified model. Use the step function in R to derive a new model,
## with the full model as the initial model (HINT: If your initial full model 
## was called "climateLM", you could create a new model with the step function 
## by typing step(climateLM). Be sure to save your new model to a variable name 
## so that you can look at the summary. For more information about the step 
## function, type ?step in your R console.)
fit.climate.step <- step(fit.climate)
summary(fit.climate.step)

## Enter the R2 value of the model produced by the step function:
## 0.7508

## Which of the following variable(s) were eliminated from the full model by the
## step function? Select all that apply.
## 

## It is interesting to note that the step function does not address the 
## collinearity of the variables, except that adding highly correlated variables
## will not improve the R2 significantly. The consequence of this is that the 
## step function will not necessarily produce a very interpretable model - just 
## a model that has balanced quality and simplicity for a particular weighting 
## of quality and simplicity (AIC).


# Problem 5 - Testing on Unseen Data
## We have developed an understanding of how well we can fit a linear regression
## to the training data, but does the model quality hold when applied to unseen 
## data?

## Using the model produced from the step function, calculate temperature 
## predictions for the testing data set, using the predict function.
TempPredictions <- predict(fit.climate.step, newdata = climate_test)

## Enter the testing set R2:
climate.SSE = sum((TempPredictions - climate_test$Temp)^2)
climate.SST = sum((climate_test$Temp - mean(climate_train$Temp))^2)
1 - climate.SSE/climate.SST
## 0.6286051

# READING TEST SCORES

pisaTrain <- read.csv("./data_unit2_2/pisa2009train.csv")
pisaTest <- read.csv("./data_unit2_2/pisa2009test.csv")
str(pisaTrain)
summary(pisaTrain)

# Problem 1.1 - Dataset size
## Load the training and testing sets using the read.csv() function, and save 
## them as variables with the names pisaTrain and pisaTest.
## How many students are there in the training set?
## 3663


# Problem 1.2 - Summarizing the dataset
## Using tapply() on pisaTrain, what is the average reading test score of males?
tapply(pisaTrain$readingScore, pisaTrain$male, mean)
## 483.5325

## Of females?
## 512.9406


# Problem 1.3 - Locating missing values
## Which variables are missing data in at least one observation in the training 
## set? Select all that apply.
summary(pisaTrain)
## raceeth, preschool, expectBachelors, motherHS, motherBachelors, motherWork,
## fatherHS, fatherBachelors, fatherWork, selfBornUS, motherBornUS, 
## fatherBornUS, englishAtHome, computerForSchoolWork, read30MinsADay, 
## minutesPerWeekEnglish, studentsInEnglish, schoolHasLibrary, schoolSize


# Problem 1.4 - Removing missing values
## Linear regression discards observations with missing data, so we will remove 
## all such observations from the training and testing sets. Later in the 
## course, we will learn about imputation, which deals with missing data by 
## filling in missing values with plausible information.

## Type the following commands into your R console to remove observations with 
## any missing value from pisaTrain and pisaTest:
pisaTrain = na.omit(pisaTrain)
pisaTest = na.omit(pisaTest)

## How many observations are now in the training set?
str(pisaTrain)
## 2414

## How many observations are now in the testing set?
str(pisaTest)
## 990


# Problem 2.1 - Factor variables
## Factor variables are variables that take on a discrete set of values, like 
## the "Region" variable in the WHO dataset from the second lecture of Unit 1. 
## This is an unordered factor because there isn't any natural ordering between 
## the levels. An ordered factor has a natural ordering between the levels (an 
## example would be the classifications "large," "medium," and "small").

## Which of the following variables is an unordered factor with at least 3 
## levels? (Select all that apply.)
str(pisaTrain)
## raceeth

## Which of the following variables is an ordered factor with at least 3 levels?
## (Select all that apply.)
## grade


# Problem 2.2 - Unordered factors in regression models
## To include unordered factors in a linear regression model, we define one 
## level as the "reference level" and add a binary variable for each of the 
## remaining levels. In this way, a factor with n levels is replaced by n-1 
## binary variables. The reference level is typically selected to be the most 
## frequently occurring level in the dataset.

## As an example, consider the unordered factor variable "color", with levels 
## "red", "green", and "blue". If "green" were the reference level, then we 
## would add binary variables "colorred" and "colorblue" to a linear regression
## problem. All red examples would have colorred=1 and colorblue=0. All blue 
## examples would have colorred=0 and colorblue=1. All green examples would have
## colorred=0 and colorblue=0.

## Now, consider the variable "raceeth" in our problem, which has levels 
## "American Indian/Alaska Native", "Asian", "Black", "Hispanic", "More than 
## one race", "Native Hawaiian/Other Pacific Islander", and "White". Because it
## is the most common in our population, we will select White as the reference
## level.

## Which binary variables will be included in the regression model? (Select all
## that apply.)
## - raceethAmerican Indian/Alaska Native
## - raceethAsian
## - raceethBlack
## - raceethHispanic
## - raceethMore than one race
## - raceethNative Hawaiian/Other Pacific Islander


# Problem 2.3 - Example unordered factors
## Consider again adding our unordered factor race to the regression model with
## reference level "White".

## For a student who is Asian, which binary variables would be set to 0? All
## remaining variables will be set to 1. (Select all that apply.)
## (all except raceethAsian)

## For a student who is white, which binary variables would be set to 0? All 
## remaining variables will be set to 1. (Select all that apply.)
## (all)


# Problem 3.1 - Building a model
## Because the race variable takes on text values, it was loaded as a factor 
## variable when we read in the dataset with read.csv() -- you can see this when
## you run str(pisaTrain) or str(pisaTest). However, by default R selects the 
## first level alphabetically ("American Indian/Alaska Native") as the reference
## level of our factor instead of the most common level ("White"). Set the
## reference level of the factor by typing the following two lines in your R
## console:
pisaTrain$raceeth = relevel(pisaTrain$raceeth, "White")
pisaTest$raceeth = relevel(pisaTest$raceeth, "White")
## Now, build a linear regression model (call it lmScore) using the training set
## to predict readingScore using all the remaining variables.
## It would be time-consuming to type all the variables, but R provides the 
## shorthand notation "readingScore ~ ." to mean "predict readingScore using all
## the other variables in the data frame." The period is used to replace listing
## out all of the independent variables. As an example, if your dependent
## variable is called "Y", your independent variables are called "X1", "X2", and
## "X3", and your training data set is called "Train", instead of the regular 
## notation:
##    LinReg = lm(Y ~ X1 + X2 + X3, data = Train)
## You would use the following command to build your model:
##    LinReg = lm(Y ~ ., data = Train)
lmScore <- lm(readingScore ~ ., data = pisaTrain)
## What is the Multiple R-squared value of lmScore on the training set?
summary(lmScore)
## 0.3251

## Note that this R-squared is lower than the ones for the models we saw in the
## lectures and recitation. This does not necessarily imply that the model is of
## poor quality. More often than not, it simply means that the prediction
## problem at hand (predicting a student's test score based on demographic and
## school-related variables) is more difficult than other prediction problems
## (like predicting a team's number of wins from their runs scored and allowed, 
## or predicting the quality of wine from weather conditions).


# Problem 3.2 - Computing the root-mean squared error of the model
## What is the training-set root-mean squared error (RMSE) of lmScore?
lmScoreSSE <- sum(lmScore$residuals^2)
lmScoreSSE
sqrt(lmScoreSSE/nrow(pisaTrain))
## 73.36555


# Problem 3.3 - Comparing predictions for similar students
## Consider two students A and B. They have all variable values the same, 
## except that student A is in grade 11 and student B is in grade 9. What is 
## the predicted reading score of student A minus the predicted reading score 
## of student B?
pisaPred <- pisaTest[1,]
pisaPred <- rbind(pisaPred, pisaTest[1,])
pisaPred[1,1] <- 11 ## grade 11 for student A
pisaPred[2,1] <- 9  ## grade 9 for student B
pisaPred
predictedScores <- predict(lmScore, pisaPred)
predictedScores
predictedScores[1] - predictedScores[2]
## 59.08541 ~ 59.09


# Problem 3.4 - Interpreting model coefficients
## What is the meaning of the coefficient associated with variable raceethAsian?
summary(lmScore)
## Predicted difference in the reading score between an Asian student and a 
## white student who is otherwise identical 


# Problem 3.5 - Identifying variables lacking statistical significance
## Based on the significance codes, which variables are candidates for removal 
## from the model? Select all that apply. (We'll assume that the factor variable
## raceeth should only be removed if none of its levels are significant.)
## preschool, motherHS, motherWork, fatherHS, fatherWork, selfBornUS, 
## motherBornUS, fatherBornUS, englishAtHome, minutesPerWeekEnglish,
## studentsInEnglish, schoolHasLibrary, urban


# Problem 4.1 - Predicting on unseen data
## Using the "predict" function and supplying the "newdata" argument, use the 
## lmScore model to predict the reading scores of students in pisaTest. Call 
## this vector of predictions "predTest". Do not change the variables in the 
## model (for example, do not remove variables that we found were not 
## significant in the previous part of this problem). Use the summary function 
## to describe the test set predictions.
predTest <- predict(lmScore, newdata = pisaTest)
summary(predTest)

## What is the range between the maximum and minimum predicted reading score on 
## the test set?
637.7 - 353.2
## 284.5


# Problem 4.2 - Test set SSE and RMSE
## What is the sum of squared errors (SSE) of lmScore on the testing set?
test_set_SSE = sum((predTest - pisaTest$readingScore)^2)
test_set_SSE
## 5762082

## What is the root-mean squared error (RMSE) of lmScore on the testing set?
test_set_RMSE = sqrt(test_set_SSE/nrow(pisaTest))
test_set_RMSE
## 76.29079


# Problem 4.3 - Baseline prediction and test-set SSE
## What is the predicted test score used in the baseline model? Remember to 
## compute this value using the training set and not the test set.
mean(pisaTrain$readingScore)
## 517.9629

## What is the sum of squared errors of the baseline model on the testing set? 
## HINT: We call the sum of squared errors for the baseline model the total sum
## of squares (SST).
test_set_SST = sum((mean(pisaTrain$readingScore) - pisaTest$readingScore)^2)
test_set_SST
## 7802354


# Problem 4.4 - Test-set R-squared
## What is the test-set R-squared value of lmScore?
1 - test_set_SSE/test_set_SST
## 0.2614944
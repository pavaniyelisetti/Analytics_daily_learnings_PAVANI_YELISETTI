Today I learnt about k-fold cross validation:

Previously in CART we learnt about minbucket, which can effect the model's out-of-sample accuracy,
if minbucket is too small over-fitting might occur and if it is too large the model might be too simple, so setting this parameter value is very crucial.

We can use k-fold cross validation, to select this parameter value.

When we use cross-validation in R, we'll use a parameter named cp (Complexity Parameter), like Adjusted R2 for Linear regression and AIC for logistic regression

What exactly is k-fold cross validation?
Split data into k folds, use k-1 folds to estimate a model and test model on remaining one fold("validation set").
For example if I have load data from 2001 to 2004, and each time if i use 3 years data to validate the 4th year and repeat that 4 times.

We can compute accuracy of model for each fold, and to determine the final parameter value we average the k-folds from accuracy vs parameter plot.
Using this cp value in the CART model has increased the accuracy of the model. So the accuracy of the model was now increased to 86% by using the cp value predicted from cross-validation.

You can learn the content from:
https://ocw.mit.edu/courses/15-071-the-analytics-edge-spring-2017/pages/trees/

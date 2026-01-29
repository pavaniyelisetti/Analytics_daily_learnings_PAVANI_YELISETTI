############################################
# Predicting World Series Winners
# Logistic Regression & Model Evaluation
############################################

# -------------------------------
# 1. Load data
# -------------------------------

setwd("C:/Users/pavan/Downloads")
baseball <- read.csv("baseball.csv")

# -------------------------------
# 2. Basic dataset exploration
# -------------------------------

nrow(baseball)
table(baseball$Year)
length(table(baseball$Year))

# -------------------------------
# 3. Keep only playoff teams
# -------------------------------

baseball <- subset(baseball, Playoffs == 1)
nrow(baseball)

# -------------------------------
# 4. Number of playoff teams per year
# -------------------------------

PlayoffTable <- table(baseball$Year)

# Add NumCompetitors variable
baseball$NumCompetitors <- PlayoffTable[as.character(baseball$Year)]

# -------------------------------
# 5. Create World Series outcome variable
# -------------------------------

baseball$WorldSeries <- as.numeric(baseball$RankPlayoffs == 1)
table(baseball$WorldSeries)

# -------------------------------
# 6. Train / Test split (caTools)
# -------------------------------

library(caTools)

set.seed(123)
split <- sample.split(baseball$WorldSeries, SplitRatio = 0.7)

train <- subset(baseball, split == TRUE)
test  <- subset(baseball, split == FALSE)

# -------------------------------
# 7. Logistic regression model
# -------------------------------

model <- glm(
  WorldSeries ~ RankSeason + NumCompetitors,
  data = train,
  family = binomial
)

summary(model)

# -------------------------------
# 8. Predict probabilities on test set
# -------------------------------

probs_test <- predict(model, test, type = "response")

# -------------------------------
# 9. Classification with threshold = 0.5
# -------------------------------

pred_05 <- ifelse(probs_test >= 0.5, 1, 0)

cm_05 <- table(
  Predicted = pred_05,
  Actual = test$WorldSeries
)

cm_05

# -------------------------------
# 10. Classification with threshold = 0.2
# -------------------------------

pred_02 <- ifelse(probs_test >= 0.2, 1, 0)

cm_02 <- table(
  Predicted = pred_02,
  Actual = test$WorldSeries
)

cm_02

# -------------------------------
# 11. Confusion matrix metrics (robust)
# -------------------------------

TP <- sum(pred_02 == 1 & test$WorldSeries == 1)
TN <- sum(pred_02 == 0 & test$WorldSeries == 0)
FP <- sum(pred_02 == 1 & test$WorldSeries == 0)
FN <- sum(pred_02 == 0 & test$WorldSeries == 1)

sensitivity <- TP / (TP + FN)
specificity <- TN / (TN + FP)

sensitivity
specificity

# -------------------------------
# 12. ROC curve and AUC
# -------------------------------

library(ROCR)

pred_obj <- prediction(probs_test, test$WorldSeries)

roc <- performance(pred_obj, "tpr", "fpr")
plot(roc, col = "blue", lwd = 2)
abline(a = 0, b = 1, lty = 2)

auc <- performance(pred_obj, "auc")
auc_value <- as.numeric(auc@y.values)

auc_value



# Day 13 — Evaluating Classification Models in R

This project focuses on evaluating classification models in R, with an emphasis on understanding model performance beyond overall accuracy.
The goal was to learn how different evaluation metrics reflect different decision priorities.

---

## What I Learned

- Evaluating classification models using **confusion matrices**
- Understanding and interpreting **accuracy, sensitivity, and specificity**
- Using **probability thresholds** to control model behavior
- Comparing predictive models against **baseline classifiers**
- Interpreting model performance in the context of real-world decisions
- Recognizing trade-offs between false positives and false negatives

---

## Key Insight

A high accuracy alone does not guarantee a useful model.  
Effective classification depends on aligning evaluation metrics with the decision objective, such as prioritizing confidence, coverage, or risk reduction.

---

📌 Code and examples are included for learning and reference.
Assignment questions and dataset can be found here:

https://ocw.mit.edu/courses/15-071-the-analytics-edge-spring-2017/pages/logistic-regression/assignment-3/predicting-the-baseball-world-series-champion/
Tools & Libraries Used: R
glm() for logistic regression
caTools for train/test splitting
ROCR for ROC and AUC analysis

# Day 4 – Electricity Load Forecasting: Ex-post vs Ex-ante

## Objective
Understand and implement the concepts of **ex-post** and **ex-ante** forecasting
in the context of electricity load forecasting, with a focus on **proper model
evaluation and benchmarking**.

These concepts are critical for distinguishing between **model performance**
and **operational forecasting accuracy**.

---

## Key Concepts

### Ex-ante Forecasting (Before the Event)
Ex-ante forecasting refers to predicting load for a future period using only
the information available **before** that period. This includes the use of
**forecasted weather data**, and the actual load is unknown at the time of
forecasting.

This represents the **real-world operational scenario** used by utilities
and system operators.

---

### Ex-post Forecasting (After the Event)
Ex-post forecasting is used for **model evaluation**. In this setup, the model
forecasts load for a historical period using **actual observed weather**, while
**excluding the actual load of the forecast period from model training**.

This allows evaluation of **how the model behaves under perfect weather
information**, isolating model error from weather forecast uncertainty.

---

## Implementation in This Notebook
- A **benchmark (vanilla) forecasting model** is used
- Training data excludes the target forecast period
- Actual observed weather is used for the forecast period
- Actual load is used **only for evaluation**, not for training
- Focus is on **ex-post forecasting accuracy**, not operational forecasting

This approach follows best practices described in academic literature for
load forecasting model assessment.

---

## Why Ex-post Evaluation Matters
- Separates **model error** from **weather forecast error**
- Helps assess the **structural quality** of a load model
- Provides a fair benchmark before moving to more complex models

Ex-post evaluation is typically emphasized during **model development**, while
ex-ante forecasting is used for **real-time operations**.

---

## References
Hong, T., Wilson, J., & Xie, J. (2014). *Long-term probabilistic load forecasting
and normalization with hourly information*. IEEE Transactions on Smart Grid,
5(1), 456–462. https://doi.org/10.1109/TSG.2013.2274373

Hong, T., Wang, P., & White, L. (2015). *Weather station selection for electric
load forecasting*. International Journal of Forecasting, 31(2), 286–295.
https://doi.org/10.1016/j.ijforecast.2014.07.001

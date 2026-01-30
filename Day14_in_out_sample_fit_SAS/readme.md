# Day 14 — In-Sample vs Out-of-Sample Evaluation in Load Forecasting

## Goal
Practice proper **training, validation, and testing splits** for electricity load forecasting and understand why out-of-sample evaluation matters more than in-sample fit.

---

## Data Split Used (Example)
Load data: **2001–2006**

- **Training (In-sample):** 2001–2004  
  Used to estimate model parameters.

- **Validation (Post-sample):** 2005  
  Forecasts generated without using actual load, then compared using error metrics for model selection.

- **Testing (Out-of-sample):** 2006  
  Final, untouched evaluation to assess true forecasting performance.

---

## Key Takeaway
- In-sample fit shows how well a model explains history.
- Validation helps choose the right model.
- Out-of-sample testing reflects real-world performance.

In load forecasting, **model selection should be based on post-sample validation, not in-sample fit**.

---

## Contents
- Training, validation, and testing code
- Error metric evaluation
- Forecast comparison logic

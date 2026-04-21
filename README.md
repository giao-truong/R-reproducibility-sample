# Financial Cycles and Early Warning Indicators in Nordic Countries

## 📌 Project Overview

This project analyzes financial cycle dynamics and evaluates the predictive power of early warning indicators for banking crises in Nordic countries (Denmark, Finland, Norway, Sweden).

We compare two key indicators:

- **Basel Credit-to-GDP Gap** (long-term structural imbalance)
- **DRC (Differenced Credit)** (short-term credit growth)

The goal is to assess which indicator better predicts financial crises across different time horizons.

---
## 🎯 Research Objectives

1. Evaluate the predictive power of Basel Gap vs DRC
2. Compare performance across countries
3. Distinguish short-term vs long-term predictive ability
4. Assess robustness using statistical models

---

## 📊 Research Questions

1. Which indicator performs better in predicting crises?
2. Does predictive power differ across countries?
3. Are short-term signals (DRC) or long-term signals (Basel Gap) more reliable?

---

## Repository Structure

* `master.R` — Main script to run the full pipeline

* `code/` — Modular scripts:

  * `01_setup.R` — Environment setup and package installation
  * `02_clean.R` — Data merging and cleaning
  * `03_construct_variables.R` — Treatment and control definitions
  * `04_analysis.R` — AUC comparison and models
  * `05_visualization.do` — Figures and plots

* `data/` — Data folders
  * `raw` —  Raw dataset (credit-to-GDP)
  * `cleaned` 

* `output/` — Generated tables and figures
  * `figures` 
  * `tables` 


---

## ⚙️ Reproducibility

To reproduce the results:

1. Open R and run:

```r
source("master.R")
```
2. Outputs will be saved in:

   * `output/tables/`
   * `output/figures/`

---

## 🔄 Workflow Description

Step 1 — Setup

 - **Load libraries**
 - **Define reproducible file paths**

Step 2 — Data Cleaning

 - **Import Excel dataset**
 - **Convert wide → long format**
 - **Construct time variables (year, quarter)**

Step 3 — Feature Engineering

- **Basel Gap**
 - **Computed using a one-sided HP filter**
 - **Captures long-term deviation from trend**

- **DRC (Differenced Credit)**
 - **8-quarter change in credit-to-GDP**
 - **Captures short-term credit expansion**

- **Crisis Variables**
 - **Construct crisis periods by country**
 - **Generate:**
    - **target_short (2-year horizon)**
    - **target_long (5-year horizon)**

Step 4 — Analysis

- **AUC (ROC) Comparison**
 - **Evaluate predictive performance of:**
    - **Basel Gap**
    - **DRC**
 - **Across:**
    - **Short-term horizon (2 years)**
    - **Long-term horizon (5 years)**
- **Logistic Regression (Robustness)**
 - **Estimate probability of crisis: glm(..., family = binomial)**
 - **Extract: Coefficients, p-values, AIC**

Step 5 — Visualization

- **Financial cycle plots (credit vs trend)**
- **Basel Gap vs DRC comparison**
- **Crisis period shading**
- **Cross-country comparison charts**

-----
## 📊 Output

After running the pipeline, you will obtain:

📉 Time-series plots of financial cycles

📊 AUC comparison tables

📈 Indicator performance visualizations

------

📦 Required R Packages
 * `tidyverse`
 * `readxl`
 * `lubridate`
 * `mFilter`
 * `pROC`
 * `RcppRoll`
 * `ggplot2`

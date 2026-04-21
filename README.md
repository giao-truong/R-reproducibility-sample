# Financial Cycles and Early Warning Indicators in Nordic Countries

## 📌 Project Overview

This project analyzes financial cycle dynamics and evaluates the predictive power of early warning indicators for banking crises in Nordic countries (Denmark, Finland, Norway, Sweden).

We compare two key indicators:

- **Basel Credit-to-GDP Gap** (long-term structural imbalance)
- **DRC (Differenced Credit)** (short-term credit growth)

The goal is to assess which indicator better predicts financial crises across different time horizons.

---

## 📊 Research Questions

1. Which indicator performs better in predicting crises?
2. Does predictive power differ across countries?
3. Are short-term signals (DRC) or long-term signals (Basel Gap) more reliable?

---

## 📁 Repository Structure
│
├── code/
│ ├── 01_setup.R # Load packages and define paths
│ ├── 02_clean.R # Import and reshape raw data
│ ├── 03_construct_indicators.R # Basel Gap, DRC, crisis variables
│ ├── 04_analysis.R # AUC comparison and models
│ └── 05_visualization.R # Figures and plots
│
├── data/
│ ├── raw/
│ │ └── data.xlsx # Raw dataset (credit-to-GDP)
│ └── cleaned/ # (optional) cleaned datasets
│
├── output/
│ ├── figures/ # Generated plots
│ └── tables/ # Regression outputs
│
├── master.R # Runs full pipeline
└── README.md

---

## ⚙️ How to Run the Project

### 1. Clone the repository

```bash
git clone https://github.com/YOUR-USERNAME/R-reproducibility-sample.git
cd R-reproducibility-sample
2. Open in R / RStudio

Make sure your working directory is the project root.

3. Install required packages

source("code/01_setup.R")

4. Run the full pipeline

source("master.R")

---
🔄 Workflow Description
Step 1 — Setup
Load libraries
Define reproducible file paths
Step 2 — Data Cleaning
Import Excel dataset
Convert wide → long format
Create time variables
Step 3 — Feature Engineering
Compute Basel Gap using one-sided HP filter
Compute DRC (8-quarter difference)
Define crisis periods and targets
Step 4 — Analysis
Compute AUC (ROC performance)
Compare predictive accuracy:
Short-term (2 years)
Long-term (5 years)
Step 5 — Visualization
Plot financial cycles
Compare indicators visually
Highlight crisis periods
-----
📊 Output

After running the pipeline, you will obtain:

📉 Time-series plots of financial cycles
📊 AUC comparison tables
📈 Indicator performance visualizations

------

📚 Academic Context

This project is inspired by:

Basel III framework (credit gap methodology)
Literature on financial cycle measurement
Early warning systems for banking crises

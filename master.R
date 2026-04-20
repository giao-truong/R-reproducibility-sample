# =========================================

# MASTER SCRIPT

# =========================================

rm(list = ls())

source("code/01_setup.R")
source("code/02_clean.R")
source("code/03_construct_indicators.R")
source("code/04_analysis.R")
source("code/05_visualization.R")

cat("Pipeline completed successfully.\n")

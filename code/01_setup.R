### ---------------------- ###
### 01. Environment Setup ###
### ---------------------- ###

# Clear environment
rm(list = ls())

# Load required packages
packages <- c(
  "readxl", "tidyverse", "lubridate",
  "mFilter", "pROC", "RcppRoll", "ggplot2"
)

# Install missing packages
installed <- packages %in% installed.packages()
if (any(!installed)) install.packages(packages[!installed])

# Load packages
lapply(packages, library, character.only = TRUE)

# Set project root automatically
root <- getwd()

# Define paths
data_path   <- file.path(root, "data/raw/data.xlsx")
output_fig  <- file.path(root, "output/figures")
output_tab  <- file.path(root, "output/tables")

dir.create(output_fig, recursive = TRUE, showWarnings = FALSE)
dir.create(output_tab, recursive = TRUE, showWarnings = FALSE)

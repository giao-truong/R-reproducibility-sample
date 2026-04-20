# Install packages if missing
packages <- c("readxl", "tidyverse", "lubridate", "mFilter", "pROC", "RcppRoll")

installed <- rownames(installed.packages())

for (p in packages) {
  if (!(p %in% installed)) {
    install.packages(p)
  }
}

# Load packages
lapply(packages, library, character.only = TRUE)

set.seed(123)

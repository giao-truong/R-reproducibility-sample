# =========================================

# Setup

# =========================================

packages <- c(
"tidyverse", "readxl", "lubridate",
"here", "fixest", "modelsummary",
"ggplot2", "broom"
)

installed <- rownames(installed.packages())

for (p in packages) {
if (!(p %in% installed)) install.packages(p)
}

lapply(packages, library, character.only = TRUE)

set.seed(12345)

dir.create(here("data", "cleaned"), recursive = TRUE, showWarnings = FALSE)
dir.create(here("output", "tables"), recursive = TRUE, showWarnings = FALSE)
dir.create(here("output", "figures"), recursive = TRUE, showWarnings = FALSE)

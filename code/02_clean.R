### ------------------- ###
### 02. Data Cleaning  ###
### ------------------- ###

source("code/01_setup.R")

# Load data
data <- read_excel(data_path)

# Clean & reshape
df <- data %>%
  rename(country = 1) %>%
  pivot_longer(
    cols = -country,
    names_to = "date",
    values_to = "credit_gdp"
  ) %>%
  mutate(
    date = ymd(date),
    year = year(date),
    qtr  = quarter(date),
    year_q = sprintf("%dQ%d", year, qtr)
  ) %>%
  arrange(country, date)

# Save cleaned data
saveRDS(df, file.path(root, "data/cleaned/clean_df.rds"))

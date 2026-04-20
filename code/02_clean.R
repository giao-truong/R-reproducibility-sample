data <- read_excel("data/raw/data.xlsx")

df <- data %>%
  rename(country = 1) %>%
  pivot_longer(
    cols = -country,
    names_to  = "date",
    values_to = "credit_gdp"
  ) %>%
  mutate(
    date = ymd(date),
    year = year(date),
    qtr  = quarter(date),
    year_q = sprintf("%dQ%d", year, qtr)
  ) %>%
  arrange(country, date)

saveRDS(df, "data/cleaned/df_clean.rds")

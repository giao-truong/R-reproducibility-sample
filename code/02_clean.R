# =========================================

# Data Cleaning

# =========================================

data <- read_excel(here("data", "raw", "data.xlsx"))

df <- data %>%
rename(country = 1) %>%
pivot_longer(
cols = -country,
names_to = "date",
values_to = "credit_gdp"
) %>%
mutate(
date = ymd(date),
year = year(date)
) %>%
arrange(country, date)

write_csv(df, here("data", "cleaned", "panel.csv"))

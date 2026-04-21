### ----------------------------- ###
### 03. Construct Variables      ###
### ----------------------------- ###

source("code/01_setup.R")

df <- readRDS(file.path(root, "data/cleaned/clean_df.rds"))

### One-sided HP filter ###
calculate_onesided_hp <- function(x, lambda = 400000) {
  n <- length(x)
  trend <- rep(NA, n)
  
  if (n < 20) return(trend)
  
  for (i in 20:n) {
    current_x <- x[1:i]
    
    if (sum(!is.na(current_x)) >= 2) {
      res <- mFilter::hpfilter(na.omit(current_x), freq = lambda)
      trend[i] <- as.numeric(tail(res$trend, 1))
    }
  }
  return(trend)
}

### Basel Gap ###
df <- df %>%
  group_by(country) %>%
  mutate(
    trend = calculate_onesided_hp(credit_gdp),
    basel_gap = credit_gdp - trend
  ) %>%
  ungroup()

### DRC ###
df <- df %>%
  group_by(country) %>%
  mutate(
    drc = credit_gdp - lag(credit_gdp, 8)
  ) %>%
  ungroup()

### Crisis variables ###
df <- df %>%
  group_by(country) %>%
  mutate(
    in_crisis = case_when(
      country == "Denmark" & year %in% 1987:1992 ~ TRUE,
      country == "Finland" & year %in% 1991:1994 ~ TRUE,
      country == "Norway"  & year %in% 1987:1993 ~ TRUE,
      country == "Sweden"  & year %in% 1991:1994 ~ TRUE,
      country == "Denmark" & year %in% 2008:2014 ~ TRUE,
      country == "Sweden"  & year %in% 2008:2010 ~ TRUE,
      TRUE ~ FALSE
    ),
    
    crisis_start = in_crisis & !lag(in_crisis, default = FALSE),
    
    target_short = as.numeric(
      lead(crisis_start, 5) | lead(crisis_start, 6) |
      lead(crisis_start, 7) | lead(crisis_start, 8)
    ),
    
    target_long = as.numeric(
      RcppRoll::roll_max(as.numeric(crisis_start), n = 16,
                         align = "left", fill = NA) %>% lead(5)
    )
  ) %>%
  ungroup()

# Save
saveRDS(df, file.path(root, "data/cleaned/final_df.rds"))

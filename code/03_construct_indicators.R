df <- readRDS("data/cleaned/df_clean.rds")

calculate_onesided_hp <- function(x, lambda = 400000) {
  n <- length(x)
  trend <- rep(NA, n) 
  
  if (n < 20) return(trend)
  
  for (i in 20:n) {
    current_x <- x[1:i]
    
    if (sum(!is.na(current_x)) >= 2) {
      res <- mFilter::hpfilter(na.omit(current_x), freq = lambda, type = "lambda")
      trend[i] <- as.numeric(tail(res$trend, 1))
    }
  }
  
  return(trend)
}

df <- df %>%
  group_by(country) %>%
  mutate(
    trend = calculate_onesided_hp(credit_gdp),
    basel_gap = credit_gdp - trend
  ) %>%
  ungroup()

df <- df %>%
  group_by(country) %>%
  mutate(
    drc = credit_gdp - lag(credit_gdp, 8)
  ) %>%
  ungroup()

df <- df %>%
  group_by(country) %>%
  mutate(
    in_crisis = case_when(
      country == "Denmark" & year >= 1987 & year <= 1992 ~ TRUE,
      country == "Finland" & year >= 1991 & year <= 1994 ~ TRUE,
      country == "Norway"  & year >= 1987 & year <= 1993 ~ TRUE, 
      country == "Sweden"  & year >= 1991 & year <= 1994 ~ TRUE,
      country == "Denmark" & year >= 2008 & year <= 2014 ~ TRUE,
      country == "Sweden"  & year >= 2008 & year <= 2010 ~ TRUE,
      TRUE ~ FALSE
    ),
    
    crisis_start = in_crisis & !lag(in_crisis, default = FALSE),

    target_short = as.numeric(
      lead(crisis_start, 5) | lead(crisis_start, 6) | 
      lead(crisis_start, 7) | lead(crisis_start, 8)
    ),

    target_long = as.numeric(
      RcppRoll::roll_max(as.numeric(crisis_start), 
      n = 16, align = "left", fill = NA) %>% lead(5)
    )
  ) %>%
  ungroup()

saveRDS(df, "data/cleaned/df_final.rds")

# =========================================

# Construct Variables

# =========================================

df <- read_csv(here("data", "cleaned", "panel.csv"))

library(mFilter)
library(RcppRoll)

calculate_onesided_hp <- function(x, lambda = 400000) {
n <- length(x)
trend <- rep(NA, n)

for (i in 20:n) {
current_x <- x[1:i]
if (sum(!is.na(current_x)) >= 10) {
res <- hpfilter(na.omit(current_x), freq = lambda)
trend[i] <- tail(res$trend, 1)
}
}
trend
}

df <- df %>%
group_by(country) %>%
mutate(
trend = calculate_onesided_hp(credit_gdp),
basel_gap = credit_gdp - trend,
drc = credit_gdp - lag(credit_gdp, 8)
) %>%
ungroup()

write_csv(df, here("data", "cleaned", "panel_constructed.csv"))

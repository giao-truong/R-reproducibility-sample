# =========================================

# Descriptive Analysis

# =========================================

df <- read_csv(here("data", "cleaned", "panel_constructed.csv"))

plot_gap <- function(df, country_name) {
df %>%
filter(country == country_name) %>%
ggplot(aes(date, basel_gap)) +
geom_line() +
geom_hline(yintercept = 0, linetype = "dashed") +
theme_minimal() +
labs(title = paste("Basel Gap:", country_name))
}

countries <- unique(df$country)

for (c in countries) {
g <- plot_gap(df, c)
ggsave(here("output", "figures", paste0("gap_", c, ".png")), g)
}

### ----------------------------- ###
### 05. Visualization            ###
### ----------------------------- ###

source("code/01_setup.R")

df <- readRDS(file.path(root, "data/final_df.rds"))

plot_country <- function(country_name, crisis_periods) {
  
  df_plot <- df %>%
    filter(country == country_name)
  
  p <- ggplot(df_plot, aes(x = date)) +
    
    # Crisis shading
    lapply(crisis_periods, function(period) {
      annotate("rect",
               xmin = as.Date(period[1]),
               xmax = as.Date(period[2]),
               ymin = -Inf, ymax = Inf,
               alpha = 0.1, fill = "red")
    }) +
    
    geom_line(aes(y = credit_gdp, color = "Credit/GDP"), size = 1) +
    geom_line(aes(y = trend, color = "Trend"), linetype = "dotted") +
    
    geom_line(aes(y = basel_gap), color = "red") +
    geom_line(aes(y = drc), color = "blue") +
    
    geom_hline(yintercept = 0, linetype = "dashed") +
    
    labs(title = paste("Financial Cycle:", country_name),
         y = "Percent of GDP", x = "Year") +
    
    theme_minimal()
  
  ggsave(file.path(output_fig, paste0(country_name, ".png")), p, width = 8, height = 5)
}

# Run plots
plot_country("Denmark", list(c("1987-01-01","1992-12-31"), c("2008-01-01","2014-12-31")))
plot_country("Finland", list(c("1991-01-01","1994-12-31")))
plot_country("Norway",  list(c("1987-01-01","1993-12-31")))
plot_country("Sweden",  list(c("1991-01-01","1994-12-31"), c("2008-01-01","2010-12-31")))

### ----------------------------- ###
### 04. Empirical Analysis       ###
### ----------------------------- ###

source("code/01_setup.R")

df <- readRDS(file.path(root, "data/cleaned/final_df.rds"))

### AUC Comparison ###
country_results <- df %>%
  group_by(country) %>%
  summarise(
    auc_drc_short = as.numeric(auc(roc(target_short, drc, quiet = TRUE))),
    auc_gap_short = as.numeric(auc(roc(target_short, basel_gap, quiet = TRUE))),
    auc_drc_long  = as.numeric(auc(roc(target_long, drc, quiet = TRUE))),
    auc_gap_long  = as.numeric(auc(roc(target_long, basel_gap, quiet = TRUE)))
  )

write.csv(country_results, file.path(output_tab, "auc_results.csv"), row.names = FALSE)

### Logit robustness ###
run_logit <- function(target, predictor, data) {
  sub <- data[!is.na(data[[target]]) & !is.na(data[[predictor]]), ]
  
  if (length(unique(sub[[target]])) < 2) return(c(NA, NA))
  
  model <- glm(as.formula(paste(target, "~", predictor)),
               family = binomial, data = sub)
  
  c(coef = coef(model)[predictor], aic = AIC(model))
}

logit_results <- df %>%
  group_by(country) %>%
  do({
    d2 <- run_logit("target_short", "drc", .)
    g2 <- run_logit("target_short", "basel_gap", .)
    
    data.frame(
      drc_coef = d2[1],
      gap_coef = g2[1],
      drc_aic  = d2[2],
      gap_aic  = g2[2]
    )
  })

write.csv(logit_results, file.path(output_tab, "logit_results.csv"), row.names = FALSE)

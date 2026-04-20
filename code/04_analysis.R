df <- readRDS("data/cleaned/df_final.rds")

library(dplyr)
library(pROC)

calculate_auc <- function(data, target, predictor) {
  
  sub_data <- data %>%
    filter(!is.na(.data[[target]]), !is.na(.data[[predictor]]))
  
  # Avoid crashes if no variation
  if (length(unique(sub_data[[target]])) < 2) return(NA)
  
  return(as.numeric(auc(roc(sub_data[[target]], sub_data[[predictor]], quiet = TRUE))))
}

results_auc <- df %>%
  group_by(country) %>%
  summarise(
    auc_drc_short = calculate_auc(cur_data(), "target_short", "drc"),
    auc_gap_short = calculate_auc(cur_data(), "target_short", "basel_gap"),
    auc_drc_long  = calculate_auc(cur_data(), "target_long", "drc"),
    auc_gap_long  = calculate_auc(cur_data(), "target_long", "basel_gap")
  ) %>%
  mutate(
    winner_short = ifelse(auc_drc_short > auc_gap_short, "DRC", "Basel"),
    winner_long  = ifelse(auc_gap_long > auc_drc_long, "Basel", "DRC")
  )

print(results_auc)

write.csv(results_auc, "output/tables/auc_results.csv", row.names = FALSE)

run_logit <- function(data, target, predictor) {
  
  sub_data <- data %>%
    filter(!is.na(.data[[target]]), !is.na(.data[[predictor]]))
  
  if (length(unique(sub_data[[target]])) < 2) {
    return(data.frame(coef = NA, pval = NA, aic = NA))
  }
  
  model <- tryCatch(
    glm(as.formula(paste(target, "~", predictor)),
        family = binomial,
        data = sub_data),
    error = function(e) NULL
  )
  
  if (is.null(model)) {
    return(data.frame(coef = NA, pval = NA, aic = NA))
  }
  
  return(data.frame(
    coef = coef(model)[predictor],
    pval = summary(model)$coefficients[predictor, "Pr(>|z|)"],
    aic  = AIC(model)
  ))
}

results_logit <- df %>%
  group_by(country) %>%
  do({
    
    d2 <- run_logit(., "target_short", "drc")
    g2 <- run_logit(., "target_short", "basel_gap")
    
    d5 <- run_logit(., "target_long", "drc")
    g5 <- run_logit(., "target_long", "basel_gap")
    
    data.frame(
      horizon = c("2y", "5y"),
      
      drc_coef = c(d2$coef, d5$coef),
      drc_pval = c(d2$pval, d5$pval),
      drc_aic  = c(d2$aic,  d5$aic),
      
      gap_coef = c(g2$coef, g5$coef),
      gap_pval = c(g2$pval, g5$pval),
      gap_aic  = c(g2$aic,  g5$aic)
    )
    
  }) %>%
  ungroup()

print(results_logit)

write.csv(results_logit, "output/tables/logit_results.csv", row.names = FALSE)

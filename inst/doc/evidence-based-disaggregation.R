## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(collapse = TRUE, comment = "#>")

## ----conjugate, eval = requireNamespace("BayesianDisaggregation", quietly = TRUE)----
library(BayesianDisaggregation)

sim <- simulate_disagg(T = 30, K = 4, seed = 1)   # synthetic CPI + VAB weights
bl  <- disaggregate_conjugate(sim$cpi, sim$W, n_draws = 100, seed = 1)
bl

## the smoothed aggregate tracks the CPI tightly (aggregate is well identified)
round(cor(bl$agg_summary[, "median"], sim$cpi), 4)

## joint posterior draws: the [T, K, draws] contract consumed by the nested OU
dim(bl$phi_draws)

## ----statespace, eval = FALSE-------------------------------------------------
# fit <- disaggregate_statespace(sim$cpi, sim$W, chains = 4, iter = 2000, warmup = 1000)
# fit$diagnostics                 # rhat_max, divergences
# dim(fit$phi_draws)              # T x K x draws
# str(fit$phi_summary)            # median, q2.5, q97.5 (T x K each)
# 
# ## couple to the nested OU (uncertainty propagated by Rubin's rule):
# ## bayesianOU::fit_ou_nested_mi(phi_draws = fit$phi_draws, X = Phi_index, ...)

## ----fromfiles, eval = FALSE--------------------------------------------------
# cpi_file <- system.file("extdata", "CPI.xlsx", package = "BayesianDisaggregation")
# w_file   <- system.file("extdata", "WEIGHTS.xlsx", package = "BayesianDisaggregation")
# fit <- disaggregate_from_files(cpi_file, w_file, chains = 2, iter = 1000)


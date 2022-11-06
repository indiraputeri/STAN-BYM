#fit model icar.stan to NYC census tracts neighborhood map
#Morris, M., Wheeler-Martin, K., Simpson, D., Mooney, S. J., Gelman, A., & DiMaggio, C. (2019).
#Bayesian hierarchical spatial models: Implementing the Besag York Mollié model in stan.
#Spatial and spatio-temporal epidemiology, 31, 100301.

library(rstan);
rstan_options(auto_write = TRUE)

options(mc.cores = parallel::detectCores())
source(file = "PolyNYtracts.R");
icar_nyc_stanfit = stan("icar.stan",
                        data = list(N, N_edges, node1, node2),
                        control = list(max_treedepth = 15));

check_hmc_diagnostics(icar_nyc_stanfit);
print(icar_nyc_stanfit, probs = c(0.25, 0.75), digits_summary = 1)
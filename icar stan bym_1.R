#fit model icar.stan to NYC census tracts neighborhood map
library(rstan);
rstan_options(auto_write = TRUE)

options(mc.cores = parallel::detectCores())
source(file = "bym_nyc_data.R");
icar_nyc_stanfit = stan("icar.stan",
                        data = list(N, N_edges, node1, node2),
                        control = list(max_treedepth = 15));
check_hmc_diagnostics(icar_nyc_stanfit);
print(icar_nyc_stanfit, probs = c(0.25, 0.75), digits_summary = 1)

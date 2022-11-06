install.packages("rgdal")

library(readr);
library(maptools);
library(spdep);
library(rgdal)
library(rstan);
options(mc.cores = 3);

#load("nyc_subset.data.R")   // example from https://mc-stan.org/users/documentation/case-studies/icar_stan.html
bym_nyc_data <- read.csv("/Users/indirapkinasih/R Project/STAN/bym_nyc_study.csv");

nyc_shp<-readOGR("nycTracts10", layer="nycTracts10");

#geoids <- nyc_shp$GEOID10 %in% nyc_tractIDs //example from https://mc-stan.org/users/documentation/case-studies/icar_stan.html
geoids <- bym_nyc_data$census_tract %in% nyc_tractIDs;
nyc_subset_shp <- nyc_shp[geoids,];
#nyc_subset_shp <- nyc_subset_shp[order(nyc_subset_shp$GEOID10),];
nb_nyc_subset = poly2nb(nyc_subset_shp);

source("nb2graph.R");
nbs=nb2graph(nb_nyc_subset);
N = nbs$N;
node1 = nbs$node1;
node2 = nbs$node2;
N_edges = nbs$N_edges
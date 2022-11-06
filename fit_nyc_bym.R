#example from https://mc-stan.org/users/documentation/case-studies/icar_stan.html

install.packages("rgdal")

library(readr);
library(maptools);
library(spdep);
library(rgdal)
library(rstan);
options(mc.cores = 3);

#load("nyc_subset.data.R");  
#geoids <- nyc_shp$GEOID10 %in% nyc_tractIDs;                                       #length = 2168 
#nyc_subset_shp <- nyc_shp[geoids,];                                                #length = 1863
#nyc_subset_shp <- nyc_subset_shp[order(nyc_subset_shp$GEOID10),];                  #length = 1863
#nb_nyc_subset = poly2nb(nyc_subset_shp);

##MODIFICATION##
bym_nyc_data <- read.csv("/Users/indirapkinasih/R Project/STAN/bym_nyc_study.csv"); #length = 2095
nyc_shp<-readOGR("nycTracts10", layer="nycTracts10");                               #length = 2168
geoids <- bym_nyc_data$census_tract %in% nyc_tractIDs;                              #length = 2095
nyc_ashp <- nyc_shp[geoids,]
nb_nyc = poly2nb(geoids)


source("nb2graph.R");
nbs=nb2graph(nb_nyc_subset);
N = nbs$N;
node1 = nbs$node1;
node2 = nbs$node2;
N_edges = nbs$N_edges
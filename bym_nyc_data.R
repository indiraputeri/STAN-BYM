install.packages("spdep")

library(spdep)
library(sf)
library(sp)
library(lwgeom)
library(readr)

bym_nyc_data <- read.csv("/Users/indirapkinasih/R Project/STAN/bym_nyc_study.csv")

p <- read_sf("nycTracts10.shp")

p.nb <- poly2nb(p)

coords <- st_coordinates(st_centroid(st_geometry(p)))

plot(st_geometry(p), border="grey")
plot(p.nb, coords, pch = 19, cex = 0.4, add=TRUE)

source("nb2graph.R");
nbs=nb2graph(p.nb);
N = nbs$N;
node1 = nbs$node1;
node2 = nbs$node2;
N_edges = nbs$N_edges

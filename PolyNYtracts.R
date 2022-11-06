install.packages("lwgeom")
install.packages("sf")
install.packages("sp")
install.packages("spdep")

library(spdep)
library(sf)
library(sp)
library(lwgeom)

p <- read_sf("nycTracts10.shp")

p.nb <- poly2nb(p)

coords <- st_coordinates(st_centroid(st_geometry(p))) # this seems to miss some polygons

plot(st_geometry(p), border="grey")
plot(p.nb, coords, pch = 19, cex = 0.4, add=TRUE)
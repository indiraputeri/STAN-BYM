install.packages("spdep")
install.packages("maptools")
library(spdep)
library(maptools) 


#nyc_all_tracts.shp<-readShapePoly("nycTracts10/nycTracts10");

NY8 <- as(sf::st_read(system.file("shapes/nycTracts10.shp", package="spData")), "Spatial")
NY_nb <- read.gal(system.file("weights/NY_nb.gal", package="spData"), region.id=as.character(as.integer(row.names(NY8))-1L))

#Newyork <- NY8[NY8$AREANAME == "New York",]
#Sy0_nb <- subset(NY_nb, NY8$AREANAME == "NewYo")
summary(NY_nb)

source("nb2graph.R");
nbs=nb2graph(nb_nyc_subset);
N = nbs$N;
node1 = nbs$node1;
node2 = nbs$node2;
N_edges = nbs$N_edges

install.packages("sp")
library(sp)

class(NY8)
Sy1_nb <- poly2nb(NY8)
isTRUE(all.equal(NY8, Sy1_nb, check.attributes=FALSE))

Sy2_nb <- poly2nb(NY8, queen=FALSE)
isTRUE(all.equal(NY8, Sy2_nb, check.attributes=FALSE))

oopar <- par(mfrow=c(1,2), mar=c(3,3,1,1)+0.1)
plot(NY8, border="grey60")
plot(NY8, coordinates(NY8), add=TRUE, pch=19, cex=0.6)
text(bbox(NY8)[1,1], bbox(NY8)[2,2], labels="a)", cex=0.8)
plot(NY8, border="grey60")
plot(NY8, coordinates(NY8), add=TRUE, pch=19, cex=0.6)
plot(diffnb(NY8, Sy2_nb, verbose=FALSE), coordinates(NY8),
     add=TRUE, pch=".", cex=0.6, lwd=2)

text(bbox(NY8)[1,1], bbox(NY8)[2,2], labels="b)", cex=0.8)
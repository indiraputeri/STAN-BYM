install.packages("spdep")
library(spdep)

NY8 <- as(sf::st_read(system.file("shapes/NY8_utm18.shp", package="spData")), "Spatial")
NY_nb <- read.gal(system.file("weights/NY_nb.gal", package="spData"), region.id=as.character(as.integer(row.names(NY8))-1L))

Syracuse <- NY8[NY8$AREANAME == "Syracuse city",]
Sy0_nb <- subset(NY_nb, NY8$AREANAME == "Syracuse city")
summary(Sy0_nb)

install.packages("sp")

class(Syracuse)
Sy1_nb <- poly2nb(Syracuse)
isTRUE(all.equal(Sy0_nb, Sy1_nb, check.attributes=FALSE))

Sy2_nb <- poly2nb(Syracuse, queen=FALSE)
isTRUE(all.equal(Sy0_nb, Sy2_nb, check.attributes=FALSE))

oopar <- par(mfrow=c(1,2), mar=c(3,3,1,1)+0.1)
plot(Syracuse, border="grey60")
plot(Sy0_nb, coordinates(Syracuse), add=TRUE, pch=19, cex=0.6)
text(bbox(Syracuse)[1,1], bbox(Syracuse)[2,2], labels="a)", cex=0.8)
plot(Syracuse, border="grey60")
plot(Sy0_nb, coordinates(Syracuse), add=TRUE, pch=19, cex=0.6)
plot(diffnb(Sy0_nb, Sy2_nb, verbose=FALSE), coordinates(Syracuse),
     add=TRUE, pch=".", cex=0.6, lwd=2)

text(bbox(Syracuse)[1,1], bbox(Syracuse)[2,2], labels="b)", cex=0.8)
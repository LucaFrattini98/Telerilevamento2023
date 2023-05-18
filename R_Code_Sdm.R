# R code for species distribution modelling

install.packages("sdm")
install.packages("rgdal", dependencies = T)
library(sdm)
library(rgdal)
library(raster)

file <- system.file("external/species.shp", package = "sdm")
species <- shapefile(file)
species

plot(species, pch = 19)

presences <-  species[species$Occurrence == 1,]
presences

absences <- species[species$Occurrence == 0,]
absences

plot(presences, col="blue", pch = 19)

# plot together presences and absences
points(absences, col="red", pch = 19)

# predictors: look at the path
path <- system.file("external", package="sdm")

# list the predictors
lst <- list.files(path=path, pattern='asc', full.names = T)
lst

# stack
preds <- stack(lst)
plot(preds)

# presence - elevation
plot(preds$elevation)
points(presences, pch=19)

# presence - temperature
plot(preds$temperature)
points(presences, pch=19)

# presence - precipitation
plot(preds$precipitation)
points(presences, pch=19)

# presence - vegetation
plot(preds$vegetation)
points(presences, pch=19)

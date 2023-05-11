# 27/04 How to measure landscape variability with R

install.packages("viridis")
install.packages("ggplot2")

library(viridis)
library(raster)
library(ggplot2)
library(patchwork)

setwd(("C:/Lab/"))
glacier <- brick("Similaun.png") # sentinel2 image of Similaun glacier

plotRGB(glacier, 1,2,3, stretch = "lin") # 1 = NIT, 2 = red, 3 = green

# standard deviation on the NIR band
nir <- glacier[[1]]
mean3 <- focal(nir, matrix(1/9, 3, 3), fun = mean)
sd3 <- focal(nir, matrix(1/9, 3, 3), fun = sd)

plot(mean3)
plot(sd3)

# Plotting
sd3d <- as.data.frame(sd3, xy=T) # trasforming the raster in a data frame to plot it
ggplot() +
  geom_raster(sd3d, mapping=aes(x=x, y=y, fill=layer)) +
  ggtitle("Stndard deviation moving window 3x3")

# Using viridis and other visualization palettes
ggplot() +
  geom_raster(sd3d, mapping=aes(x=x, y=y, fill=layer)) +
  ggtitle("Stndard deviation moving window 3x3") +
  scal_fill_viridis()

ggplot() +
  geom_raster(sd3d, mapping=aes(x=x, y=y, fill=layer)) +
  ggtitle("Stndard deviation moving window 3x3") +
  scal_fill_viridis(option="cividis")

# patchwork

library(patchwork)

p1 <- ggplot() +
  geom_raster(sd3d, mapping=aes(x=x, y=y, fill=layer)) +
  ggtitle("Stndard deviation moving window 3x3") +
  scal_fill_viridis()

p2 <- ggplot() +
  geom_raster(sd3d, mapping=aes(x=x, y=y, fill=layer)) +
  ggtitle("Stndard deviation moving window 3x3") +
  scal_fill_viridis(option="cividis")

p1 + p2

# ------------------------------------------------------------------------------
# R code variability

library(raster)
# library(RStoolbox) # for image viewing and variability calculation
library(ggplot2) # for ggplot plotting
library(patchwork) # multiframe with ggplot2 graphs
# install.packages("viridis")
library(viridis)

setwd("~/lab/") # Linux
# setwd("C:/lab/") # Windows
# setwd("/Users/name/Desktop/lab/") # Mac

# Exercise: import the Similaun image
sen <- brick("sentinel.png")

# band1 = NIR
# band2 = red
# band3 = green

# Exercise: plot the image by the ggRGB function
plotRGB(sen, 1, 2, 3, stretch="lin")

# NIR on g component
plotRGB(sen, 2, 1, 3)

# calculation of variability over NIR
nir <- sen[[1]]

sd3 <- focal(nir, matrix(1/9, 3, 3), fun=sd)

clsd <- colorRampPalette(c('blue','green','pink','magenta','orange','brown','red','yellow'))(100) #
plot(sd3, col=clsd)

# plotting with ggplot
sd3d <- as.data.frame(sd3, xy=T)

ggplot() +
geom_raster(sd3d, mapping=aes(x=x, y=y, fill=layer))

# with viridis
ggplot() +
geom_raster(sd3d, mapping =aes(x=x, y=y, fill=layer)) +
scale_fill_viridis() +
ggtitle("Standard deviation by viridis package")

# cividis
ggplot() +
geom_raster(sd3d, mapping =aes(x=x, y=y, fill=layer)) +
scale_fill_viridis(option = "cividis") +
ggtitle("Standard deviation by viridis package")

# magma
ggplot() +
geom_raster(sd3d, mapping =aes(x=x, y=y, fill=layer)) +
scale_fill_viridis(option = "magma") +
ggtitle("Standard deviation by viridis package")

# inferno
ggplot() +
geom_raster(sd3d, mapping =aes(x=x, y=y, fill=layer)) +
scale_fill_viridis(option = "inferno") +
ggtitle("Standard deviation by viridis package")

# patchwork
p1 <- ggplot() +
geom_raster(sd3d, mapping =aes(x=x, y=y, fill=layer)) +
scale_fill_viridis() +
ggtitle("Standard deviation by viridis package")

p2 <- ggplot() +
geom_raster(sd3d, mapping =aes(x=x, y=y, fill=layer)) +
scale_fill_viridis(option = "inferno") +
ggtitle("Standard deviation by viridis package")

p1 + p2

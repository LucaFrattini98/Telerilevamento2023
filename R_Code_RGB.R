# 24/03 -------------------------------------------------------------------------------------------------------------------------

# Insatlling packeges
install.packages("raster")
library(raster)

# setting working directory
setwd("C:/Lab/")

# importing image with all its bands
l2011 <- brick("p224r63_2011_masked.grd") # importing image with all its bands

# plotting only the 4th band (NIR)
plot(l2011[[4]]) 

# visualizing an image with natural colors associating the landsat bands to the RGB ones
plotRGB(l2011, r=3, g=2, b=1, stretch="Lin")

# associating the landsat NIR band (band number 4) to the Red band of RGB, in this way i can see thr infrared
plotRGB(l2011, r=4, g=3, b=2, stretch="Lin")

# associating the NIR band to the color green
plotRGB(l2011, r=3, g=4, b=2, stretch="Lin")

# associating the NIR band to the color blue
plotRGB(l2011, r=3, g=2, b=4, stretch="Lin") # stretch=Lin stretches the values in a linear way, this helps to have a better visualization of the image

l1988 <- brick("p224r63_1988_masked.grd")
plot(l1988[[4]])

# i can divide the plot image in rows and columns (multiframe)
par(mfrow=c(2,1)) # mf stands for multiframe, 2 indicates the numbers of rows, 1 the numbers of columns
plotRGB(l1988, r=4, g=3, b=2, stretch="Lin")
plotRGB(l2011, r=4, g=3, b=2, stretch="Lin")

# I can write the code also without writing r, g, b but just with the band numbers
plotRGB(l2011, 4, 3, 2, stretch="Lin")

# to clear the plot wiev
dev.off()

# image strech differences
par(mfrow=c(2,2))
plotRGB(l1988, r=4, g=3, b=2, stretch="Lin")
plotRGB(l2011, r=4, g=3, b=2, stretch="Lin")
plotRGB(l1988, r=4, g=3, b=2, stretch="Hist")
plotRGB(l2011, r=4, g=3, b=2, stretch="Hist")

# -----------------------------------------------------------------------------------

# Questo è il primo script che useremo a lezione

# install.packages("raster")
library(raster)

# Settaggio cartella di lavoro
setwd("~/lab/") # Linux
# setwd("/Users/emma/desktop/lab") #mac
# setwd("C:/lab/") # windows

# import
l2011 <- brick("p224r63_2011.grd")
l2011

# plot
plot(l2011)

# https://www.r-graph-gallery.com/42-colors-names.html
cl <- colorRampPalette(c("black", "grey", "light grey")) (100)
plot(l2011, col=cl)

# dev.off()

# Landsat ETM+
# b1 = blu
# b2 = verde
# b3 = rosso
# b4 = infrarosso vicino NIR

# plot della banda del blu - B1_sre
plot(l2011$B1_sre) # trinity
# or
plot(l2011[[1]]) # neo

plot(l2011$B1_sre)
cl <- colorRampPalette(c("black", "grey", "light grey")) (100)
plot(l2011$B1_sre, col=cl)

# plot b1 from dark blue to blue to light blue
clb <- colorRampPalette(c("dark blue", "blue", "light blue")) (100)
plot(l2011$B1_sre, col=clb)

# let's export the image and let it appear in the lab folder: kind of magic!
pdf("banda1.pdf")
plot(l2011$B1_sre, col=clb)
dev.off()

png("banda1.png")
plot(l2011$B1_sre, col=clb)
dev.off()

# plot b2 from dark green to green to light green
clg <- colorRampPalette(c("dark green", "green", "light green")) (100)
plot(l2011$B2_sre, col=clg)

# multiframe
par(mfrow=c(1,2))
plot(l2011$B1_sre, col=clb)
plot(l2011$B2_sre, col=clg)
dev.off()

# export multiframe plot
pdf("multiframe.pdf")
par(mfrow=c(1,2))
plot(l2011$B1_sre, col=clb)
plot(l2011$B2_sre, col=clg)
dev.off()

# exercise: revert the multiframe
par(mfrow=c(2,1))
plot(l2011$B1_sre, col=clb)
plot(l2011$B2_sre, col=clg)

# let's plot the first four bands
par(mfrow=c(2,2))
# blue
plot(l2011$B1_sre, col=clb)
# green
plot(l2011$B2_sre, col=clg)
# red
clr <- colorRampPalette(c("dark red", "red", "pink")) (100)
plot(l2011$B3_sre, col=clr)
# NIR
clnir <- colorRampPalette(c("red", "orange", "yellow")) (100)
plot(l2011$B4_sre, col=clnir)

# Day #3

# Plot of l2011 in the NIR channel (NIR band)
clnir <- colorRampPalette(c("red", "orange", "yellow")) (100)
plot(l2011$B4_sre, col=clnir)
# or:
plot(l2011[[4]])

# Landsat ETM+
# b1 = blu
# b2 = verde
# b3 = rosso
# b4 = infrarosso vicino NIR

# plot RGB layers
plotRGB(l2011, r=3, g=2, b=1, stretch="lin")
plotRGB(l2011, r=3, g=4, b=2, stretch="lin")
plotRGB(l2011, r=3, g=2, b=4, stretch="lin")

plotRGB(l2011, r=3, g=4, b=2, stretch="hist")

# Exercise: build a multiframe with visible RGB
# (linear stretch) on top of false colours
# (histogram stretch)
par(mfrow=c(2,1))
plotRGB(l2011, r=3, g=2, b=1, stretch="lin")
plotRGB(l2011, r=3, g=4, b=2, stretch="hist")

# Exercise: upload the image from 1988
l1988 <- brick("p224r63_1988.grd")
l1988

par(mfrow=c(2,1))
plotRGB(l1988, r=4, g=3, b=2, stretch="lin")
plotRGB(l2011, r=4, g=3, b=2, stretch="lin")

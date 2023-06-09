# 30/04 ------------------------------------------------------------------------------------------------

library(raster)
setwd("C:/Lab/")

l2006 <- brick("defor2_.png")
l2006 <- brick("defor2_.png")

plot(l2006)
plotRGB(l2006$defor2__1, 1, 2, 3, stretch="Lin")

l1992 <- brick("defor1_.png")
l1992

plot(l1992)
plotRGB(l1992, 1, 2, 3, stretch="Lin")
plotRGB(l2006, 1, 2, 3, stretch="Lin")

par(mfrow=c(2,1))
plotRGB(l1992, 1, 2, 3, stretch="Lin")
plotRGB(l2006, 1, 2, 3, stretch="Lin")

l2006 <- brick("defor2_.png")

# put the two images beside each other

par(mfrow=c(1,2)) # invece di c(2,1) come prima
plotRGB(l1992, 1, 2, 3, stretch="Lin")
plotRGB(l2006, 1, 2, 3, stretch="Lin")


# DVI Difference Vegetation Index

dvi1992 = l1992[[1]] - l1992[[2]] # a bigger difference in the DVI means a deforestation

cl <- colorRampPalette(c('darkblue','yellow','red','black'))(100) # specifying a color scheme
plot(dvi1992, col=cl)


dvi2006 = l2006[[1]] - l2006[[2]]
plot(dvi2006, col=cl)


# multitemporal comparison dvi 1992 - dvi 2006

difdvi = dvi1992 - dvi2006

cld = colorRampPalette(c('blue','white','red'))(100)

plot(difdvi, col=cld)

dev.off()


# in a 8bit image the DVI range is: -255 a 255
# Range DVI (16 bit): -65535 a 65535 i can't compare the DVI of to images with different bits
# to overcome this problem we can standardize the dvi (NDVI) normalized dvi, NDVI as always a range between 1 e -1
# so we can use NDVI to make comparisons between images with different bits

ndvi1992 = dvi1992/(l1992[[1]] + l1992[[2]])
plot(ndvi1992, col=cl)

ndvi2006 = dvi2006/(l2006[[1]] + l2006[[2]])
plot(ndvi2006, col=cl)

difndvi = ndvi1992 - ndvi2006
plot(difndvi, col= cld)

# la risoluzione di una immagine è composta da 3 tipologie:
# risoluzione spaziale = dimensione pixel
# risoluzione spettrale = numero di bande
# risoluzione radiometrica = numero di bit di quella immagine


# Multiframe with NDVI1992 on top of the NDVI2006 image
par(mfrow=c(2,1))
plot(ndvi1992, col=cl)
plot(ndvi2006, col=cl)


setwd("C:/Lab/Greenland")

lst_2000 <- raster("lst_2000.tif") # "raster" function imports the single bands and not the whole data as the "brick" function
plot(lst_2000)

dev.off()

# importing all the data
lst_2005 <- raster("lst_2005.tif")
lst_2010 <- raster("lst_2010.tif")
lst_2015 <- raster("lst_2015.tif")

# per vedere che siano state caricate tutte usiamo questa funzione che ci fa la lista di tutti gli oggetti caricati

ls()

# per caricarle tutte insieme invece di una alla volta usiamo la funzione lapply che applica la funzione raster alla lista di oggetti creata
# per prima cosa creiamo la lista
rlist <- list.files(pattern="lst") # il pattern è un pezzo di nome comune agli oggetti che vogliamo caricare in questo caso lst

lapply(rlist, raster) # applica una funzione ad una determinata lista

# -----------------------------------------------------------------------------------------------------------
library(raster)

setwd("~/lab/") # Linux
# setwd("C:/lab/") # Windows
# setwd("/Users/name/Desktop/lab/") # Mac

# Exercise: import the first file -> defor1_.jpg -> give it the name l1992
l1992 <- brick("defor1_.png")

plotRGB(l1992, r=1, g=2, b=3, stretch="lin")

# layer 1 = NIR
# layer 2 = red
# layer 3 = green


# Exercise: import the second file -> defor2_.jpg -> give it the name l2006
l2006 <- brick("defor2_.png")

# l2006 <- brick("p224r63_2011.grd")
l2006

plotRGB(l2006, r=1, g=2, b=3, stretch="lin")

# Exercise: plot in a multiframe the two images with one on top of the other
par(mfrow=c(2,1))
plotRGB(l1992, r=1, g=2, b=3, stretch="lin")
plotRGB(l2006, r=1, g=2, b=3, stretch="lin")

# DVI Difference Vegetation Index
dvi1992 = l1992[[1]] - l1992[[2]]
# or:
# dvi1992 = l1992$defor1_.1 - l1992$defor1_.2
dvi1992

cl <- colorRampPalette(c('darkblue','yellow','red','black'))(100) # specifying a color scheme
plot(dvi1992, col=cl)

# DVI Difference Vegetation Index
dvi2006 = l2006[[1]] - l2006[[2]]
dvi2006

plot(dvi2006, col=cl)


# DVI difference in time
dvi_dif = dvi1992 - dvi2006
cld <- colorRampPalette(c('blue','white','red'))(100)
plot(dvi_dif, col=cld)

#- day 2

# Range DVI (8 bit): -255 a 255
# Range NDVI (8 bit): -1 a 1

# Range DVI (16 bit): -65535 a 65535
# Range NDVI (16 bit): -1 a 1

# Hence, NDVI can be used to compare images with a different radiometric resolution

# NDVI 1992
dvi1992 = l1992[[1]] - l1992[[2]]
ndvi1992 = dvi1992 / (l1992[[1]] + l1992[[2]])
# or
ndvi1992 = (l1992[[1]] - l1992[[2]]) / (l1992[[1]] + l1992[[2]])

cl <- colorRampPalette(c('darkblue','yellow','red','black'))(100) # specifying a color scheme
plot(ndvi1992, col=cl)

# multiframe con il plotRGB dell'immagine sopra
# e l'ndvi sotto

# Multiframe with plotRGB on top of the NDVI image
par(mfrow=c(2,1))
plotRGB(l1992, r=1, g=2, b=3, stretch="lin")
plot(ndvi1992, col=cl)

# 2006
ndvi2006 = dvi2006 / (l2006[[1]] + l2006[[2]])

# Multiframe with NDVI1992 on top of the NDVI2006 image
par(mfrow=c(2,1))
plot(ndvi1992, col=cl)
plot(ndvi2006, col=cl)

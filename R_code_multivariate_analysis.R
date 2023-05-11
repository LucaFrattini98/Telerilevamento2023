# how to reduce a multidimensional dataset

#loading the needed packages
library(raster)
library(ggplot2)
library(viridis)

# Setting the working directory for macOS
setwd("~/Documents/lab")

#loading the image
sen <- brick("sentinel.png")

#plotting the image just loaded
plot(sen)

#creating a stack without the 4 band (because the 4 band is equal to 0)
sen2 <- stack(sen[[1]], sen[[2]], sen[[3]])
plot(sen2)

# calculating the correletion between the 3 different bands
pairs(sen2)

# lets compact the 3 different bands in a single one

# PCA (Principal Component Analysis)
sample <- sampleRandom(sen2, 10000) #lets select a randomic sample of 10000 pixels
sample # these are the 10000 randomic samples with theirs correspective values in the 3 different bands

pca <- prcomp(sample) #pcs = principal component analisis

summary(pca)# the first componend alone can explain the 73% of the variability
#the firs one is by thefinition the component with the higest explained variability
#the 3 component has the least informations

# correlation with original bands
pca

# pc map
pci <- predict(sen2, pca, index=c(1:3)) #
plot(pci)# we can graphically see that the 1 componend contains the most informaitions while the 3 component doesn't have almost any informations
plot(pci[[1]])

# ggplot

pcid <- as.data.frame(pci[[1]], xy=T)
pcid

ggplot() +
geom_raster(pcid, mapping=aes(x=x, y=y, fill=PC1)) +
scale_fill_viridis() # direction=-1 in case of reverse colour ramp

# focal sd
sd3 <- focal(pci[[1]], matrix(1/9, 3, 3), fun=sd)

sd3d <- as.data.frame(sd3, xy=T)

ggplot() +
geom_raster(sd3d, mapping=aes(x=x, y=y, fill=layer)) +
scale_fill_viridis()


# ----------------------------------------------------
# R_code_multivariate_analysis.r

library(raster)
library(ggplot2)

setwd("~/lab/") # Linux
# setwd("C:/lab/") # Windows
# setwd("/Users/name/Desktop/lab/") # Mac

sen <- brick("sentinel.png")

sen
plot(sen)

sen2 <- stack(sen[[1]], sen[[2]], sen[[3]])

plot(sen2)

pairs(sen2)

# PCA (Principal Component Analysis)
sample <- sampleRandom(sen2, 10000)
pca <- prcomp(sample)

# variance explained
summary(pca)

# correlation with original bands
pca

# pc map
pci <- predict(sen2, pca, index=c(1:2))

plot(pci[[1]])

# ggplot
pcid <- as.data.frame(pci[[1]], xy=T)

ggplot() +
geom_raster(pcid, mapping = aes(x=x, y=y, fill=PC1)) +
scale_fill_viridis()


# speeding up analyses
# aggregate cells: resampling (ricampionamento)
senres <- aggregate(sen, fact=10)

# then repeat the PCA analysis

#! /usr/bin/Rscript --vanilla
############################################
### File:	boxplot_jitter.R
### Author:	Blanca A. Vargas-Govea
### Email:	blanca.vg@gmail.com
### Date:	28-Oct-2010
### Data:	diamonds.tab,diamondstoy.tab
############################################
library(ggplot2)
library(proto)

# Geoms = geometric objects: geoms that enable you to investigate two-dimensional relationships: point, smooth, boxplot, path and line

data(diamonds)
# Using a reduced sample
set.seed(1410) # Make the sample reproducible
dsmall <- diamonds[sample(nrow(diamonds), 100), ]

# explores how the distribution of price per carat varies with the colour of the diamond

#jitter
qplot(color,price / carat, data = diamonds, geom = "jitter")
ggsave(file = "../figures/jitter.png")

qplot(color,price / carat, data = diamonds, geom = "boxplot")
ggsave(file = "../figures/boxplot.png")

# The overplotting seen in the plot of jittered values can be alleviated some-what by using semi-transparent points using the alpha argument. Transparent points make it easier to see where the bulk of the points lie

qplot(color,price / carat, data = diamonds, geom = "jitter", alpha = I(1/5))
ggsave(file = "../figures/boxplotalpha5.png")
qplot(color,price / carat, data = diamonds, geom = "jitter", alpha = I(1/50))
ggsave(file = "../figures/boxplotalpha50.png")
qplot(color,price / carat, data = diamonds, geom = "jitter", alpha = I(1/200))
ggsave(file = "../figures/boxplotalpha200.png")

# using aesthetic features
qplot(color,price / carat, data = diamonds, geom = "jitter", size = cut)
ggsave(file = "../figures/jittersize.png")

qplot(color,price / carat, data = diamonds, geom = "jitter", colour = clarity)
ggsave(file = "../figures/jittercolour.png")

qplot(color,price / carat, data = diamonds, geom = "boxplot", outlier.colour = "green")
ggsave(file = "../figures/boxplotcolour.png")


dev.off()
q(status=1)

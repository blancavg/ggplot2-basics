#! /usr/bin/Rscript --vanilla
############################################
### File: hwggp2.R
### Author: Blanca A. Vargas-Govea
### Email: blanca.vg@gmail.com
### Date: 26-Oct-2010
### Data: diamonds.tab,diamondstoy.tab
############################################
library(ggplot2)
library(proto)


data(diamonds)
qplot(carat, price, data = diamonds)
ggsave(file = "../figures/caratprice.png")

qplot(log(carat), log(price), data = diamonds)
ggsave(file = "../figures/logcaratprice.png")

#relationship between the volume of the diamond (approximated by x × y × z) and its weight, we could do the following:
qplot(carat, x * y * z, data = diamonds)
ggsave(file = "../figures/volumeweight.png")

# Using a reduced sample
set.seed(1410) # Make the sample reproducible
dsmall <- diamonds[sample(nrow(diamonds), 100), ]

qplot(carat, price, data = dsmall)
ggsave(file = "../figures/caratpriced_dsmall.png")

qplot(log(carat), log(price), data = dsmall)
ggsave(file = "../figures/logcaratprice.png")

qplot(carat, x * y * z, data = dsmall)
ggsave(file = "../figures/volumeweight_dsmall.png")

qplot(carat, price, data = dsmall, colour = color)
ggsave(file = "../figures/cpcolor_dsmall.png")

qplot(carat, price, data = dsmall, size = cut)
ggsave(file = "../figures/cpsize_dsmall.png")

qplot(carat, price, data = dsmall, shape = cut)
ggsave(file = "../figures/cpcut_dsmall.png")

qplot(carat, price, data = diamonds, alpha = I(1/10))
ggsave(file = "../figures/cptrans10.png")

qplot(carat, price, data = diamonds, alpha = I(1/100))
ggsave(file = "../figures/cptrans100.png")

qplot(carat, price, data = diamonds, alpha = I(1/200))
ggsave(file = "../figures/cptrans200.png")

dev.off()
q(status=1)

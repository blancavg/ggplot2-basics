#! /usr/bin/Rscript --vanilla
############################################
### File:	point_smooth.R
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

# points
qplot(carat, price, data = dsmall)
# ggsave(file = "../figures/caratprice_dsmall.png")

# smooth
qplot(carat, price, data = dsmall, geom = "smooth")
# ggsave(file = "../figures/caratsmooth_dsmall.png")

# points + smooth
qplot(carat, price, data = dsmall, geom = c("point", "smooth"))
# ggsave(file = "../figures/caratptsmoo_dsmall.png")

# without confidence interval
qplot(carat, price, data = dsmall, geom = c("point", "smooth"), se = FALSE)
# ggsave(file = "../figures/caratsmooci_dsmall.png")

# using method argument, different smoothers can be chosen: loess (default) and span (wiggliness of the line) 0-1

qplot(carat, price, data = dsmall, geom = c("point", "smooth"),
span = 0.2)
# ggsave(file = "../figures/caratsmoospan0_dsmall.png")

qplot(carat, price, data = dsmall, geom = c("point", "smooth"),
span = 1)
# ggsave(file = "../figures/caratsmoospan1_dsmall.png")

# loess does not work well for large datasets, then use mgcv. Use method = "gam", formula= y ∼ s(x) to fit a generalised additive model.
# using a generalised addi-tive model as a smoother

library(mgcv)
qplot(carat, price, data = dsmall, geom = c("point", "smooth"),method = "gam", formula = y ~ s(x))
# ggsave(file = "../figures/caratsmoogam_dsmall.png")

qplot(carat, price, data = dsmall, geom = c("point", "smooth"),
method = "gam", formula = y ~ s(x, bs = "cs"))
# ggsave(file = "../figures/caratsmoogam2_dsmall.png")

# method = "lm" fits a linear model. The default will fit a straight line 
# load the splines package and use a natural spline: formula = y ~ ns(x, 2). The second parameter is the degrees of freedom: a higher number will create a wigglier curve. You are free to specify any formula involving x and y.

library(splines)
qplot(carat, price, data = dsmall, geom = c("point", "smooth"),
method = "lm")
# ggsave(file = "../figures/caratsmoolm1_dsmall.png")

qplot(carat, price, data = dsmall, geom = c("point", "smooth"),
method = "lm", formula = y ~ ns(x,5))
# ggsave(file = "../figures/caratsmoolm2_dsmall.png")


# rlm uses a robust fitting algorithm so that outliers don’t affect the fit as much.

library(MASS)
qplot(carat, price, data = dsmall, geom = c("point", "smooth"),
method = "rlm")
ggsave(file = "../figures/caratsmoorlm_dsmall.png")


dev.off()
q(status=1)

#! /usr/bin/Rscript --vanilla
############################################
### File:	hist_density.R
### Author:	Blanca A. Vargas-Govea
### Email:	blanca.vg@gmail.com
### Date:	28-Oct-2010
### Data:	diamonds.tab,diamondstoy.tab
############################################
library(ggplot2)
library(proto)

# http://stattrek.com/AP-Statistics-1/Histogram.aspx
# Histogram and density plots show the distribution of a single variable.
# They provide more information about the distribution of a single group than
# boxplots do, but it is harder to compare many groups 

data(diamonds)
# Using a reduced sample
set.seed(1410) # Make the sample reproducible
dsmall <- diamonds[sample(nrow(diamonds), 100), ]

# histogram
qplot(carat, data = diamonds, geom = "histogram")
ggsave(file = "../figures/histogram.png")

# density
qplot(carat, data = diamonds, geom = "density")
ggsave(file = "../figures/density.png")

# binwidth argument controls the amount of smoothing by setting the bin size
qplot(carat, data = diamonds, geom = "histogram", binwidth = 1,
xlim = c(0,3))
ggsave(file = "../figures/binwidth1d0.png")

# without xlim
qplot(carat, data = diamonds, geom = "histogram", binwidth = 1)
ggsave(file = "../figures/binwidth1_sx.png")

qplot(carat, data = diamonds, geom = "histogram", binwidth = 0.1,
xlim = c(0,3))
ggsave(file = "../figures/binwidthd1.png")

qplot(carat, data = diamonds, geom = "histogram", binwidth = 0.01,
xlim = c(0,3))
ggsave(file = "../figures/binwidthd01.png")

# To compare the distributions of different subgroups, just add an aesthetic mapping.
# Mapping a categorical variable to an aesthetic will automatically split up the 
# geom by that variable, so these commands instruct qplot() to draw a density plot
# and histogram for each level of diamond colour.

qplot(carat, data = diamonds, geom = "density", colour = color)
ggsave(file = "../figures/densitycolour.png")

qplot(carat, data = diamonds, geom = "histogram", fill = color)
ggsave(file = "../figures/histfill.png")

# Bar charts
# The bar geom counts the number of instances of each class so that you don’t need to tabulate your values beforehand, as with barchart in base R. If the data has already been tabulated or if you’d like to tabulate class members in some other way, such as by summing up a continuous variable, you can use the weight geom. 

# simple bar chart of diamond colour
qplot(color, data = diamonds, geom = "bar")
ggsave(file = "../figures/barchart.png")

# bar chart of diamond colour weighted by carat
qplot(color, data = diamonds, geom = "bar", weight = carat) +
scale_y_continuous("carat")
ggsave(file = "../figures/barchartweight.png")



dev.off()
q(status=1)

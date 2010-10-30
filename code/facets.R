#! /usr/bin/Rscript --vanilla
############################################
### File:	timeseries.R
### Author:	Blanca A. Vargas-Govea
### Email:	blanca.vg@gmail.com
### Date:	29-Oct-2010
### Data:	economics
### From the book
### Hadley Wickham
### ggplot2
### Elegant Graphics for Data Analysis
############################################
library(ggplot2)
library(proto)

# Using aesthetics (colour and shape) to compare subgroups, drawing all groups on the same plot. Faceting takes an alternative approach: It creates tables of graphics by splitting the data into subsets and displaying the same graph for each subset in an arrangement that facilitates comparison. 


data(diamonds)

# Using a reduced sample
set.seed(1410) # Make the sample reproducible
dsmall <- diamonds[sample(nrow(diamonds), 100), ]

qplot(carat, data = diamonds, facets = color ~ .,
geom = "histogram", binwidth = 0.1, xlim = c(0, 3))
ggsave(file = "../figures/facet1.png")

qplot(carat, ..density.., data = diamonds, facets = color ~ .,
geom = "histogram", binwidth = 0.1, xlim = c(0, 3))
# ggsave(file = "../figures/facet2.png")

# Options
qplot( carat, price, data = dsmall,xlab = "Price ($)", ylab = "Weight (carats)",main = "Price-weight relationship")
ggsave(file = "../figures/priceweight.png")

qplot( carat, price/carat, data = dsmall, ylab = expression(frac(price,carat)), xlab = "Weight (carats)", main="Small diamonds", xlim = c(.2,1) )
ggsave(file = "../figures/priceweightsmall.png")

qplot(carat, price, data = dsmall, log = "xy")
ggsave(file = "../figures/caratpricelog.png")


dev.off()
q(status=1)

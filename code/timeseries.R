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

# Line plots usually have time on the x-axis, showing how a single variable has changed over time. Path plots show how two variables have simultaneously changed over time, with time encoded in the way that the points are joined together.


data(economics)

# Percent of population that is unemployed
qplot(date, unemploy / pop, data = economics, geom = "line")
ggsave(file = "../figures/econline.png")

# Median number of weeks unemployed
qplot(date, uempmed, data = economics, geom = "line")
ggsave(file = "../figures/econline2.png")

# To examine this relationship in greater detail, we would like to draw both time series on the same plot. We could draw a scatterplot of unemployment rate vs. length of unemployment, but then we could no longer see the evolution over time. The solution is to join points adjacent in time with line segments.

year <- function(x) as.POSIXlt(x)$year + 1900
qplot(unemploy / pop, uempmed, data = economics,
geom = c("point", "path"))
ggsave(file = "../figures/econpath.png")

qplot(unemploy / pop, uempmed, data = economics,
geom = "path", colour = year(date)) + scale_area()
ggsave(file = "../figures/econpathcolour.png")

dev.off()
q(status=1)

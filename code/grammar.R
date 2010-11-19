# comic <- read.csv(file="../data/test.data",header=TRUE,sep=',')
# qplot(city,data=comic,geom="bar",fill=factor(user))

library(ggplot2)
library(proto)

books <- read.csv(file = "../data/clean2_BX-Users.csv", header = TRUE, sep = ",")
set.seed(1410) # Make the sample reproducible
dsmall <- books[sample(nrow(books), 100), ]

qplot(displ, hwy, data=mpg, facets = . ~ year) + geom_smooth()
p <- qplot(displ, hwy, data = mpg, colour = factor(cyl))
summary(p)

# Save plot object to disk
save(p, file = "plot.rdata")
# Load from disk
load("plot.rdata")
# Save png to disk
ggsave("plot.png", width = 5, height = 5)

p <- ggplot(diamonds, aes(carat, price, colour = cut)) # it needs a layer
p <- p + layer(geom = "point")
#layer(geom, geom_params, stat, stat_params, data, mapping, position)

# It produces a histogram (a combination of bars and binning) coloured “steelblue” with a bin width of 2:

p <- p + layer(
geom = "bar",
geom_params = list(fill = "steelblue"),
stat = "bin",
stat_params = list(binwidth = 2) # simplifying:

#geom_histogram(binwidth = 2, fill = "steelblue")

#geom_XXX(mapping, data, ..., geom, position)
#stat_XXX(mapping, data, ..., stat, position)

ggplot(msleep, aes(sleep_rem / sleep_total, awake)) +
geom_point()
# which is equivalent to
qplot(sleep_rem / sleep_total, awake, data = msleep)

# You can add layers to qplot too:
qplot(sleep_rem / sleep_total, awake, data = msleep) +
geom_smooth()
# This is equivalent to
qplot(sleep_rem / sleep_total, awake, data = msleep,
geom = c("point", "smooth"))
# or

ggplot(msleep, aes(sleep_rem / sleep_total, awake)) + geom_point() + geom_smooth()

p <- ggplot(msleep, aes(sleep_rem / sleep_total, awake))
summary(p)

p <- p + geom_point()
summary(p)

# Reusing a layer
bestfit <- geom_smooth(method = "lm", se = F, colour = alpha("steelblue", 0.5), size = 2)
qplot(sleep_rem, sleep_total, data = msleep) + bestfit
qplot(awake, brainwt, data = msleep, log = "y") + bestfit
qplot(bodywt, brainwt, data = msleep, log = "xy") + bestfit

# data
p <- ggplot(mtcars, aes(mpg, wt, colour = cyl)) + geom_point()
mtcars <- transform(mtcars, mpg = mpg ^ 2)

# aesthetic mappings
aes(x = weight, y = height, colour = age)
aes(weight, height, colour = sqrt(age))

# plots and layers
p <- ggplot(mtcars) # initializing plot with default values
p <- p + aes(wt, hp)

p <- ggplot(mtcars, aes(x = mpg, y = wt))
p + geom_point() # displays plot

p + geom_point(aes(colour = factor(cyl)))
p + geom_point(aes(y = disp))

# Setting vs mapping. Instead of mapping an aesthetic property to a variable, you can set it to a single value 
#For example, the following layer sets the colour of the points, using the colour parameter of the layer:

p <- ggplot(mtcars, aes(mpg, wt))
p + geom_point(colour = "darkblue") # This sets the point colour to be dark blue instead of black

p + geom_point(aes(colour = "darkblue"))# This maps (not sets) the colour to the value “darkblue”.

# pag. 49 Grouping. Collective geoms represent multiple observations
# A stat transforms the data typically by summarising it in some manner. 
ggplot(diamonds, aes(carat)) + geom_histogram(aes(y = ..density..), binwidth = 0.1)
# qplot syntax:
qplot(carat, ..density.., data = diamonds, geom="histogram",
binwidth = 0.1)

#Position adjustments: apply minor tweaks to the position of elements within a layer

# Pulling it all together: same stat underlying ahistogram, different geoms: area, point and tile

d <- ggplot(diamonds, aes(carat)) + xlim(0, 3)
d + stat_bin(aes(ymax = ..count..), binwidth = 0.1, geom = "area")
d + stat_bin(aes(size = ..density..), binwidth = 0.1,geom = "point", position="identity")
d + stat_bin(aes(y = 1, fill = ..count..), binwidth = 0.1, geom = "tile", position="identity")

# Displaying precomputed statistics. If you have data which has already been summarised, and you just want to use it, you’ll need to use stat_identity(), which leaves the data unchanged.

# Toolbox, structuring 
df <- data.frame(
x = c(3, 1, 5),
y = c(2, 4, 6),
label = c("a","b","c")
)

p <- ggplot(df, aes(x, y, label = label)) +
xlab(NULL) + ylab(NULL)
p + geom_point() + opts(title = "geom_point")
p + geom_bar(stat="identity") + opts(title = "geom_bar(stat=\"identity\")")
p + geom_line() + opts(title = "geom_line")
p + geom_area() + opts(title = "geom_area")
p + geom_path() + opts(title = "geom_path")
p + geom_text() + opts(title = "geom_text")
p + geom_tile() + opts(title = "geom_tile")
p + geom_polygon() + opts(title = "geom_polygon")

# Displaying distributions
# display the distribution of diamond depth
depth_dist <- ggplot(diamonds, aes(depth)) + xlim(58, 68)
depth_dist + geom_histogram(aes(y = ..density..), binwidth = 0.1) + facet_grid(cut ~ .)
depth_dist + geom_histogram(aes(fill = cut), binwidth = 0.1, position = "fill")
depth_dist + geom_freqpoly(aes(y = ..density.., colour = cut), binwidth = 0.1)

qplot(cut, depth, data=diamonds, geom="boxplot")
qplot(carat, depth, data=diamonds, geom="boxplot", group = round_any(carat, 0.1, floor), xlim = c(0, 3))

qplot(class, cty, data=mpg, geom="jitter")
qplot(class, drv, data=mpg, geom="jitter")
qplot(depth, data=diamonds, geom="density", xlim = c(54, 70))
qplot(depth, data=diamonds, geom="density", xlim = c(54, 70),fill = cut, alpha = I(0.2))

# overplotting, two continuous variables
df <- data.frame(x = rnorm(2000), y = rnorm(2000))
norm <- ggplot(df, aes(x, y))
norm + geom_point()
norm + geom_point(shape = 1)
norm + geom_point(shape = ".") # Pixel sized

# larger datasets alpha blending
norm + geom_point(colour = alpha("black", 1/3))
norm + geom_point(colour = alpha("black", 1/5))
norm + geom_point(colour = alpha("black", 1/10))

# Revealing uncertainty
#Statistical summaries stat_summary(), which provides a flexible way of summarising the conditional distribution of y values for each unique x value

# Summaries are much more useful with a bigger data set:
m <- ggplot(movies, aes(x=round(rating), y=votes)) + geom_point()
m2 <- m + stat_summary(fun.data = "mean_cl_boot", geom = "crossbar", colour = "red", width = 0.3)

install.packages('Hmisc',dep = TRUE)
# Basic operation on a small dataset
c <- qplot(cyl, mpg, data=mtcars)
c + stat_summary(fun.data = "mean_cl_boot", colour = "red")
# Individual summary functions: The arguments fun.y, fun.ymin and fun.ymax accept simple numeric summary functions. You can use any summary function that takes a vector of numbers and returns a single numeric value: mean(), median(), min(), max().

midm <- function(x) mean(x, trim = 0.5)
m2 + stat_summary(aes(colour = "trimmed"), fun.y = midm, geom = "point") + stat_summary(aes(colour = "raw"), fun.y = mean, geom = "point") + scale_colour_hue("Mean")

# Single summary function

iqr <- function(x, ...) {
qs <- quantile(as.numeric(x), c(0.25, 0.75), na.rm = T)
names(qs) <- c("ymin", "ymax")
qs
 }

m + stat_summary(fun.data = "iqr", geom="ribbon")

# Annotating plots
(unemp <- qplot(date, unemploy, data=economics, geom="line", xlab = "", ylab = "No. unemployed (1000s)"))

unemp <- qplot(date, unemploy, data=economics, geom="line", xlab = "", ylab = "No. unemployed (1000s)")

highest <- subset(economics, unemploy == max(unemploy))
unemp + geom_point(data = highest, size = 3, colour = alpha("red", 0.5))
# When you have aggregated data where each row in the dataset represents multiple observations, you need some way to take into account the weighting variable. 

# Polishing plots
hgram <- qplot(rating, data = movies, binwidth = 1)
hgram
previous_theme <- theme_set(theme_bw())
hgram

# Multiple plots
(a <- qplot(date, unemploy, data = economics, geom = "line"))
(b <- qplot(uempmed, unemploy, data = economics) +
geom_smooth(se = F))
(c <- qplot(uempmed, unemploy, data = economics, geom="path"))






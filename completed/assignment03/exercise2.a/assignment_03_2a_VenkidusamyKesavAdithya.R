# Assignment: ASSIGNMENT 3
# Name: Venkidusamy, Kesav Adithya
# Date: 2021-09-15

## Load the ggplot2 package
library(ggplot2)
theme_set(theme_minimal())

## Set the working directory to the root of your DSC 520 directory
setwd("E:/Personal/Bellevue University/Course/github/dsc520")

## Load the `data/r4ds/heights.csv` to
amer_survey <- read.csv("data/acs-14-1yr-s0201.csv")

##What are the elements in your data (including the categories and data types)?
typeof(amer_survey)
attributes(amer_survey)

##Please provide the output from the following functions: str(); nrow(); ncol()
str(amer_survey)
nrow(amer_survey)
ncol(amer_survey)

##Create a Histogram of the HSDegree variable using the ggplot2 package.
##Set a bin size for the Histogram.
##Include a Title and appropriate X/Y axis labels on your Histogram Plot.
ggplot(amer_survey, aes(HSDegree)) + geom_histogram(bins=10)
ggplot(amer_survey, aes(HSDegree)) + geom_histogram(bins=10) + ggtitle("Measure of HS Degrees") + xlab("HS Degree") + ylab("Number of Degrees")


##Include a normal curve to the Histogram that you plotted.
ggplot(amer_survey, aes(HSDegree)) + geom_histogram(bins=10, aes(y = ..density..)) + ggtitle("Measure of HS Degrees") + xlab("HS Degree") + ylab("Number of Degrees") + stat_function(fun = dnorm, args = list(mean = mean(amer_survey$HSDegree), sd = sd(amer_survey$HSDegree)), col = "#1b98e0", size = 2)


##Create a Probability Plot of the HSDegree variable.
ggplot(amer_survey, aes(sample=HSDegree)) + stat_qq(col="blue") + stat_qq_line(col="red", lty=2)


##Now that you have looked at this data visually for normality, you will now quantify normality with numbers using the stat.desc() function. Include a screen capture of the results produced.
library(pastecs)
stat.desc(amer_survey$HSDegree, basic = FALSE, norm = TRUE) 

##Test Scores

## Set the working directory to the root of your DSC 520 directory
setwd("E:/Personal/Bellevue University/Course/github/dsc520")

## Load the `data/scores.csv` to df
scores_df <- read.csv("data/scores.csv")

##Use the appropriate R functions to answer the following questions
## Importing library "dplyr"
library(dplyr)

##Create one variable to hold a subset of your data set that contains only the Regular Section and one variable for the Sports Section
regular_scores_df <- filter(scores_df, Section == 'Regular')
sports_scores_df <- filter(scores_df, Section == 'Sports')

##Use the Plot function to plot each Sections scores and the number of students achieving that score. Use additional Plot Arguments to label the graph and give each axis an appropriate label.
plot(regular_scores_df$Count, regular_scores_df$Score,xlab = "count of students" ,ylab = "scores", main = "Regular Section Scores")
plot(sports_scores_df$Count,sports_scores_df$Score, xlab = "count of students" ,ylab = "scores", main = "Sports Section Scores")

##Using ggplots
library(ggplot2)
ggplot(regular_scores_df,aes(x = Count, y = Score, shape = 'color')) + geom_point() + ggtitle("Regular section scores") + xlab("Count of Students") + ylab("Scores")
ggplot(sports_scores_df,aes(x = Count, y = Score, shape = 'color')) + geom_point() + ggtitle("Sports section scores") + xlab("Count of Students") + ylab("Scores")

##Histogram
ggplot(regular_scores_df,aes(Score)) + geom_histogram(bins=10, aes(y = ..density..)) + ggtitle("Regular section scores") + xlab("Scores") + ylab("Density") + stat_function(fun = dnorm, args = list(mean = mean(regular_scores_df$Score), sd = sd(regular_scores_df$Score)), col = "#1b98e0", size = 2)
ggplot(sports_scores_df,aes(Score)) + geom_histogram(bins=10, aes(y = ..density..)) + ggtitle("Sports section scores") + xlab("Scores") + ylab("Density") + stat_function(fun = dnorm, args = list(mean = mean(sports_scores_df$Score), sd = sd(sports_scores_df$Score)), col = "#1b98e0", size = 2)

##Sharpiro.test
shapiro.test(regular_scores_df$Score)
shapiro.test(sports_scores_df$Score)

##stat.desc
library(pastecs)
stat.desc(regular_scores_df$Score)
stat.desc(sports_scores_df$Score)

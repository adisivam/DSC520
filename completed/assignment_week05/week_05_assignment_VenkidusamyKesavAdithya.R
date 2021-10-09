#Housing dataset
library("readxl")

# Set the working directory to the root of your DSC 520 directory
setwd("E:/Personal/Bellevue University/Course/github/dsc520")

#Load the `data/scores.csv` to df
housing_df <- read_excel("data/week-7-housing.xlsx")
attributes(housing_df)
str(housing_df)
colnames(housing_df)

library("dplyr")

#Number of rows and columns using dim function 
housing_df %>% head(4) %>% dim

##Count of records
nrow(housing_df)
ncol(housing_df)

## Select zip, bedrooms and sales price from dataset
housing_df %>% select(zip5, bedrooms, "Sale Price")

## Filter the dataset only for bedrooms 3,4,5
housing_df %>% select(zip5, bedrooms, "Sale Price") %>% filter(bedrooms > 2 & bedrooms < 6)
housing_df %>% select(zip5, bedrooms, "Sale Price") %>% filter(bedrooms %in% c(3,4,5))
housing_df %>% select(zip5, bedrooms, "Sale Price") %>% filter(bedrooms == 3 | bedrooms == 4 | bedrooms == 5)

## Apply Slice to get sample rows
housing_df %>% select(zip5, bedrooms, "Sale Price") %>% filter(bedrooms > 2 & bedrooms < 6) %>% slice(1:5)

## Calculate price per sq feet using mutate function
housing_df %>% select(zip5, bedrooms, square_feet_total_living, "Sale Price")
housing_df %>% mutate(price_per_sq_ft = as.double(round(`Sale Price`/square_feet_total_living,2))) %>% select(zip5, bedrooms, square_feet_total_living, "Sale Price", price_per_sq_ft)

##Calculate the age of house
housing_df %>% mutate(no_of_year = as.integer(format(Sys.Date(), "%Y")) - year_built) %>% select(no_of_year)

#Mean, max and min price of house by zip code and bedrooms for 3,4 and 5 bedrooms
housing_df %>% filter(bedrooms %in% c(3,4,5)) %>% group_by(zip5, bedrooms) %>% summarize(AvgPrice=mean(`Sale Price`), MaxPrice = max(`Sale Price`), MinPrice = min(`Sale Price`))

##Arrange the above result by bedrooms and AvgPrice
housing_df %>% filter(bedrooms %in% c(3,4,5)) %>% group_by(zip5, bedrooms) %>% summarize(AvgPrice=mean(`Sale Price`), MaxPrice = max(`Sale Price`), MinPrice = min(`Sale Price`)) %>% arrange(bedrooms, zip5, desc(AvgPrice))

#Purr package and functions
library(purrr)

#Calculate mean price
housing_df %>% select(`Sale Price`) %>% map_dbl(mean)
housing_df %>% map(class)
map(housing_df, mean)

#Houses over 1 million using keep function
high_cost <- housing_df$`Sale Price` |> keep(~ (.x) > 1000000)
high_cost[1:10]
length(high_cost)

#Low cost houses under 350k using discard function
low_cost <- housing_df$`Sale Price` |> discard(~ (.x) > 350000)
low_cost[1:10]
length(low_cost)


#String operations
library(plyr)
require(stringr)

#Get month and year from Sale date
class(housing_df$`Sale Date`)
year <- housing_df$`Sale Date` %>% str_sub(start=1, end=4)
year[1:10]
length(year)
month <-  housing_df$`Sale Date` %>% str_sub(start=6, end=7)
month[1:10]
length(month)

housing_df$sales_month <- paste(month, year, sep='-')
head(housing_df$sales_month)
length(housing_df$sales_month)

#House filters based on number of bedrooms
house_cols <- housing_df %>% select(`Sale Date`,`Sale Price`, zip5, ctyname, postalctyn, square_feet_total_living, bedrooms, sq_ft_lot)
nrow(house_cols) 
house_0 <- house_cols %>% filter(bedrooms == 0)
house_1 <- house_cols %>% filter(bedrooms == 1)
house_2 <- house_cols %>% filter(bedrooms == 2)
house_3 <- house_cols %>% filter(bedrooms == 3)
house_big <- house_cols %>% filter(bedrooms > 3)


#Combine all the data frames back to  single data frame using rbind
house_combine <- rbind(house_0, house_1, house_2, house_3, house_big)
nrow(house_combine)

#Combine all the columns back to single data frame using cbind
house_cols <- housing_df %>% select(`Sale Date`,`Sale Price`, zip5, ctyname, postalctyn, square_feet_total_living, bedrooms, sq_ft_lot)
house_cols_exclude <- housing_df %>% select(-c(`Sale Date`,`Sale Price`, zip5, ctyname, postalctyn, square_feet_total_living, bedrooms, sq_ft_lot))
colnames(house_cols)
colnames(house_cols_exclude)

house_all_cols <- cbind(house_cols_exclude, house_cols)
colnames(house_all_cols)

#Validating the number of columns
ncol(house_cols_exclude)
ncol(house_cols)
ncol(house_all_cols)

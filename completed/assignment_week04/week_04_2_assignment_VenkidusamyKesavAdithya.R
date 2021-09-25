##Housing dataset

library("readxl")

## Set the working directory to the root of your DSC 520 directory
setwd("E:/Personal/Bellevue University/Course/github/dsc520")

## Load the `data/scores.csv` to df
housing_data <- read_excel("data/week-7-housing.xlsx")
attributes(housing_data)
str(housing_data)

##Use the apply function on a variable in your dataset
sales_price <- housing_data["Sale Price"]
mean_sales <- apply(sales_price,2, mean)
print(mean_sales)

##Use the aggregate function on a variable in your dataset
##Mean of Sale Price by bedrooms
aggregate(`Sale Price` ~ bedrooms, housing_data, mean)

##Use the plyr function on a variable in your dataset - more specifically, I want to see you split some data, perform a modification to the data, and then bring it back together
library(dplyr)

housing_subset_df <- select(housing_data, square_feet_total_living, `Sale Price`)
head(housing_subset_df)

housing_subset_df <- rename(housing_subset_df, replace = c("Sale Price" = "sales_price"))
head(housing_subset_df)

housing_subset_df <- mutate(housing_subset_df, price_per_sq_ft = as.double(round(sales_price/square_feet_total_living,2)))
head(housing_subset_df)

price_per_sq_feet <- select(housing_subset_df,price_per_sq_ft)
head(price_per_sq_feet)

housing_df_new <- bind_cols(housing_data, price_per_sq_feet)
head(housing_df_new)

##Check distributions of the data
ggplot(housing_df_new, aes(`price_per_sq_ft`)) + geom_histogram(bins=25) + xlim(0, 1500)


##Identify if there are any outliers
##Limiting the price_per_sq_ft to less than $1500

housing_df_new <- filter(housing_df_new, price_per_sq_feet <= 500)
head(housing_df_new)

ggplot(housing_df_new, aes(`price_per_sq_ft`)) + geom_histogram(bins=25) + xlim(0, 500)


##Create at least 2 new variables

housing_data_new <- mutate(housing_data, price_per_sq_ft=sales_price/square_feet_total_living, house_price = case_when((price_per_sq_ft <= 100) ~ 'Low',(price_per_sq_ft > 100 & price_per_sq_ft <= 250) ~ 'Medium',(price_per_sq_ft > 250) ~ 'High'))
attributes(housing_data_new)
housing_data_new %>% select(price_per_sq_ft, house_price)

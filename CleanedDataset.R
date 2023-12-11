#library
library(dplyr)
library(stringr)
library(tidyverse)


#Reads in datasets 
emission_df <- read.csv("co2.csv") 
pop_df <- read.csv("population.csv")

#Joins in dataframes
df <- merge(emission_df, pop_df, by = "Year", all = TRUE)
df <- (filter(df, Year >= 1995))
df <- select(df, !ISO.3166.1.alpha.3)
df <- select(df, !X)

#Create Global Average Dataframe (Main one used and summarization dataframe) 
global_avg_data <- summarise(group_by(df, Year), 
                             avg_co2 = mean(Total, na.rm = TRUE), 
                             global_pop = mean(Population, na.rm = TRUE), 
                             per_capita = mean(Per.Capita, na.rm = TRUE), 
                             avg_oil_co2 = mean(Oil, na.rm = TRUE),
                             avg_coal_co2 = mean(Coal, na.rm = TRUE), 
                             avg_gas_co2 = mean(Gas, na.rm = TRUE), 
                             avg_cement_co2 = mean(Cement, na.rm = TRUE),
                             avg_flaring_co2 = mean(Flaring, na.rm = TRUE),
                             avg_other = mean(Other, na.rm = TRUE))


#Create one new categorical variable (For DF)
df$co2_levels <- as.factor(ifelse(df$Total < 100, "Low emission rate" ,
                                  ifelse(df$Total < 1000, "Medium emission rate",
                                         ifelse(df$Total < 5000, "High emission rate", "Extreme emission rate"))))

#Create one new numerical variable that shows the lowest co2 (For DF)
order_co2 <- order(df$Total)
lowest_co2 <- df[(order_co2), ]
df$low_co2 <- lowest_co2$Total

#Oil dataframe
oil_data <- summarise(group_by(df, Year), 
                      avg_oil_co2 = mean(Oil, na.rm = TRUE),
                      avg_co2 = mean(Total, na.rm = TRUE))
#Dataframe for only 2021
dataYear <- filter(df, Year == "2021")
arrangeData <- dataYear %>%
  select(Country, Total) %>%
  filter(Country != "Global" & Country != "International Transport") %>%
  arrange(-Total) %>%
  head(10) 

#Create a new csv file for the global_avg_data df
write.csv(global_avg_data, "unified_avg_data.csv", row.names = FALSE)
write.csv(arrangeData, "arrangeData_2021.csv", row.names = FALSE)
write.csv(oil_data, "oil_data.csv", row.names = FALSE)
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
                             avg_oil = mean(Oil, na.rm = TRUE),
                             avg_coal = mean(Coal, na.rm = TRUE), 
                             avg_gas = mean(Gas, na.rm = TRUE), 
                             avg_cement = mean(Cement, na.rm = TRUE),
                             avg_flaring = mean(Flaring, na.rm = TRUE),
                             avg_other = mean(Other, na.rm = TRUE))


#Create one new categorical variable (For DF)
df$co2_levels <- as.factor(ifelse(df$Total < 100, "Low emission rate" ,
                                  ifelse(df$Total < 1000, "Medium emission rate",
                                         ifelse(df$Total < 5000, "High emission rate", "Extreme emission rate"))))

#Create one new numerical variable that shows the lowest co2 (For DF)
order_co2 <- order(df$Total)
lowest_co2 <- df[(order_co2), ]
df$low_co2 <- lowest_co2$Total


#Here are examples of scatterplots and line charts made by ggplot
#Scatter plot of a linear trend line showing Year and Avg_CO2
ggplot(global_avg_data, aes(x = Year, y = avg_co2)) +
  geom_point() +
  geom_smooth(method = lm, se = FALSE)

#Scatter plot of a linear trend line showing Year and Global Population
ggplot(global_avg_data, aes(x = Year, y = global_pop)) +
  geom_point() +
  geom_smooth(method = lm, se = FALSE)

#Scatter plot of a linear trend line showing Global Population and Avg CO2
ggplot(global_avg_data, aes(x = global_pop, y = avg_co2)) +
  geom_point() +
  geom_smooth(method = lm, se = FALSE)

#Scatter plot and line chart showing year and per_capita
ggplot(global_avg_data, aes(x = Year, y = per_capita)) +
  geom_line() +
  geom_point()

#Scatter plot and line chart showing per_capita and avg_co2
ggplot(global_avg_data, aes(x = per_capita, y = avg_co2)) +
  geom_line() +
  geom_point()

#Scatter plot of avg_oil and avg_co2
ggplot(global_avg_data, aes(x = avg_oil, y = avg_co2)) +
  geom_point()


#From every country to present, the low emission is the highest
ggplot(df, aes(co2_levels)) +
  geom_bar()

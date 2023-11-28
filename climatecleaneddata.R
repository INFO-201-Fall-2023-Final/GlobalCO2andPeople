#library
library(dplyr)
library(stringr)

#Reads in datasets 
temp_df <- read.csv("globaltemp.csv") 
emission_df <- read.csv("emissions.csv") 

#Joins in dataframes
temp_df$Year <- gsub("F", "", as.character(temp_df$Year))
year_fix <- as.numeric(df$Year.x)
df <- merge(emission_df, temp_df, by = "Country", all = TRUE)

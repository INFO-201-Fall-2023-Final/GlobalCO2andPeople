#library
library(dplyr)
library(stringr)

#Reads in datasets 
#temp_df <- read.csv("globaltemp.csv") 
emission_df <- read.csv("emissions.csv") 
risk_df <- read.csv("worldrisk.csv")

#Joins in dataframes
#temp_df$Year <- gsub("F", "", as.character(temp_df$Year))
#year_fix <- as.numeric(df$Year.x)
df <- merge(emission_df, risk_df, by = "Year", all = TRUE)

str(emission_df)
str(risk_df)
#str(temp_df)
#str(df)

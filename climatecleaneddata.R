#library
library(dplyr)
library(stringr)

#Reads in datasets 
emission_df <- read.csv("emissions.csv") 
risk_df <- read.csv("worldrisk.csv")

#Joins in dataframes
df <- merge(emission_df, risk_df, by = "Year", all = TRUE)
df <- na.omit(df) 
print(na.omit(df))


#Create one new categorical variable
df$CO2EmissionRate..mt. <- as.numeric(df$CO2EmissionRate..mt.)
df$co2_levels <- as.factor(ifelse(df$CO2EmissionRate..mt. < 1, "Low emission rate" ,
                 ifelse(df$CO2EmissionRate..mt. < 10, "Medium emission rate",
                 ifelse(df$CO2EmissionRate..mt. < 30, "High emission rate", "Extreme emission rate"))))

#Create one new numerical variable

#Create one summarization dataframe

#Check types in datasets
#str(emission_df)
#str(risk_df)
#str(df)

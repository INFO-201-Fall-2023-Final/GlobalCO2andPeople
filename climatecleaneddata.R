#library
library(dplyr)
library(stringr)

#Reads in datasets 
emission_df <- read.csv("emissions.csv") 
risk_df <- read.csv("worldrisk.csv")

#Joins in dataframes
#df[df$Year != 1990, 1991 ,1992 ,1993,1994,1995,1996,1997,1998,1999,2000,2001,2002,2003,2004,2005,2006,2007,2008,2009,2010, ]
df <- merge(emission_df, risk_df, by = "Year", all = TRUE)
df <- na.omit(df) 
print(na.omit(df))


#Create one new categorical variable


#Create one new numerical variable

#Create one summarization dataframe

#Check types in datasets
#str(emission_df)
#str(risk_df)
#str(df)

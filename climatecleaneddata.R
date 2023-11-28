#library
library(dplyr)
library(stringr)

#Reads in datasets 
temp_df <- read.csv("globaltemp.csv") 
emission_df <- read.csv("emissions.csv") 
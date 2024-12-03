#### Preamble ####
# Purpose: Clean the raw Neighbourhood Profiles data
# Author: Julia Lee
# Date: 28 November 2024
# Contact: jlee.lee@mail.utoronto.ca
# License: MIT
# Pre-requisites: Download and save the actual Neighbourhood Profiles data 
# from Open Data Toronto
# Any other information needed? N/A

#### Setting Up the Workspace ####

library(tidyverse)
library(dplyr)
library(arrow)

#### Cleaning the Data ####

raw_profiles_data <- read_csv("data/01-raw_data/raw_data.csv")
#view(raw_profiles_data)

# Selecting the rows that contain data for the total number of census families, 
# the number of 2-person, 3-person, 4-person, and 5-person families, the 
# average size of census families, the average number of children in census 
# families, and the average after-tax income of census families for each 
# neighbourhood in Toronto

# This step is done in several parts to ensure that the right rows are being
# selected 

row_selection_1 = raw_profiles_data[-c(2:384),]
#view(row_selection_1)

row_selection_2 = row_selection_1[-c(8:10),]
#view(row_selection_2)

row_selection_3 = row_selection_2[-c(8:15),]
#view(row_selection_3)

row_selection_4 = row_selection_3[-c(9:12),]
#view(row_selection_4)

row_selection_5 = row_selection_4[-c(10:2205),]
#view(row_selection_5)


# At this point, should have 9 rows: (1) neighbourhood number, (2) total 
# number of census families, (3) 2 person families, (4) 3 person families,
# (5) 4 person families, (6) 5 or more person families, (7) average census
# family size, (8) average number of children in census families, (9) average
# after-tax income (2020)

# Remove the first column 

new_data <- row_selection_5[-c(1)]
#view(new_data)

# Make sure that the data is a dataframe

final_data = as.data.frame(t(new_data))
#view(final_data)

# Make the first row into the header and the row names into a new column
## Hints for the code for this step was provided by:
## https://stackoverflow.com/questions/29511215/how-can-i-convert-row-names-
## into-the-first-column
## https://stackoverflow.com/questions/23209330/how-to-change-the-first-row-
## to-be-the-header-in-r 

## First row into the header 

names(final_data) <- final_data[1,]
final_data <- final_data[-1,]
#view(final_data)

## Row names into a new column

neighbourhood_names <- rownames(final_data)
rownames(final_data) <- NULL
finalized_clean_data <- cbind(neighbourhood_names,final_data)
#view(finalized_clean_data)

# Rename first column

names(finalized_clean_data)[names(finalized_clean_data) == 
                              "neighbourhood_names"] <- "Neighbourhood Name"
view(finalized_clean_data)


#### Saving the Data ####

# Save the cleaned data as a parquet file in data/02-analysis_data
# The parquet file will be called "analysis_data.parquet"

write_parquet(finalized_clean_data, 
              "data/02-analysis_data/analysis_data.parquet")

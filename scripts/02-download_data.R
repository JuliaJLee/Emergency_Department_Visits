#### Preamble ####
# Purpose: Download and save the actual Neighbourhood Profiles data
# from Open Data Toronto
# Author: Julia Lee
# Date: 28 November 2024
# Contact: jlee.lee@mail.utoronto.ca
# License: MIT
# Pre-requisites: None
# Any other information needed? N/A


#### Setting Up the Workspace ####

library(opendatatoronto)
library(tidyverse)
library(dplyr)

#### Downloading the Data #### 

package <- show_package("6e19a90f-971c-46b3-852c-0c48c436d1fc")

resources <- list_package_resources("6e19a90f-971c-46b3-852c-0c48c436d1fc")

datastore_resources <- filter(resources, tolower(format) %in% c('xlsx'))

raw_data <- filter(datastore_resources, row_number()==1) %>% 
  get_resource()

raw_data

# The xlsx file from Open Data Toronto has two sheets: one for the actual 
# data and another for metadata
# So, will need to save only the sheet with the actual data by creating 
# a dataframe for it

# Dataframe for Neighbourhood Profiles data

neighbourhood_profiles <- raw_data$hd2021_census_profile
#view(neighbourhood_profiles)

#### Saving the Data ####

write.csv(neighbourhood_profiles, file = "data/01-raw_data/raw_data.csv")
         
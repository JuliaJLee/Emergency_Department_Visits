#### Preamble ####
# Purpose: Simulate the Neighbourhood Profiles Data from Open Data Toronto
# Author: Julia Lee
# Date: 28 November 2024
# Contact: jlee.lee@mail.utoronto.ca
# License: MIT
# Pre-requisites: Review plan and sketches for the analysis in the "plan" folder
# Any other information needed? N/A


#### Setting Up the Workspace ####

library(tidyverse)

#### Simulating the Data ####

set.seed(059)

# Want to create a table that shows the total number of census families, 
# the number of 2-person, 3-person, 4-person, and 5-person families, the 
# average size of census families, the average number of children in census 
# families, and the average after-tax income of census families for each 
# neighbourhood in Toronto

## Define Toronto neighbourhoods - for the purposes of simulation, will 
# only include names and numbers for 20 Toronto neighbourhoods out of 158

neighbourhood_names <- c("West Humber-Clairville", 
                         "Mount Olive-Silverstone-Jamestown",
                        "Thistletown-Beaumond Heights", "Rexdale-Kipling", 
                        "Elms-Old Rexdale", "Kingsview Village-The Westway", 
                        "Willowridge-Martingrove-Richview", 
                        "Humber Heights-Westmount", "Edenbridge-Humber Valley",
                        "Princess-Rosethorn", "Eringate-Centennial-West Deane", 
                        "Markland Wood", "Etobicoke West Mall", 
                        "Kingsway South", "Stonegate-Queensway", "New Toronto",
                        "Long Branch", "Alderwood", "Humber Summit", 
                        "Humbermede")

neighbourhood_number <- c(1:20)

## Creating values for each of the 20 neighbourhoods

num_obs = 20

simulated_data <- 
  tibble(
    neighbourhood_name = neighbourhood_names,
    neighbourhood_number = neighbourhood_number,
    num_census_fam = rpois(n = num_obs, lambda = 9000), 
    two_person_fam = rpois(n = num_obs, lambda = 5000),
    three_person_fam = rpois(n = num_obs, lambda = 3000),
    four_person_fam = rpois(n = num_obs, lambda = 2000),
    five_plus_person_fam = rpois(n = num_obs, lambda = 1000),
    avg_fam_size = sample(seq(from = 2, to = 3, by = 0.1), 
                         num_obs, replace = TRUE),
    avg_num_children = sample(seq(from = 1.5, to = 2, by = 0.1), 
                              num_obs, replace = TRUE),
    avg_income = rpois(n = num_obs, lambda = 150000))

view(simulated_data)

#### Saving the Data ####

# Save the simulated data as a csv file in data/raw_data
# The csv file will be called "simulated_data.csv"

write_csv(simulated_data, file = "data/00-simulated_data/simulated_data.csv")

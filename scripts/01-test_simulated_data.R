#### Preamble ####
# Purpose: Test the simulated Neighbourhood Profiles data 
# Author: Julia Lee
# Date: 28 November 2024 
# Contact: jlee.lee@mail.utoronto.ca
# License: MIT
# Pre-requisites: Simulate the Neighbourhood Profiles data 
# Any other information needed? N/A


#### Setting Up the Workspace ####

library(tidyverse)
library(testthat)
library(dplyr)

#### Testing the Data ####

# Read in the simulated data

data <- read_csv("data/00-simulated_data/simulated_data.csv")
#view(data)

# (1) Test if the data was successfully loaded

if (exists("simulated_data")) {
  message("Test Passed: The dataset was successfully loaded.")
} else {
  stop("Test Failed: The dataset could not be loaded.")
}

# (2) Test for missing values and negative values

test_that("There are no missing values", {
  expect_true(!all(is.na(data)))})

test_that("There are no negative values", {
  expect_true(!all(data < 0))})

# (3) Test if the data has 20 rows (i.e. 20 neighbourhoods)

if (nrow(data) == 20) {
  message("Test Passed: The dataset has 20 rows.")
} else {
  stop("Test Failed: The dataset does not have 20 rows.")
}

# (4) Test if the data has 10 columns 

if (ncol(data) == 10) {
  message("Test Passed: The dataset has 10 columns.")
} else {
  stop("Test Failed: The dataset does not have 10 columns.")
}

# (5) Test if data values are in the correct data type

data$neighbourhood_name |> class() == "character"
data$neighbourhood_number |> class() == "numeric"
data$num_census_fam |> class() == "numeric"
data$two_person_fam |> class() == "numeric"
data$three_person_fam |> class() == "numeric"
data$four_person_fam |> class() == "numeric"
data$five_plus_person_fam |> class() == "numeric"
data$avg_fam_size |> class() == "numeric"
data$avg_num_children |> class() == "numeric"
data$avg_income |> class() == "numeric"

# (6) Test for unique neighbourhood names

test_that("Neighbourhood names are unique", {
  expect_true(n_distinct(data$neighbourhood_name) == nrow(data))
})

# (7) Test for unique neighbourhood numbers

test_that("Neighbourhood numbers are unique", {
  expect_true(n_distinct(data$neighbourhood_number) == nrow(data))
})

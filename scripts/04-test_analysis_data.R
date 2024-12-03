#### Preamble ####
# Purpose: Test the cleaned Neighbourhood Profiles data 
# Author: Julia Lee
# Date: 28 November 2024 
# Contact: jlee.lee@mail.utoronto.ca
# License: MIT
# Pre-requisites: Download and clean the Neighbourhood Profiles data 
# Any other information needed? N/A


#### Setting Up the Workspace ####

library(tidyverse)
library(testthat)
library(dplyr)
library(arrow)
library(here)

#### Testing the Data ####

# Read in the analysis data

testing_clean_data <- read_parquet(here::here("data/02-analysis_data/analysis_data.parquet"))
#view(testing_clean_data)

# (1) Test if the data was successfully loaded

if (exists("analysis_data")) {
  message("Test Passed: The dataset was successfully loaded.")
} else {
  stop("Test Failed: The dataset could not be loaded.")
}

# (2) Test for missing values and negative values

test_that("There are no missing values", {
  expect_true(!all(is.na(testing_clean_data)))})

test_that("There are no negative values", {
  expect_true(!all(testing_clean_data < 0))})

# (3) Test if the data has 158 rows (i.e. 158 neighbourhoods)

if (nrow(testing_clean_data) == 158) {
  message("Test Passed: The dataset has 158 rows.")
} else {
  stop("Test Failed: The dataset does not have 158 rows.")
}

# (4) Test if the data has 10 columns 

if (ncol(testing_clean_data) == 10) {
  message("Test Passed: The dataset has 10 columns.")
} else {
  stop("Test Failed: The dataset does not have 10 columns.")
}

# (5) Test if data values are in the correct data type

testing_clean_data$`Neighbourhood Name` |> class() == "character"

testing_clean_data$`Neighbourhood Number` |> class() == "character"

testing_clean_data$`Total - Census families in private households by family size - 25% sample data` |> class() == "character"

testing_clean_data$`2 persons` |> class() == "character"

testing_clean_data$`3 persons` |> class() == "character"

testing_clean_data$`4 persons` |> class() == "character"

testing_clean_data$`5 or more persons` |> class() == "character"

testing_clean_data$`Average size of census families` |> class() == "character"

testing_clean_data$`Average number of children in census families with children` |> class() == "character"

testing_clean_data$`Average after-tax income of economic family in 2020 ($)` |> class() == "character"

# (6) Test for unique neighbourhood names

test_that("Neighbourhood names are unique", {
  expect_true(n_distinct(testing_clean_data$`Neighbourhood Name`) == nrow(testing_clean_data))
})

# (7) Test for unique neighbourhood numbers

test_that("Neighbourhood numbers are unique", {
  expect_true(n_distinct(testing_clean_data$`Neighbourhood Number`) == nrow(testing_clean_data))
})

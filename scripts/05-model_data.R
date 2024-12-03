#### Preamble ####
# Purpose: Use the analysis data to set up the model 
# Author: Julia Lee
# Date: 28 November 2024 
# Contact: jlee.lee@mail.utoronto.ca
# License: MIT
# Pre-requisites: Clean the Neighbourhood Profiles data and test the cleaned
# data
# Any other information needed? N/A


#### Setting Up the Workspace ####

library(tidyverse)
library(testthat)
library(arrow)
library(here)
library(dplyr)

#### Reading in the Cleaned Analysis Data ####

model_data <- read_parquet(here::here("data/02-analysis_data/analysis_data.parquet"))
#view(model_data)

#### Fitting a Linear Regression Model ####

# Change column names

regression_data <-
  model_data |>
  rename(
    neighbourhood_name = "Neighbourhood Name",
    neighbourhood_num = "Neighbourhood Number",
    num_census_fam = "Total - Census families in private households by family size - 25% sample data",
    size_two = "2 persons",
    size_three = "3 persons",
    size_four = "4 persons",
    size_five_plus = "5 or more persons",
    avg_fam_size = "Average size of census families",
    avg_num_child = "Average number of children in census families with children",
    avg_income = "Average after-tax income of economic family in 2020 ($)"
  )

#view(regression_data)

# Turn columns into numerical vectors
# Hints for the code of this step were provided by:
# https://stackoverflow.com/questions/61260686/too-many-coefficients-with-lm

regression_data$size_two = as.numeric(as.character(regression_data$size_two))
regression_data$size_three = as.numeric(as.character(regression_data$size_three))
regression_data$size_four = as.numeric(as.character(regression_data$size_four))
regression_data$size_five_plus = as.numeric(as.character(regression_data$size_five_plus))
regression_data$avg_income = as.numeric(as.character(regression_data$avg_income))

--------------------------------------------------------------------------------------------

initial_model <- lm(avg_income ~ size_two + size_three + size_four + 
                      size_five_plus, data = regression_data)

summary(initial_model)

# Model Diagnostics

## Residuals vs Fitted values  

residuals <- initial_model$residuals
summary(residuals)

fitted <- initial_model$fitted.values
summary(fitted)

plot(residuals ~ fitted, main = "Residuals vs Fitted Values", 
     xlab = "Fitted Values", ylab = "Residuals")
abline(h = 0, col ="red")

## Normal Q-Q Plot

qqnorm(residuals)
qqline(residuals)

## Histogram 

hist(residuals)

--------------------------------------------------------------------------------------------

# Fitting a model without 5 or more person families

model_1 <- lm(avg_income ~ size_two + size_three + size_four, data = regression_data)

summary(model_1)

# Model Diagnostics

## Residuals vs Fitted values  

residuals_1 <- model_1$residuals
summary(residuals_1)

fitted_1 <- model_1$fitted.values
summary(fitted_1)

plot(residuals_1 ~ fitted_1, main = "Residuals vs Fitted Values", 
     xlab = "Fitted Values", ylab = "Residuals")
abline(h = 0, col ="red")

## Normal Q-Q Plot

qqnorm(residuals_1)
qqline(residuals_1)

## Histogram 

hist(residuals_1)

# Checking BIC for each model

BIC(initial_model)
BIC(model_1)

#### Saving the Final Model ####

saveRDS(
  model_1,
  file = "model/model_1.rds"
)

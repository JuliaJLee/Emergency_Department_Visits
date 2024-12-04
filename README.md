# Toronto Average Neighbourhood Income Analysis

## Overview

This repository provides readers with the necessary data, R scripts, and files to understand and reproduce an analysis on average incomes across Toronto's neighbourhoods.

## File Structure

The repository is structured as follows:

- In the `scripts` directory, there are R scripts and code to simulate, download, and clean the data. There is also a script (`05-model_data.R`) outlining the code for the model used within this analysis.
- The `data` folder contains folders for simulated data, raw data obtained from the Open Toronto Data Portal, and cleaned, analysis data. There is also a folder (`03-map_data`) that contains a shapefile used to create a map within this analysis. This spatial data is also obtained from the Open Toronto Data Portal. 
- In the `model` directory, a rds file for the model that was built within this analysis can be found.
- The `plan` folder contains a `sketches` sub-folder that outlines how data will be organized and visualized for the analysis. Additionally, there is a `datasheet` directory that has a datasheet for the data used in the analysis. Here, there is also a `map_visualizations` folder that contains two images of the maps provided in the analysis.
- The `paper` folder contains the files used to generate the final report. This includes the Quarto document where the paper was written, a reference bibliography file, and the PDF of the final paper. 

## Statement on LLM usage

LLMs were not used in this analysis in any way. All code and text are written solely by the author of this repository (Julia Lee).
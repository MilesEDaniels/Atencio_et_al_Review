# Data and R Script for Atencio et al. Manuscript
Model of dose-response function for Ceratonova shasta infection in Chinook salmon

Last updated 11/18/2024, Miles Daniels (miles.daniels@ucsc.edu)

Two files are present. One file is a csv that is the data used to fit the models. The other file is an R script that fits the models. 

Data file is titled: "Intestine_Cs_Model_dataframe_11_15_2024.csv" and contains 9 columns:
  1) Fish_ID: unique identifier for sample that indicates year, month, day of sample collection, the site, and individual fish number.
  2) Site: site identifier.
  3) Date_sampled: date of sample collection.
  4) Exposure: the exposure cluster.
  5) Days_in_river: time spent in river.
  6) Cs_intestine_PCR_binary: outcome of PCR assay (0 = negative, 1 = positive) for C. shasta.
  7) Max_Cs_spores_n_L: max C. shasta spore concentration (N/Liter) during exposure.
  8) Mean_water_temp_C: mean water temperature (degree celsius) during exposure.
  9) Mean_water_velocity_ms: mean water velocity (meters/second) during exposure.

Script file is titled: "DR_Model_Script_11_18_24.R" and contains the R script to fit mixed-effects logistic regression models.
      


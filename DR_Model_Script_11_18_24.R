# Build GLMER models for Dose-Response C. shasta infection model
# Author: Miles Daniels (miles.daniels@ucsc.edu)
# Date Updated: Nov-18-2024

rm(list=ls()) # clear console 

# load libraries
library(lme4)
library(AICcmodavg)

# set data directory and load data
setwd("/Volumes/MD_Portable/Models/Prop_1_Disease/Manuscripts/Ben_Caging_Paper/Eco_Applications_Submission/Ecosphere")
DATA = read.csv("Intestine_Cs_Model_dataframe_11_15_2024.csv", header=T, stringsAsFactors=F)

DATA$Ex_Site = paste0("E",DATA$Exposure,"_",DATA$Site) # new grouping term for mixed effect models
DATA$Mean_water_velocity_cms = DATA$Mean_water_velocity_ms*10 # convert velocity to centimeter per second from meter per second
DATA$Max_Cs_spores_div5 = DATA$Max_Cs_spores_n_L/5 #rescale Cs conc

# build set of candidate models that have different random effects structures 

m0 = glmer(Cs_intestine_PCR_binary~Max_Cs_spores_div5+Mean_water_temp_C+Mean_water_velocity_cms+Days_in_river+(1|Ex_Site),
            data=DATA, family="binomial")

m0_Cs = glmer(Cs_intestine_PCR_binary~Max_Cs_spores_div5+Mean_water_temp_C+Mean_water_velocity_cms+Days_in_river+(0+Max_Cs_spores_div5|Ex_Site),
               data=DATA, family="binomial")

m1_Cs = glmer(Cs_intestine_PCR_binary~Max_Cs_spores_div5+Mean_water_temp_C+Mean_water_velocity_cms+Days_in_river+(1+Max_Cs_spores_div5|Ex_Site),
               data=DATA, family="binomial")

m0_T = glmer(Cs_intestine_PCR_binary~Max_Cs_spores_div5+Mean_water_temp_C+Mean_water_velocity_cms+Days_in_river+(0+Mean_water_temp_C|Ex_Site),
              data=DATA, family="binomial")

m1_T = glmer(Cs_intestine_PCR_binary~Max_Cs_spores_div5+Mean_water_temp_C+Mean_water_velocity_cms+Days_in_river+(1+Mean_water_temp_C|Ex_Site),
              data=DATA, family="binomial")

m0_V = glmer(Cs_intestine_PCR_binary~Max_Cs_spores_div5+Mean_water_temp_C+Mean_water_velocity_cms+Days_in_river+(0+Mean_water_velocity_cms|Ex_Site),
              data=DATA, family="binomial")

m1_V = glmer(Cs_intestine_PCR_binary~Max_Cs_spores_div5+Mean_water_temp_C+Mean_water_velocity_cms+Days_in_river+(1+Mean_water_velocity_cms|Ex_Site),
              data=DATA, family="binomial")

m0_D = glmer(Cs_intestine_PCR_binary~Max_Cs_spores_div5+Mean_water_temp_C+Mean_water_velocity_cms+Days_in_river+(0+Days_in_river|Ex_Site),
              data=DATA, family="binomial")

m1_D = glmer(Cs_intestine_PCR_binary~Max_Cs_spores_div5+Mean_water_temp_C+Mean_water_velocity_cms+Days_in_river+(1+Days_in_river|Ex_Site),
              data=DATA, family="binomial")


Cand.models=list("m0"=m0,"m0_Cs"= m0_Cs,"m1_Cs"= m1_Cs,"m0_T"= m0_T,"m1_T"= m1_T,"m0_V"= m0_V,"m1_V"= m1_V,"m0_D"= m0_D,"m1_D"= m1_D)

# generate AIC model section table
selectionTable = aictab(cand.set=Cand.models)

# calculate evidence ratios
evidence(selectionTable,model.high="m0_Cs", model.low="m1_Cs")
evidence(selectionTable,model.high="m0_Cs", model.low="m1_V")
evidence(selectionTable,model.high="m0_Cs", model.low="m0_T")
evidence(selectionTable,model.high="m0_Cs", model.low="m0")
evidence(selectionTable,model.high="m0_Cs", model.low="m0_D")
evidence(selectionTable,model.high="m0_Cs", model.low="m0_V")
evidence(selectionTable,model.high="m0_Cs", model.low="m1_D")
evidence(selectionTable,model.high="m0_Cs", model.low="m1_T")


assign_binaries_lab = function(d) {

  ## experimental design
  d$lab_raised = 1
  
  ## flight response
  d$flew_b[d$flew == "Y"] = 1
  d$flew_b[d$flew == "N"] = 0
  
  ## population
  d$pop_b[d$pop == "KL"] = 1
  d$pop_b[d$pop == "PK"] = 0
  
  ## host plant 
  d$host_plant_b = 0
  
  ## age
  d$age = as.factor("similar")
  d$age_b = 1
  
  ## growth temperature
  d$growth_temp = as.factor("constant")
  d$growth_temp_b = 1
  
  ## growth relative humidity
  d$growth_RH = as.factor("constant")
  d$growth_RH_b = 1
  
  return(d)
  
}
assign_binaries_field = function(d) {

  ## experimental design
  d$lab_raised = 0 # * most important
  
  ## population
  d$pop_b[d$population == "Key Largo"] = 1
  d$pop_b[d$population == "Plantation Key"] = 0
  
  ## host plant
  d$host_plant_b = 0 # check this
  
  ## age 
  d$age = as.factor("variable")
  d$age_b = 0
  
  ## growth temperature
  d$growth_temp = as.factor("variable")
  d$growth_temp_b = 0
  
  ## growth relative humidity
  d$growth_RH = as.factor("variable")
  d$growth_RH_b = 0
  
  return(d)
  
}

get_comparison_data = function(dnorm, dextreme) {
  
  # filter for desired populations
  dfn = dnorm[dnorm$population == "Key Largo" | dnorm$population == "Plantation Key",]

  # assign binaries (field raised)
  dfn = assign_binaries_field(dfn)
  
  # mass centered and logsqrt
  dfn$mass_logsqrt = log(sqrt(dfn$mass))-mean(log(sqrt(dfn$mass)), na.rm=TRUE)
  
  # calculate distance from the sympatric zone
  sym_zone = unique(dnorm[dnorm$population == "Homestead", "latitude"])
  
  # filter for desired temperature and relative humdity conditions
  dex = dextreme[dextreme$temp == 28 & dextreme$RH == 70 & dextreme$NOTES == "", ]
  
  # assign binaries (lab raised)
  dex = assign_binaries_lab(dex)

  # calculate continuous factors
  ## mass centered and logsqrt
  dex$mass = as.numeric(dex$mass) 
  dex$mass_logsqrt = log(sqrt(dex$mass))-mean(log(sqrt(dex$mass)), na.rm=TRUE)
  dex$mass_c = dex$mass - mean(dex$mass)
  
  ## latitude and distance from the sympatric zone 
  dex$latitude = 24.97357 # PK
  dex$latitude[dex$pop == "KL"] = 25.12846
  dex$lat_c = dex$latitude-mean(dex$latitude)
  dex$sym_dist = abs(dex$latitude - sym_zone)
  dex$sym_dist_s = (dex$sym_dist - mean(dex$sym_dist)) / sd(dex$sym_dist)
  
  # combine datasets row-wise
  dex_short = dex[, c("flew_b", "pop_b", "lab_raised",
                      #"host_plant_comp_b", "age_b", "temp_b", "RH_b",
                      "mass_logsqrt", "sym_dist_s")]
  dfn_short = dfn[, c("flew_b", "pop_b","lab_raised",
                        #"host_plant_comp_b", "age_b", "temp_b", "RH_b",
                        "mass_logsqrt", "sym_dist_s")]

  merged_df = rbind(dex_short, dfn_short)
  
  # return all cleaned datasets
  data_list = list(dfn, dex, merged_df)
  
  return(data_list)
  
}
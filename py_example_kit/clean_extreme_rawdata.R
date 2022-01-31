# Cleaning extreme flight trial handwritten data to prep for WINDAQ python processing
# 01/28/2022
# avbernat; sajemangru

rm(list=ls())
dir = "/Users/anastasiabernat/Desktop/flight_trials/data"
raw_data = read.csv(paste0(dir, "/exflight-trial-data.csv"),
                    header=TRUE,
                    stringsAsFactors = TRUE)

data = raw_data[raw_data$ID != "ID" 
                & raw_data$died. != "?" 
                & raw_data$died. != "Y"
                & raw_data$NOTES != "missed"
                & raw_data$NOTES != "escaped"
                & raw_data$NOTES != "paint fel off; moved to later day"
                & raw_data$chamber != ""
                ,] 

write.csv(data, paste0(dir, "/exflight-trial-data-pro4py.csv"))

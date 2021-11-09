setwd("~/Dropbox/My Mac (EE-ML-001)/Documents/GitHub/extreme-flight-trials/datasheets")

datasheet_1<-read.csv("flight_trial_datasheets_round_1.csv")
IDs_1<-as.numeric(datasheet_1$ID[datasheet_1$ID!="ID" & datasheet_1$ID!=""])

datasheet_2<-read.csv("flight_trial_datasheets_round_2.csv")
IDs_2<-as.numeric(datasheet_2$ID[datasheet_2$ID!="ID" & datasheet_2$ID!=""])

datasheet_3<-read.csv("flight_trial_datasheets_round_3.csv")
IDs_3<-as.numeric(datasheet_3$ID[datasheet_3$ID!="ID" & datasheet_3$ID!=""])

IDs<-sort(c(IDs_1, IDs_2, IDs_3))

write.csv(IDs, "IDs.csv")
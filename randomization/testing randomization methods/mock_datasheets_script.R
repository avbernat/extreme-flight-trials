##Visualizing randomized data
#first setwd
setwd("~/Documents")

#load data from mock_datasheets in progress
#input_raw <- read.csv("./GitHub/extreme-flight-trials/randomization/mock_datasheets_Option_1.csv", header=T, sep=",", quote="", stringsAsFactors=F)
input_raw <- read.csv("/Users/anastasiabernat/Desktop/git_repositories/extreme-flight-trials/randomization/mock_datasheets_Option_1.csv", header=T, sep=",", quote="", stringsAsFactors=F)


#Since only 12C is being tested twice through these dates, drop the last date to summarize/visualize evenness by family
input <- input_raw

##Are the families being evenly distributed between temperature treatments?
summary_fam <- aggregate(gen1_ID~MID*test_temp, data=input, FUN=length)
summary_fam

plot(gen1_ID~MID, data=summary_fam, col=seq(1:5)[as.factor(test_temp)])

#we can see here that some families are not evenly distributed among treatments, presumably because emergence was spread unevenly. This may self-correct over multiple blocks of treatment.

##Are ages evenly distributed between test temperatures?
input<-input_raw #reintroduce later date

summary_age <- aggregate(gen1_ID~test_age*test_temp, data=input_raw, FUN=length)
summary_age

plot(gen1_ID~test_temp, data=summary_age, col=seq(1:5)[as.factor(test_age)])

#we can see that the overall spread of ages is quite low (17-22). Individuals in the 40C treatment are slightly younger. Again, over enough randomized blocks this should even out.

###Randomizing option 2:
#load data from mock_datasheets in progress
input <- read.csv("./GitHub/extreme-flight-trials/randomization/mock_datasheets_Option_2.csv", header=T, sep=",", quote="", stringsAsFactors=F)
input <- read.csv("/Users/anastasiabernat/Desktop/git_repositories/extreme-flight-trials/randomization/mock_datasheets_Option_2.csv", header=T, sep=",", quote="", stringsAsFactors=F)

##Are the families being evenly distributed between temperature treatments?
#give families non-numeric IDs

summary_fam <- aggregate(gen1_ID~MID*test_temp, data=input, FUN=length)
summary_fam

plot(gen1_ID~MID, data=summary_fam, col=seq(1:5)[as.factor(test_temp)])

#Because some MID are so close together visualizing this isn't that useful, but families are now very evenly distributed between treatments.

##Are ages evenly distributed between test temperatures?

summary_age <- aggregate(gen1_ID~test_temp, data=input, FUN=mean)
summary_age

plot(test_age~test_temp, data=summary_age)

#By chance, some temperatures have come repeatedly later in the order. There is a lot more spread in age. Given the small number of times each temperature will be repeated, consider ways to avoid the same temperatures coming early/late in each set.

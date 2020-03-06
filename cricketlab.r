#set working directory
#set working directory
setwd("/home/normie/Downloads")

#read in csv file with data and put it in obeject called cricketA
cricketA <- read.csv("Cricket_Lab_Part_A_Data-1.csv")
cricketA
###################_Part_A_####################
#a) compare residents versus intruders in each of the two treatments (Female Present and Female Absent);
#   use Student’s (that is, unpaired) t-test (do 2 statistical tests per behaviour).

#subset the data to only show FA treatment and put it in object called FA.treatment
FA.treatment <- subset(cricketA, cricketA$treatment=="FA")
FA.treatment

#subset the data to only show antennation from the FA treatment and put it in object called FA.ant
FA.ant <- subset(FA.treatment, FA.treatment$behaviour=="antennation")
FA.ant

FP.treatment <- subset(cricketA, cricketA$treatment=="FP")

#run a t-test between the behaviour count and resident/intruder males using the new, subsetted data (FA.ant)
shit <- t.test(FA.ant$behaviour.count ~ FA.ant$resident.or.intruder)
#t test takes two arguments:
# t.test(A ~ B)
# A = a numeric value, e.g. behaviour count
# B = boolean value
# function will compare variation of A, between rows that match one or the other value in B
#repeat for all behaviours

#repeat above steps for FP treatment

######PART B


setwd("/home/normie/Downloads")

#read in csv file with data and put it in obeject called cricketA
partB <- read.csv("Cricket_Lab_Part_B_Data-1.csv")
fmrh <- subset(partB, partB$treatment == "FMR.H")
fmrl <- subset(partB, partB$treatment == "FMR.L")
fmnrh <- subset(partB, partB$treatment == "FMNR.H")
fmnrl <- subset(partB, partB$treatment == "FMNR.L")


###################_Part_B1_####################
# Compare the scores of focal males in each of the four treatments: 
# (i) low RHP resident; (ii) low RHP non-resident; (iii) high RHP resident; (iv) high RHP non-resident) 
# using a two-way ANOVA

# aov1 <- aov(score ~ rhp * focal.new.male data = partB)
aov(behaviour.count=="winner" ~ behaviour * focal.new.male, data=fmrh) -> aovFMRH
#do the same for the other treatments

# var <- something
#   means store a method into the var
# aov function syntax:
# aov( dependent var ~ factor you wanna test + other factor you wanna test, data=[your data])


summary(aovFMRH) #gonna give you a summary of the values stored in aovFMRH
#aov just tabulates an analysis of variance, summary goes more in depth

###################_Part_B2_####################
# Compare the total number of agressive behaviours in each of the four treatments: 
# (i) low RHP resident; (ii) low RHP non-resident; (iii) high RHP resident; (iv) high RHP non-resident) 
# using a two-way ANOVA

fmrhtotal <- aov(behaviour.count ~ treatment, data=partB)
# add a new column to your dataset similar as you did with the pairwise score, but this time for each replicate, add the TOTAl number behaviours of the male and focal male together. combine all behaviours (total agressive behaviours)
# (so for each replicate you'll have 1 number of total bahviours) 

#run an anoava on that

# aov2 <- aov(total.behaviour ~ rhp * residencey, data = partB)



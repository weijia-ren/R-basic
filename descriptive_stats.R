##############  Descriptive Statistics ###################

###############  Categorical   #####################
# Frequency of one variable
table(mydata$Gender)
#################### two-way crosstab  ###################
a<-table(mydata$Gender,mydata$Student.Status)
addmargins(a)                # add row/col margins
prop.table(a)                # proportion
round(prop.table(a),2)       # prop round to 2 digit
######### row ############ 
prop.table(a,1)              # row proportion 
round(prop.table(a,1),2)     # round row prop to 2 digits
round(100*prop.table(a,1),2) # round row prop to 2 digits (%)
addmargins(round(prop.table(a,1), 2))   # round row prop to 2 digits - with margins
addmargins(round(prop.table(a,1), 2),1)   # round row prop to 2 digits - with column margins
addmargins(round(prop.table(a,1), 2),2)   # round row prop to 2 digits - with row margins
######### column ############
prop.table(a,2)              # column proportion 
round(prop.table(a,2),2)     # round column prop to 2 digits
round(100*prop.table(a,2),2) # round column prop to 2 digits (%)
addmargins(round(prop.table(a,2), 2))   # round column prop to 2 digits - with margins
addmargins(round(prop.table(a,2), 2),1)   # round column prop to 2 digits - with column margins
addmargins(round(prop.table(a,2), 2),2)   # round column prop to 2 digits - with row margins
########  chi-square  #########
chisq.test(a)                 # chi-square test, H0: no relationship 
fisher.test(a)                # fisher's exact test, H0: no relationship

library(vcd)
assocstats(a)                 # chi-square test (ll,pearson), cramer's V

#################### three-way crosstab  ###################
b<-xtabs(~Student.Status+Major+Gender, data=mydata)
b                            # separate tables
ftable(b)                    # combined big table

#############################   Freq/Crosstab with formatted tables  ######################
library(gmodels)
mydata$ones <- 1
CrossTable(mydata$Major,digits=2)              # Show table horizontal 
CrossTable(mydata$Major,digits=2, max.width=1) # Show table vertical
CrossTable(mydata$Major,mydata$ones, digits=2)
CrossTable(mydata$Gender,mydata$ones, digits=2)
CrossTable(mydata$Major,mydata$Gender,digits=2, expected=TRUE,dnn=c("Major","Gender"))
CrossTable(mydata$Major,mydata$Gender,digits=2, chisq=TRUE, dnn=c("Major","Gender"))
CrossTable(mydata$Major,mydata$Gender,digits=2, dnn=c("Major","Gender"))
CrossTable(mydata$Major,mydata$Gender, format=c("SPSS"), digits=1)
chisq.test(mydata$Major,mydata$Gender)         # Null hipothesis: no association


###############  Numeric       ######################

mean(mydata$Age)              # mean of numeric variable (non-missing)
with(mydata,mean(Age))        # same as above
median(mydata$Age)            # median of numeric variable (non-missing)
var(mydata$Age)
sd(mydata$Age)
max(mydata$Age)
min(mydata$Age)
range(mydata$Age)
quantile(mydata$Age)
quantile(mydata$Age,c(.3,.6,.9))  # customized quantile
fivenum(mydata$Age)
$






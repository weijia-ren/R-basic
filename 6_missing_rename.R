#  Missing Data, Renaming, Replacing

###################### Missing data #####################
# read in data
mydata <- read.csv("C:/Users/ren_w/Desktop/R code/R-basic/data/students.csv", header=TRUE)
# check missing data
rowSums(is.na(mydata))       # NO. of missing per row
rowMeans(is.na(mydata))*length(mydata)  # NO. of missing per row, length=num of variables in an object
colSums(is.na(mydata))       # NO. of missing per column
mydata[complete.cases(mydata),]    # list rows of data have complete values
mydata[!complete.cases(mydata),]   # list rows of data have missing values

# recode to missing 

# keep non-missing cases
mydata1<- na.omit(mydata) # new dataset with listwise deletion of missing values, only keep no-missing data

# replace a value
mydata[mydata$SAT==1701,"SAT"] <- 1800
mydata[mydata$Country=="Bulgaria","Country"] <- "US"


# rename


library(reshape)

mydata1 <- rename(mydata, c(Last.Name="Last"))             # rename variable Last.Name to Last
mydata1 <- rename(mydata1, c(Newspaper.readership..times.wk.="Read"))














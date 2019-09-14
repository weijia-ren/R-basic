# R data exploration

# read in data for display purpose
mydata <- read.csv("C:/Users/ren_w/Desktop/R code/R-basic/data/students.csv", header=TRUE)

############# explore the data  ###################
str(mydata)     # provide the structure of the dataset
summary(mydata) # provide basic descriptive statistics and freq
names(mydata)   # list variables in the dataset
edit(mydata)    # open data editor
head(mydata)    # first 6 rows 
head(mydata,n=10)# first 10 rows
head(mydata,n=-10)#all rows but the last 10
tail(mydata)    # last 6 rows 
tail(mydata,n=10)# last 10 rows
tail(mydata,n=-10)#all rows but the first 10

mydata[1:10, ]   # first 10 rows
mydata[1:10,1:3] # first 10 rows, first 3 columns

# similar to summary
library(pastecs)
stat.desc(mydata)                   # all variables
stat.desc(mydata[,c("Age","SAT")])  # selected variables 
stat.desc(mydata[,c("Age","SAT")],basic=TRUE,desc=TRUE,norm=TRUE,p=0.95)  # selected statistics
stat.desc(mydata[1:5])              # selected cases


############# explore the workspace  ###################
objects()       # lists the objects in the workspace 
ls()            # Same as objects()
remove()        # Remove objects from the workspace
rm(list=ls())   #clearing memory space
detach(package:tidyverse) # Detached packages not needed
search()        # show the loaded packages
library()       # show the installed packages
dir()           # show files in the working directory






## Set the library path
.libPaths(c(.libPaths(),"c:/3.5"))
# This codes summarize how to import and export dataset for different software

# save the commands used during the session
savehistory (file="testlog.Rhistory")
# load the commands
loadhistory (file="testlog.Rhistory")
# Display the last 25 commands
history()

########## Get Help  ###########
?plot  # request the plot function documentation
??regression  # search anything has word "regression"
apropos("age") # search word "age" in the objects in the current session
help(package=car) # view documentation in package 'car'
args(log)  # Description of the command

################## Import DATA #################################
# 1. download dataset from the Internet 
download.file("http://dss.princeton.edu/training/students.xls",
              "C:/Users/ren_w/Desktop/R code/R-basic/data/students.xlsx",
              method="auto",
              quiet=FALSE,
              mode = "wb",
              cacheOK = TRUE)


# 2. from CSV
csv <- read.csv("C:/Users/ren_w/Desktop/R code/R-basic/data/students.csv", header=TRUE)

# 3. from TXT
txt <- read.table("C:/myfolder/abc.txt", header=TRUE, sep="\t", na.strings = "-9") 

# 4. from STATA
library(foreign) 
stata <- read.dta("http://dss.princeton.edu/training/students.dta",
                  convert.factors=TRUE,
                  convert.dates=TRUE,
                  convert.underscore=TRUE,
                  warn.missing.labels=TRUE)
# 5. from SPSS
library(foreign) 
spss <- read.spss("http://dss.princeton.edu/training/mydata.sav",
                  to.data.frame = TRUE,
                  use.value.labels=TRUE,
                  use.missings = to.data.frame) 

# 6. from SAS
library(foreign) 
sas <- read.xport("c:/myfolder/mydata.xpt") # NOTE: Does not work for files available online
library(sas7bdat)
sas <- read.sas7bdat("C:/Users/ren_w/Desktop/R code/R-basic/data/test.sas7bdat") # don't work
library(haven) 
sas <- read_sas("C:/Users/ren_w/Desktop/R code/R-basic/data/test.sas7bdat")

# 7. from R
load ("C:/../mydata.RData")
load ("C:/../mydata.rda")


################## Outport DATA #################################
# 1. to TXT
write.table(txt, file = "test.txt", sep = "\t")

# 2. to STATA
write.dta(mydata, file = "test.dta") # option1: Direct export to Stata
write.foreign(mydata, codefile="test1.do", datafile="test1.raw", package="Stata") # option2: Provide a dofile to read the *.raw data

# 3. to SPSS
library(foreign) 
write.foreign(mydata, codefile="test2.sps", datafile="test2.raw", package="SPSS") # Provides a syntax file (*.sps) to read the *.raw data file 

# 4. to SAS
library(haven) 
write_sas(sas, "C:/Users/ren_w/Desktop/R code/R-basic/data/sas_write.sas7bdat")
library(foreign) # didn't try, may not work
write.foreign(mydata, codefile="test2.sas", datafile="test2.raw", package="SAS") # Provides a syntax file (*.sas) to read the *.raw data file 

# 5. to R
save.image("mywork.RData") # Saving all objects to file *.RData
save(object1, object2, file = "mywork.rda") # saving selected objects

# 6. to CSV
library(tidyverse)
write_csv(mydata,path="C:/Users/ren_w/Desktop/R code/R-basic/data/csv_write.csv")


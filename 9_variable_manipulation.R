###### Variable Manipulation
# read in data
mydata <- read.csv("C:/Users/ren_w/Desktop/R code/R-basic/data/students.csv", header=TRUE)

#############################   Explore    #############################
#  explore the levels variables 
levels(mydata$City)  
#  sort 
mydata.sorted <- mydata[order(mydata$SAT),]   # sort ascending by the SAT score 
mydata.sorted1 <- mydata[order(mydata$Gender, -mydata$SAT),]   # sort ascending by Gender, descending by SAT


#############################  Create ID  #############################

# create id with a sequence of numbers from 1 to n (total number of observations)
mydata$id <- seq (dim(mydata)[1])
# create total with total number of observations in the dataset
mydata$total <- dim(mydata)[1]
# create id within group
mydata <- mydata[order(mydata$view),]  # sort the dataset by the 'group' variable
idgroup <- tapply(mydata$view, mydata$view, function (x) seq (1, length(x),1)) # count the number within each group
mydata$idgroup<- unlist(idgroup)   # attach the id back to data

##############################  Assign value labels  ############################
# For nominal variable
mydata$sex <- factor(mydata$sex, levels = c(1, 2), labels = c("boy", "girl")) 

# For ordinal variable (save as a new variable)
mydata$view2 <- ordered(mydata$view, levels = c(1,2,3,4), labels = c("Strongly agree", "Somewhat
agree", "Somewhat disagree", "Strongly disagree"))


#########################  Recode  ####################################
#  recode numeric variable to categorical 
library(car)
mydata$age.rec <- recode (mydata$Age, "18:19 = '18 to 19'; 
                          20:29='20 to 29';
                          30:39='30 to 39'")
mydata$age.rec <-as.factor(mydata$age.rec)
levels(mydata$age.rec)   



########################  Delete   #######################################
# delete variable
mydata$age.rec <- NULL                  # delete the age.rec variable
mydata$idgroup <- mydata$total <- NULL  # delete both idgroup and total variable

########################### Subset  #############################

#####################  with basic R  ###############################
###########  subset columns ##############
# Selecting the first 14 variables (columns)
mydata2 <- mydata[,1:14]    # option 1
mydata2 <- mydata[c(1:14)]  # option 2
# Selecting only two variables (ID & SAT) 
sat <- mydata[c("ID", "SAT")]   # option 1
sat <- mydata[c(1,11)]          # option 2
# Select specific column 1,2,3,12,13,14
select <- mydata[c(1:3, 12:14)] # Type names(select) to verify
# Select specific column except 1,2,3,12,13,14
select1 <- mydata[c(-(1:3), -(12:14))] # Excluding variables


###########  subset rows ##############
mydata2 <- mydata[1:30,] # Selecting the first 30 observations
mydata3 <- mydata[which(mydata$Gender=='Female' & mydata$SAT > 1800), ]  # select rows with female and SAT>1800

###########  subset both rows & columns ##############
mydata4 <- mydata[1:10,1:4] # select first 10 rows, 4 variables 

#####################  with -subset- package  ###############################
mydata5 <- subset(mydata, Age >= 20 & Age <= 30)          # subset rows with age between 20 and 30
mydata6 <- subset(mydata, Age >= 20 & Age <= 30, select=c(ID, Age))  # subset rows with age between 20 and 30, only two variables
mydata7 <- subset(mydata, Gender=="Female" & Age >= 30) # subset female with age >30
mydata8 <- subset(mydata, Gender=="Female" & Student.Status=="Graduate" & Age == 30) # subset female graduates with age >30

#####################  with -Tidyverse- package  ###############################
####  select columns ####
library(tidyverse)               # using the dplyr package specifically
select(mydata,Gender,SAT)        # select column "Gender" and "SAT"
select(mydata,Gender:SAT)        # select columns between "Gender" and "SAT"
select(mydata,-c(Gender,SAT))    # select all columns except "Gender" and "SAT"
select(mydata,starts_with("S"))  # select columns starting with "S"
select(mydata,ends_with("E"))    # select columns ending with "E"
select(mydata,contains("A"))     # select columns containing "A"
select(mydata,matches("^.{4}$")) # select columns match the regular expression (i.e. 4 character word)
select(mydata,one_of(c("Name","Age","student")))  # select columns whose names are one of a set
select(mydata,num_range("x",1:5))# select columns named in prefix, number style

####  select rows ####
filter(mydata, Gender=="Female")        # select "Female" records
# other options: < > == <= >= 
# !=         (not equal to)  
# %in%       (group membership)
# is.na()    (is NA)
# !is.na()   (is not NA)
# &          (and)
# |          (or)
# xor()      (exactly or)
# !          (not)
filter(mydata,is.na(SAT))            # select cases with missing SAT
filter(mydata,!is.na(SAT))           # select cases with non-missing SAT
filter(mydata,State=="New York", Gender=="Female") # select Females from New York
filter(mydata,State=="New York" & Gender=="Female")# same above
filter(mydata,State=="New York"|State=="China", Gender=="Female")    # select Females from New York or China
filter(mydata,(State=="New York"|State=="China") & Gender=="Female") # same above
filter(mydata,State %in% c("New York","China"), Gender=="Female")    # same above
filter(mydata,SAT>1000, SAT<1500)     # select cases with 1000<SAT<1500

####################  re-arrange datasets   ##########################
## sort ascending 
arrange(mydata,SAT)       # order by SAT (smallest to largest)
arrange(mydata,Age,SAT)   # order by Age and SAT (smallest to largest)
arrange(mydata,Country,SAT) # order by Country (A to Z) and SAT (smallest to largest)
## sort descending 
arrange(mydata,desc(SAT))       # order by SAT (largest to smallest)

#########################   steps   ##################################
a <- filter(mydata,Age==18 & Gender=="Female")
a <- select(a,Age,Gender,SAT)
a <- arrange(a, desc(SAT))
a
# select 18-year old Female, show the SAT descending
# pipe operator  %>%   (Ctrl + Shift + M)
mydata %>% 
  filter(Age==18 & Gender=="Female") %>% 
  select(Age,Gender,SAT) %>% 
  arrange(desc(SAT)) 

# select cases and plot
mydata %>% 
  filter(Country=="US") %>% 
  select(Age,Gender,SAT) %>% 
  ggplot() +
   geom_line(mapping=aes(Age,SAT,color=Gender))

mydata %>% 
  filter(Country=="US") %>% 
  select(Age,Gender,SAT) %>% 
  ggplot() +
  geom_line(mapping=aes(Age,SAT))+facet_wrap(~Gender)



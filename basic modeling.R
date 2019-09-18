############  modeling  - introduction    ##################
.libPaths(c(.libPaths(),"c:/3.5"))

## popular modeling functions in R ##
lm()              # package 'stats', linear models
glm()             # package 'stats', generalized linear models
gam()             # package 'mgcv', generalized additive models
glmnet()          # package 'glmnet', penalized linear models
rlm()             # package 'MASS', robust linear models
rpart()           # package 'rpart', trees
randomforest()    # package 'randomForest', random forests
xgboost()         # package 'xgboost', gradient boosting machines


library(tidyverse)    # library(modelr), 'modelr' specific folder

mydata <- read.csv("C:/Users/ren_w/Desktop/R code/R-basic/data/students.csv", header=TRUE)
mydata

################ linear model  ####################
m <-lm(SAT ~ Major, data=mydata)    
m                  #  model coefficients
class(m)           #  linear model
# pipe 
m <- mydata %>% lm(SAT~Major+Age+Gender,data=.)        # fit the model with 3 predictors
age_c<-factor(mydata$Age)                              # treat age as categorical
m2 <- mydata %>% lm(SAT~Major+age_c+Gender,data=.)     # re-fit the model 

# broom - turn output into data frames
library(broom)

# tidy () - returns model coefficients, stats
m %>% tidy()                  # show all coefficients
m2 %>% tidy()                 # show all coefficients
m %>% tidy() %>% 
  filter (p.value <=0.05)     # show selected coefficients (p<=0.05)

# glance () - returns model diagnostics 
m %>% glance()                  # show all diagnostics
m %>% glance() %>% 
  select(adj.r.squared,p.value)  # show selected dianotstics

# augment() - returns predictons, residuals, other raw values
m %>% augment()            
m %>% augment(data=mydata)   # add original dataset to the output

# visualize 
mydata %>% 
  ggplot(aes(x=Age,y=SAT))+
  geom_point(alpha=0.8)+
  geom_smooth(method=lm, se=TRUE)

# add prediction
library(modelr)
mydata %>% add_predictions(m,var="new_pred")   

mydata %>% 
  spread_predictions(m,m2)        # show residuals of multiple models - wide form

mydata %>% 
  gather_predictions(m,m2)       # show residuals of multiple models  - long form

mydata %>% 
  gather_predictions(m,m2) %>% 
  ggplot()+
  geom_histogram(aes(pred))+
  facet_grid(model ~ .)       # plot residuals of multiple models  

# add residuals
mydata %>% add_residuals(m,var="new_resid") %>% 
  ggplot()+
  geom_histogram(aes(new_resid))             # plot residuals

mydata %>% 
  spread_residuals(m,m2)        # show residuals of multiple models - wide form

mydata %>% 
  gather_residuals(m,m2)       # show residuals of multiple models  - long form

mydata %>% 
  gather_residuals(m,m2) %>% 
  ggplot()+
    geom_histogram(aes(resid))+
    facet_grid(model ~ .)       # plot residuals of multiple models  



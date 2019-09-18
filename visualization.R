##########  Visualization ############

.libPaths(c(.libPaths(),"c:/3.5"))
library(tidyverse)

# template
#ggplot(data = <DATA>) + 
#  <GEOM_FUNCTION>(mapping = aes(<MAPPINGS>))

ggplot(data=mpg)+                                         # dataset
  geom_point(mapping=aes(x=displ,y=hwy,color=class))      # add point - scatterplot , color by class

ggplot(data=mpg)+geom_point(mapping=aes(x=displ,y=hwy,size=class))       # size by class
ggplot(data=mpg)+geom_point(mapping=aes(x=displ,y=hwy,alpha=class))      # transparency by class
ggplot(data=mpg)+geom_point(mapping=aes(x=displ,y=hwy,shape=class))      # shape by class

ggplot(data=mpg)+
  geom_point(mapping=aes(x=displ,y=hwy),color="black",size=3,shape=23,alpha=0.5,fill="green")  # self-define, no legend

# facet
ggplot(data=mpg)+geom_point(mapping=aes(x=displ,y=hwy))+
  facet_wrap(~class,nrow=2) # show in panel

ggplot(data=mpg)+geom_point(mapping=aes(x=displ,y=hwy))+
  facet_grid(drv~cyl)    
ggplot(data=mpg)+geom_point(mapping=aes(x=displ,y=hwy))+
  facet_grid(.~cyl)  

# geom
ggplot(data = mpg) + 
  geom_smooth(mapping = aes(x = displ, y = hwy))            # smooth line fitted to data

ggplot(data = mpg) + 
  geom_smooth(mapping = aes(x = displ, y = hwy,linetype=drv))  # use different line type
ggplot(data = mpg) + 
  geom_smooth(mapping = aes(x = displ, y = hwy,group=drv))  #  group by drv
ggplot(data = mpg) + 
  geom_smooth(mapping = aes(x = displ, y = hwy,color=drv))  #  color by drv, could add "show.legend=FALSE"

ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) +
  geom_smooth(mapping = aes(x = displ, y = hwy))         # both scatterplot and smooth line

ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) +  # global x,y fit for both places below
  geom_point() + 
  geom_smooth()  

ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_point(mapping = aes(color = class)) +             # only color the points
  geom_smooth()

ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_point(mapping = aes(color = class)) + 
  geom_smooth(data = filter(mpg, class == "subcompact"), se = FALSE) # only show line for a subset


# Biometry 2016 
# Lab 7
# Two-Way ANOVAs


q88 <- read.csv("./20160303_biometry_lab_7_two_way_anova/quinn_88_two_way.csv")

q1 <- read.csv("./20160303_biometry_lab_7_two_way_anova/quin_1_two_way.csv")


# Use "quinn_88_two_way.csv". 
# Look at your data 

# does your data meet the assumptions? (use the graphs you made from previous labs)

# do you need to transform the data?

# Run a two-way ANOVA with DENSITY and SEASON as the predictor variables and EGGS as the response variable.  

# to run a two way anova you tell R to do an interaction by using the * character between the predictor variables

model88 <- aov(data=q88, EGGS ~ DENSITY * SEASON)

# how do the residuals look?
# Do they look skewed?  
# Was there interaction?  
# Can you say anything about the main effects?

## Interaction Plot

library(ggplot2)
library(ggthemes)

ggplot(data = q88,
       aes(x = as.factor(DENSITY), y = EGGS, fill = SEASON)) +
  geom_boxplot()
  stat_summary(fun.y=mean, geom="point")+
  stat_summary(fun.y=mean, geom="line")+theme_few()+
  geom_errorbar()

library(dplyr)

new88 <- q88[,c("DENSITY","SEASON","EGGS")] %>% group_by(DENSITY, SEASON) %>% summarise_each(funs(mean, sd, se=sd(.)/sqrt(n())))

ggplot(new88, aes(x=DENSITY, y=mean, colour=SEASON, group=SEASON)) + 
  geom_errorbar(aes(ymin=mean-se, ymax=mean+se, color=SEASON, group=SEASON), width=.1) +
  geom_line() +
  geom_point( size=3)

# Use "quin_1_two_way.csv".  Run a two-way ANOVA with DENSITY and SEASON as the predictor variables and EGGS as the response variable.  

# Are observations normally distributed, independent, with homogeneity of variance?  

# Do you need to transform the data? 

# After you run the ANOVA, check the residuals.  

# Do they look skewed?  

# Was there interaction?  

# Can you say anything about the main effects?  How?  Do so.

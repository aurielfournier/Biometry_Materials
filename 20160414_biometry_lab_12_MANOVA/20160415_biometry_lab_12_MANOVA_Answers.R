# Biometry 2016 
# Lab 12
# MANOVA

library(ggplot2) # graphing
library(ggthemes) # theme_few
library(ggfortify) # autoplot
library(Hotelling) ## NEW PACKAGE gives us hotelling.test()

# responses <- cbind(object$response1, object$response2)
# manova(responses ~ object$covariate)

# Use the data in "fish_density.csv"  

dat <- read.csv("fish_density.csv")

head(dat)
str(dat)
summary(dat)

# The file contains some data from a recent study.  
# We are interested in whether habitat differs among seasons and streams in Ozark streams.  
# We collected habitat data three streams each in Boston Mountains and Ozark Highlands ecoregions.  
# I come to you as my statistician with my data file for 2002 and ask you whether there are differences in stream habitat volume (VOLUME) and current velocity (VELOCITY) among seasons (SEASON or SEASNUM) and streams (STREAM or STREAMNUM) in the Boston Mountain ecoregion (select STREAMNUM<=3). 


# What are the assumptions for this type of test and how can you check for them?  
# Normality

ggplot()+geom_boxplot(data=dat, aes(x=SEASON, y=VOLUME))+theme_few()

ggplot()+geom_boxplot(data=dat, aes(x=SEASON, y=VELOCITY))+theme_few()

ggplot()+geom_boxplot(data=dat, aes(x=STREAM, y=VOLUME))+theme_few()

ggplot()+geom_boxplot(data=dat, aes(x=STREAM, y=VELOCITY))+theme_few()

ggplot()+geom_histogram(data=dat, aes(x=VELOCITY))+facet_wrap(~STREAM)+theme_few()

ggplot()+geom_histogram(data=dat, aes(x=VOLUME))+facet_wrap(~STREAM)+theme_few()

ggplot()+geom_histogram(data=dat, aes(x=VELOCITY))+facet_wrap(~SEASON)+theme_few()

ggplot()+geom_histogram(data=dat, aes(x=VOLUME))+facet_wrap(~SEASON)+theme_few()

# Homogeneity of Variance & Covariance

ggplot()+geom_boxplot(data=dat, aes(x=SEASON, y=VOLUME))+theme_few()

ggplot()+geom_boxplot(data=dat, aes(x=SEASON, y=VELOCITY))+theme_few()

ggplot()+geom_boxplot(data=dat, aes(x=STREAM, y=VOLUME))+theme_few()

ggplot()+geom_boxplot(data=dat, aes(x=STREAM, y=VELOCITY))+theme_few()


cov(dat[,c("VELOCITY","VOLUME")])

# Outliers
# outliers are a big deal in MANOVAs, check and see if you have any, transform to get rid of them.
means <- colMeans(dat[,c("VELOCITY","VOLUME")])

mahalanobis(dat[,c("VELOCITY","VOLUME")], means, diag(2))
# 2 is in diag() because we have two response variables
# 0 

ggplot()+geom_boxplot(data=dat, aes(x=SEASON, y=VOLUME))+theme_few()

ggplot()+geom_boxplot(data=dat, aes(x=SEASON, y=VELOCITY))+theme_few()

ggplot()+geom_boxplot(data=dat, aes(x=STREAM, y=VOLUME))+theme_few()

ggplot()+geom_boxplot(data=dat, aes(x=STREAM, y=VELOCITY))+theme_few()

# Independence
# think about the experimental design, look for grouping or avoidance in the data



# Run the MANOVAs and interpret the output.  

# first we bind together the columns (cbind) of our two responses into a new object
responses <- cbind(dat$VOLUME, dat$VELOCITY)

#op <- options(contrasts=c("contr.helmert","contr.poly"))

model <- manova(responses ~ STREAM + SEASON,data=dat)

con_stream <- t(contrasts(dat$STREAM))

summary(model)


htest_season <- hotelling.test(responses ~SEASON, data=dat)

htest_stream <- hotelling.test(responses ~STREAM, data=dat)

anova1 <- aov(data=dat, VELOCITY ~ STREAM + SEASON)

anova2 <- aov(data=dat, VOLUME ~ STREAM + SEASON)

TukeyHSD(anova1, which="STREAM")
TukeyHSD(anova1, which="SEASON")

TukeyHSD(anova2, which="STREAM")
TukeyHSD(anova2, which="SEASON") 

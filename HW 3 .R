###3.7)

#a)
dataset = read.table("Ch3#7.txt" , header = TRUE)
dataset

##H0: mu1 = mu2 = mu3 = mu4 
##Ha: @ least one is different from rest 

alpha = .05 

test.aov = aov(Strength~factor(Technique), dataset)
summary(test.aov)

##P-val. equals .00489 
##F-stat. equals 12.73

####alpha is greater than P-val. Because of this, we reject the null hypothesis, and can confirm that mixing techniques do affect the strength. 

#b.

#c.
n=4
a=4
N=n*a
N
MSE=summary(test.aov)[[1]][2,3]
MSE
t0=sqrt(2*MSE/4)
t0
cri=qt(alpha/2,N-a,lower.tail=F)
cri
LSD=t0*cri
LSD

#Treatment 2 vs Treatment 4 --> 3156.250-2666.250
###490 is greater than 174.48, reject null hypothesis.

#Treatment 2 vs Treatment 3 ---> 3156-2933.750
###225 is greater than 174.48, reject the null hypothesis.

#Treatment 2 vs Treatment 1 ---> 3156.250-2971.00
###185.25 is greater than 174.48, we reject the null hypothesis and accept the alernative hypothesis.

#Treatment 1 vs Treatment 4 ---> 2971-2666.250
###304.75 is greater than 174.48, we reject the null hypothesis.

#Treatment 3 vs Treatment 4 ---> 2933.750-2666.250
###267.500 is greater than 174, we reject the null hypothesis.

#Treatment 1 vs Treatment 3 ---> 2971-2933.750
###37.250 is less than 174.48, fail to reject the null hypothesis.

#d.
test.lm=lm(Strength~factor(Technique),data=dataset)
library(car)
qqPlot(residuals(test.lm))

##Based on the Plot, Residual points are close to the line, therefore we can conclude the data has a normal distribution.

#e.
plot(fitted(test.lm),residuals(test.lm))

##ratio of largest and smallest SD equals 1.7. (136/81)

#f. 
plot(dataset$Technique,dataset$Strength,main="Scatter Plot part f",xlab="Technique",ylab="Tensile Strength",col=2)


###3.8)

#a. 
TukeyHSD(aov(Strength ~ factor(Technique), dataset))

plot(TukeyHSD(aov(Strength~factor(Technique), dataset)))

##There is a significant difference mixing technique 3 and technique 2, and mixing technique 1 and technique 2 in Fisher's LSD, whereas in Tukey's method there is no significant difference. 

#b.
##LSD is less conservative, but more powerful. LSD test compares one pairwise mean whereas Tukey's method compares all pairwise means. 

###3.9)

#a. 
overall.mean=mean(dataset$Strength)
overall.mean
n=4
a=4
N=n*a
N
alpha=0.05
MSE=summary(test.aov)[[1]][2,3]
MSE
t.cri=qt(1-alpha/2,N-a)
t.cri
ME=c(-1,1)*t.cri*sqrt(MSE/n)
ME
model.tables(test.aov)
#mixing technique 1
CI=overall.mean+39.19+ME
CI
#mixing technique 2
CI=overall.mean+224.44+ME
CI
#mixing technique 3
CI=overall.mean+1.94+ME
CI
#mixing technique 4
CI=overall.mean-265.56+ME
CI
#mixing technique 1 and 3
ME2=c(-1,1)*t.cri*sqrt(2*MSE/n)
ME2
CI=39.19-1.94+ME2
CI

##This information does aid you in interpreting the results of the experiment.

###3.12)

#a.
BA = read.table("Ch3#12.txt", header=TRUE)
BA
alpha = .05

##H0: Dosage level does not effect BA
##Ha: Dosage level does effect BA 

bio.aov=aov(Activity~factor(Dosage), BA)
summary(bio.aov)

##P-val. equals .0145. P-val is less than alpha therefore we can reject H0, claiming there is sufficient evidence that dosage level affects BA.

#b.
TukeyHSD(aov(Activity ~ factor(Dosage), BA))
##Difference between 40g and 20g dosage. (No 0's)

#c.
bio.lm=lm(Activity~factor(Dosage),data = BA)
library(car)
##qqPlot
qqPlot(residuals(bio.lm))
##Residual vs. Fitted Plot
plot(fitted(bio.lm),residuals(bio.lm))

###Data is not normally distributed based on the qqPlot. No pattern therefore the scatter plot is a solid residual.

###3.16)

temp=read.table("CH3#16.txt",header=TRUE)

#H0: firing temperature does not affect the density of the bricks
#Ha: firing temperature does affect the density of the bricks.

alpha=0.05

density.aov=aov(Density~factor(Temp),temp)
summary(density.aov)
#P-value=0.157.
#p-value is greater than the significance level, we fail to reject the null hypothesis.

#b. 
##In this particular experiment, because the firing temperature have same effect on the density of the bricks, we do not need to use Fisher's method. 

#c. 
density.lm=lm(Density~factor(Temp),data=temp)
library(car)
##qqplot
qqPlot(residuals(density.lm))
##can conclude that the data is normally distributed because the residual points are closer to the blue line.
#residuals vs fitted plot
plot(fitted(density.lm),residuals(density.lm))
##This scatter plot is a good residual because it doesn't have a specific pattern. Therefore, the assumptions are not satisfied.

###3.29)

#a. 
numbers=read.table("CH3#29.txt",header=TRUE)

##H0: there is no significant difference between the methods
##Ha: there is significant difference between the methods
co.aov=aov(Count~factor(Method), numbers)
summary(co.aov)
##p-value=0.00643.
##Since p-value is less than 0.05, we reject the null hypothesis.
#Therefore, we have sufficient evidence to support that methods have different effects on the mean particle count.

#b. 
co.lm=lm(Count~factor(Method),data = numbers)
library(car)

##qqplot
qqPlot(residuals(co.lm))
##Can conclude that the data is not normally distributed because the residual points are not close to the blue line as shown by plot. 
#Draw residuals vs fitted plot
plot(fitted(co.lm),residuals(co.lm))
##This scatter plot is a good residual because it doesn't have any pattern. Therefore, the assumptions of the residuals are not satisfied

#c. 
##H0:all medians are equal
##HA: @ least one of the medians differs from other
kruskal.test(Count ~ factor(Method), numbers)
##p-value=0.01398. 
##p-value is less than 0.05, we rejct the null hypothesis (accept Ha)
##We have a sufficient evidence the methods do not have the same affect on the mean particle count.


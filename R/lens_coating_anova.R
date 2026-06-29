# Q. 5 *
# A glass manufacturer wanted to evaluate the performance of protective coating for lenses. A random
# selection of lenses was given one of four different coatings, and then subjected to the same degree of
# simulated abrasion. After the abrasion impairment to light was tested. The higher the number, the
# worse more the lens was scratched.
# The results the results can be found in lenses.csv

# build data frame
lenses=read.csv("./lenses.csv")


# Q. Based on the data, which coating would you recommend?
# a) Describe your initial thoughts on the data.
# 1. Produce a table of descriptive statistics (include the mean and the standard deviation).
library(mosaic)
favstats(impairment ~ Coating, data=lenses)
# Coating min   Q1 median   Q3 max     mean        sd n missing
# 1       A 3.6 3.80    4.0 4.10 4.2 3.942857 0.2225395 7       0
# 2       B 3.9 4.05    4.2 4.25 4.4 4.157143 0.1718249 7       0
# 3       C 4.8 5.00    5.1 5.25 5.6 5.142857 0.2636737 7       0
# 4       D 3.2 3.30    3.4 3.45 3.5 3.371429 0.1112697 7       0

# 2. Produce a well-presented boxplot.
boxplot(impairment ~ Coating, data=lenses, horizontal=TRUE)

# 3. Comment on your findings. Do not simply provide the raw values for the statistics, these are
# presented in parts 1 and 2

# Coating A and Coating D appear to have lower median impairment scores, indicating better performance (less scratching).
# Coating C has the highest median and the widest range suggesting poorer performance.
# Coating B falls between the others but leans closer to coating A in terms of impairment
# 
# From the results, Coating D consistently performs better with the lowest standard deviation / variability, while C shows the highest impairment and more variability





# b) Confirm or contradict your initial findings.
# 1. Using an appropriate statistical test, explore the customer’s question. Remember to declare
# all appropriate hypotheses for all the tests you use. Use a significance level of 0.05 throughout.

# Normality test Hypothesis
# H_0: sample distribution  = normally distributed
# H_1: sample distribution != normally distributed
shapiro.test(lenses$impairment[lenses$Coating == 'A'])
# Shapiro-Wilk normality test
# 
# data:  lenses$impairment[lenses$Coating == "A"]
# W = 0.92158, p-value = 0.4818

shapiro.test(lenses$impairment[lenses$Coating == 'B'])
# Shapiro-Wilk normality test
# 
# data:  lenses$impairment[lenses$Coating == "B"]
# W = 0.97962, p-value = 0.9577

shapiro.test(lenses$impairment[lenses$Coating == 'C'])
# Shapiro-Wilk normality test
# 
# data:  lenses$impairment[lenses$Coating == "C"]
# W = 0.963, p-value = 0.8441

shapiro.test(lenses$impairment[lenses$Coating == 'D'])
# Shapiro-Wilk normality test
# 
# data:  lenses$impairment[lenses$Coating == "D"]
# W = 0.92158, p-value = 0.4818

# Conclusion: All four sub samples (A, B, C, D) have p-values > alpha(0.05), therefore, we can not reject H_0. 
# There is good evidence that all four of the sub samples are normally distributed.
# Hence we can use the ANOVA test


# equal variance test Hypothesis
# H_0 = All groups have equal variances
# H_1 = At least one group has a different variance
library(car)
leveneTest(impairment ~ Coating, data=lenses)
# Levene's Test for Homogeneity of Variance (center = median)
#       Df F value Pr(>F)
# group  3  0.8451 0.4827
#       24         

# Conclusion: the p-value(0.4827) > 0.05, hence we accept H_0.  
# The four sub samples have equal variance.  


# H_0: The mean impairment scores are the same across all coatings
# H_1: At least one coating has a different mean impairment score
model <- aov(impairment ~ Coating, data=lenses)
summary(model)
# Df Sum Sq Mean Sq F value   Pr(>F)
# Coating      3 11.444   3.815    94.8 1.91e-13
# Residuals   24  0.966   0.040                 
# 
# Coating     ***
#   Residuals      
# ---
#   Signif. codes:  
#   0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
# Conclusion: A significant result (p < 0.05) indicates differences in mean impairment scores among the coatings.


TukeyHSD(model)
# Tukey multiple comparisons of means
# 95% family-wise confidence level
# 
# Fit: aov(formula = impairment ~ Coating, data = lenses)
# 
# $Coating
# diff         lwr        upr     p adj
# B-A  0.2142857 -0.08149837  0.5100698 0.2164491
# C-A  1.2000000  0.90421592  1.4957841 0.0000000
# D-A -0.5714286 -0.86721265 -0.2756445 0.0001007
# C-B  0.9857143  0.68993020  1.2814984 0.0000000
# D-B -0.7857143 -1.08149837 -0.4899302 0.0000008
# D-C -1.7714286 -2.06721265 -1.4756445 0.0000000
plot(TukeyHSD(model))


# Conclusion:
# Tukey's HSD test confirmed;
#   Coating D is significantly better (lower impairment scores) than A, B and C.
#   Coating C is signigicantly worse (higher impairment scores) than all other coatings
#   Coatings A and B show no significant difference from each other.
# 
# 
# 
#  2. Comment on the results of the statistical tests in the context of the customer’s question.
  # Based on the data, I would recommend Coating D as the best option for scratch resistance.
  # It not only had the lowest mean impairment score (3.37)but also demonstrated consistent performance (small variability). 
  # Coating C should be avoided due to exceptionally poor performance
 
############
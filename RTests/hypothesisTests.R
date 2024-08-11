library(readr)
library(nortest) # In this case, as there are 10,000 values to be treated, the Lilliefor test was used; if there were less than 30 values, the Shapiro test was used.
library(moments) # Since the Lilliefors test indicates that the data are not normally distributed, the Wilcoxon test is preferred over the t-test because it does not require the assumption of normality.

resultsBal <- read_csv("balResults.csv")
filtered_resultsBal <- resultsBal %>% filter(metric_name == "http_req_duration")
View(filtered_resultsBal)

resultsJava <- read_csv("javaResults.csv")
filtered_resultsJava <- resultsJava %>% filter(metric_name == "http_req_duration")
View(filtered_resultsJava)

resultsBalAOT <- read_csv("balAOTResults.csv")
filtered_resultsBalAOT <- resultsBalAOT %>% filter(metric_name == "http_req_duration")
View(filtered_resultsBalAOT)

resultsJavaAOT <- read_csv("javaAOTResults.csv")
filtered_resultsJavaAOT <- resultsJavaAOT %>% filter(metric_name == "http_req_duration")
View(filtered_resultsJavaAOT)

averageTimeBal<-mean(filtered_resultsBal$metric_value)
averageTimeJava<-mean(filtered_resultsJava$metric_value)
averageTimeBalAOT<-mean(filtered_resultsBalAOT$metric_value)
averageTimeJavaAOT<-mean(filtered_resultsJavaAOT$metric_value)

ConjuntoAverageTimeBal<- filtered_resultsBal$metric_value
ConjuntoAverageTimeJava<- filtered_resultsJava$metric_value
ConjuntoAverageTimeBalAOT<- filtered_resultsBalAOT$metric_value
ConjuntoAverageTimeJavaAOT<- filtered_resultsJavaAOT$metric_value

max(ConjuntoAverageTimeBal)
max(ConjuntoAverageTimeJava)
max(ConjuntoAverageTimeBalAOT)
max(ConjuntoAverageTimeJavaAOT)

min(ConjuntoAverageTimeBal)
min(ConjuntoAverageTimeJava)
min(ConjuntoAverageTimeBalAOT)
min(ConjuntoAverageTimeJavaAOT)

median(ConjuntoAverageTimeBal)
median(ConjuntoAverageTimeJava)
median(ConjuntoAverageTimeBalAOT)
median(ConjuntoAverageTimeJavaAOT)

# --------------------------------------------- BAL AOT vs JAVA AOT ----------------------------------------------------------------
# Normality test
lillie.test(ConjuntoAverageTimeBalAOT)
lillie.test(ConjuntoAverageTimeJavaAOT)

# As the p-value is less than 0.05, there is statistical evidence that the values do not follow a normal distribution



# Asymmetric test
skewness(ConjuntoAverageTimeBalAOT)
skewness(ConjuntoAverageTimeJavaAOT)

# Since the skewness of the ConjuntoAverageTimeBalAOT was lower than 1, and ConjuntoAverageTimeJavaAOT is greater than 1, this indicates that they are symmetric and asymmetric, respectively



# The non parametric Wilcox test will be used since it does not assume normality or symmetry for the data.
# Null hypothesis (H0): There are no significant differences in performance between BAL AOT and JAVA AOT.
# Alternative hypothesis (H1): There are significant differences in performance between BAL AOT and JAVA AOT.
valor_p <- wilcox.test(ConjuntoAverageTimeBalAOT,ConjuntoAverageTimeJavaAOT, paired=FALSE)$p.value
valor_p

# As the p-value is less than 0.05 we have statistical evidence that there are significant differences in performance between BAL AOT and JAVA AOT (the null hypothesis is rejected).

# --------------------------------------------------------------------------------------------------------------------------------



# --------------------------------------------- BAL vs JAVA ----------------------------------------------------------------
# Normality test
lillie.test(ConjuntoAverageTimeBal)
lillie.test(ConjuntoAverageTimeJava)

# As the p-value is less than 0.05, there is statistical evidence that the values do not follow a normal distribution



# Asymmetric test
skewness(ConjuntoAverageTimeBal)
skewness(ConjuntoAverageTimeJava)

# Since the skewness of the two samples was greater than 1, the samples are asymmetrical



# The non parametric Wilcox test will be used since it does not assume normality or symmetry for the data.
# Null hypothesis (H0): There are no significant differences in performance between BAL and JAVA.
# Alternative hypothesis (H1): There are significant differences in performance between BAL and JAVA.
valor_p <- wilcox.test(ConjuntoAverageTimeBal,ConjuntoAverageTimeJava, paired=FALSE)$p.value
valor_p

# As the p-value is less than 0.05 we have statistical evidence that there are significant differences in performance between BAL and JAVA (the null hypothesis is rejected).

# --------------------------------------------------------------------------------------------------------------------------------



# --------------------------------------------- BAL AOT vs BAL ----------------------------------------------------------------
# Normality test
lillie.test(ConjuntoAverageTimeBalAOT)
lillie.test(ConjuntoAverageTimeBal)

# As the p-value is less than 0.05, there is statistical evidence that the values do not follow a normal distribution



# Asymmetric test
skewness(ConjuntoAverageTimeBalAOT)
skewness(ConjuntoAverageTimeBal)

# Since the skewness of the ConjuntoAverageTimeJavaAOT was lower than 1, and ConjuntoAverageTimeBal is greater than 1, this indicates that they are symmetric and asymmetric, respectively



# The non parametric Wilcox test will be used since it does not assume normality or symmetry for the data.
# Null hypothesis (H0): There are no significant differences in performance between BAL AOT and BAL.
# Alternative hypothesis (H1): There are significant differences in performance between AOT and BAL.
valor_p <- wilcox.test(ConjuntoAverageTimeBalAOT,ConjuntoAverageTimeBal, paired=FALSE)$p.value
valor_p

# As the p-value is less than 0.05 we have statistical evidence that there are significant differences in performance between BAL AOT and BAL (the null hypothesis is rejected).

# --------------------------------------------------------------------------------------------------------------------------------
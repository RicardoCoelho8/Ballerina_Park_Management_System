library(readr)
library(nortest) # In this case, as there are 10,000 values to be treated, the Lilliefor test was used; if there were less than 30 values, the Shapiro test was used.
library(moments) # Since the Lilliefors test indicates that the data are not normally distributed, the Wilcoxon test is preferred over the t-test because it does not require the assumption of normality.

resultsHttp1 <- read_csv("http1Results.csv")
View(resultsHttp1)

resultsHttp2 <- read_csv("http2Results.csv")
View(resultsHttp2)

resultsBal <- read_csv("balResults.csv")
View(resultsBal)

resultsJava <- read_csv("javaResults.csv")
View(resultsJava)

resultsBalAOT <- read_csv("balAOTResults.csv")
View(resultsBalAOT)

resultsJavaAOT <- read_csv("javaAOTResults.csv")
View(resultsJavaAOT)

averageTimeHttp1<-mean(resultsHttp1$elapsed)
averageTimeHttp2<-mean(resultsHttp2$elapsed)
averageTimeBal<-mean(resultsBal$elapsed)
averageTimeJava<-mean(resultsJava$elapsed)
averageTimeBalAOT<-mean(resultsBalAOT$elapsed)
averageTimeJavaAOT<-mean(resultsJavaAOT$elapsed)

ConjuntoAverageTimeHttp1<- resultsHttp1$elapsed
ConjuntoAverageTimeHttp2<- resultsHttp2$elapsed
ConjuntoAverageTimeBal<- resultsBal$elapsed
ConjuntoAverageTimeJava<- resultsJava$elapsed
ConjuntoAverageTimeBalAOT<- resultsBalAOT$elapsed
ConjuntoAverageTimeJavaAOT<- resultsJavaAOT$elapsed


max(ConjuntoAverageTimeHttp1)
max(ConjuntoAverageTimeHttp2)
max(ConjuntoAverageTimeBal)
max(ConjuntoAverageTimeJava)
max(ConjuntoAverageTimeBalAOT)
max(ConjuntoAverageTimeJavaAOT)

min(ConjuntoAverageTimeHttp1)
min(ConjuntoAverageTimeHttp2)
min(ConjuntoAverageTimeBal)
min(ConjuntoAverageTimeJava)
min(ConjuntoAverageTimeBalAOT)
min(ConjuntoAverageTimeJavaAOT)

median(ConjuntoAverageTimeHttp1)
median(ConjuntoAverageTimeHttp2)
median(ConjuntoAverageTimeBal)
median(ConjuntoAverageTimeJava)
median(ConjuntoAverageTimeBalAOT)
median(ConjuntoAverageTimeJavaAOT)



# --------------------------------------------- HTTP/1.1 vs HTTP/2 ----------------------------------------------------------------
# Normality test
lillie.test(ConjuntoAverageTimeHttp1)
lillie.test(ConjuntoAverageTimeHttp2)

# As the p-value is less than 0.05, there is statistical evidence that the values do not follow a normal distribution



# Asymmetric test
skewness(ConjuntoAverageTimeHttp1)
skewness(ConjuntoAverageTimeHttp2)

# Since the skewness of the two samples was greater than 1, the samples are asymmetrical



# Null hypothesis (H0): There are no significant differences in performance between HTTP/1.1 and HTTP/2.
# Alternative hypothesis (H1): There are significant differences in performance between HTTP/1.1 and HTTP/2.
valor_p <- wilcox.test(ConjuntoAverageTimeHttp1,ConjuntoAverageTimeHttp2, paired=FALSE)$p.value
valor_p

# As the p-value is greater than 0.05 we have statistical evidence that there are no significant differences in performance between HTTP/1.1 and HTTP/2 (the null hypothesis is not rejected).

# --------------------------------------------------------------------------------------------------------------------------------



# --------------------------------------------- BAL AOT vs BAL ----------------------------------------------------------------
# Normality test
lillie.test(ConjuntoAverageTimeBalAOT)
lillie.test(ConjuntoAverageTimeBal)

# As the p-value is less than 0.05, there is statistical evidence that the values do not follow a normal distribution



# Asymmetric test
skewness(ConjuntoAverageTimeBalAOT)
skewness(ConjuntoAverageTimeBal)

# Since the skewness of the two samples was greater than 1, the samples are asymmetrical



# Null hypothesis (H0): There are no significant differences in performance between BAL AOT and BAL.
# Alternative hypothesis (H1): There are significant differences in performance between AOT and BAL.
valor_p <- wilcox.test(ConjuntoAverageTimeBalAOT,ConjuntoAverageTimeBal, paired=FALSE)$p.value
valor_p

# As the p-value is less than 0.05 we have statistical evidence that there are significant differences in performance between BAL AOT and BAL (the null hypothesis is rejected).

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



# Null hypothesis (H0): There are no significant differences in performance between BAL and JAVA.
# Alternative hypothesis (H1): There are significant differences in performance between BAL and JAVA.
valor_p <- wilcox.test(ConjuntoAverageTimeBal,ConjuntoAverageTimeJava, paired=FALSE)$p.value
valor_p

# As the p-value is less than 0.05 we have statistical evidence that there are significant differences in performance between BAL and JAVA (the null hypothesis is rejected).

# --------------------------------------------------------------------------------------------------------------------------------



# --------------------------------------------- BAL AOT vs JAVA AOT ----------------------------------------------------------------
# Normality test
lillie.test(ConjuntoAverageTimeBalAOT)
lillie.test(ConjuntoAverageTimeJavaAOT)

# As the p-value is less than 0.05, there is statistical evidence that the values do not follow a normal distribution



# Asymmetric test
skewness(ConjuntoAverageTimeBalAOT)
skewness(ConjuntoAverageTimeJavaAOT)

# Since the skewness of the two samples was greater than 1, the samples are asymmetrical



# Null hypothesis (H0): There are no significant differences in performance between BAL AOT and JAVA AOT.
# Alternative hypothesis (H1): There are significant differences in performance between BAL AOT and JAVA AOT.
valor_p <- wilcox.test(ConjuntoAverageTimeBalAOT,ConjuntoAverageTimeJavaAOT, paired=FALSE)$p.value
valor_p

# As the p-value is less than 0.05 we have statistical evidence that there are significant differences in performance between BAL AOT and JAVA AOT (the null hypothesis is rejected).

# --------------------------------------------------------------------------------------------------------------------------------

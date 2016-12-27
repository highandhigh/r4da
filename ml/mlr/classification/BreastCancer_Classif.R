library(mlr)

library(MASS)
library(rpart)
library(randomForest)
library(e1071)
library(class)
library(nnet)
library(lqa)
library(stats)
library(party)
library(randomForestSRC)

library(dplyr)
library(purrr)
library(magrittr)
library(ggplot2)

data(BreastCancer, package = "mlbench")

BreastCancer_DF <- BreastCancer[,-1]

## Generate the task
task <- makeClassifTask(data = BreastCancer_DF, target = "Class")

## Task Info
task
# Supervised task: BreastCancer_DF
# Type: classif
# Target: Class
# Observations: 699
# Features:
#   numerics  factors  ordered 
# 0        4        5 
# Missings: TRUE
# Has weights: FALSE
# Has blocking: FALSE
# Classes: 2
# benign malignant 
# 458       241 
# Positive class: benign

## 数据集：目标3类，分类样本是等比例的；4个特征权重相同，均为连续性数值变量

## Learners to be compared
lrns <- list(
  ## multi-class
  # makeLearner("classif.lda"),  # does not support missing values!
  makeLearner("classif.rpart")
  # makeLearner("classif.randomForest"), # does not support missing values!
  # makeLearner("classif.naiveBayes"), # does not support ordered factor!
  # makeLearner("classif.knn"), # does not support missing values!
  # makeLearner("classif.svm"), # does not support missing values!
  # makeLearner("classif.nnet"), # does not support missing values!
  ## two-class (binary)
  # makeLearner("classif.binomial"),  # does not support missing values!
  # makeLearner("classif.logreg"), # does not support missing values!
  # makeLearner("classif.lqa") # does not support missing values!
)

## Specify the resampling strategy (10-fold cross-validation)
rdesc <- makeResampleDesc("CV", iters = 10)

## Conduct the benchmark experiment
bmr <- benchmark(lrns, task, rdesc, measures = list(mmce, timeboth))

# Task: BreastCancer_DF, Learner: classif.rpart
# [Resample] cross-validation iter: 1
# [Resample] cross-validation iter: 2
# [Resample] cross-validation iter: 3
# [Resample] cross-validation iter: 4
# [Resample] cross-validation iter: 5
# [Resample] cross-validation iter: 6
# [Resample] cross-validation iter: 7
# [Resample] cross-validation iter: 8
# [Resample] cross-validation iter: 9
# [Resample] cross-validation iter: 10
# [Resample] Result: mmce.test.mean=0.06,timeboth.test.mean=0.011


BreastCancer_DF <- BreastCancer[,-1]
## Learners to be compared
lrns <- list(
  ## multi-class
  # makeLearner("classif.lda"),  # does not support missing values!
  makeLearner("classif.rpart"),
  # makeLearner("classif.randomForest"), # does not support missing values!
  # makeLearner("classif.naiveBayes"), # does not support ordered factor!
  # makeLearner("classif.knn"), # does not support missing values!
  # makeLearner("classif.svm"), # does not support missing values!
  # makeLearner("classif.nnet"), # does not support missing values!
  ## two-class (binary)
  # makeLearner("classif.binomial"),  # does not support missing values!
  # makeLearner("classif.logreg"), # does not support missing values!
  # makeLearner("classif.lqa"),  # does not support missing values!
  makeLearner("classif.cforest"),
  makeLearner("classif.ctree"),
  makeLearner("classif.randomForestSRC"),
  makeLearner("classif.randomForestSRCSyn")
)

## Specify the resampling strategy (10-fold cross-validation)
rdesc <- makeResampleDesc("CV", iters = 10) 

## Conduct the benchmark experiment
bmr <- benchmark(lrns, task, rdesc, measures = list(mmce, timeboth))


## Accessing benchmark results
bmr_res <- getBMRAggrPerformances(bmr)

## Print & Plot
tibble(learner = names(bmr_res$Sonar), 
       mmce.test.mean = map_dbl(bmr_res$Sonar, "mmce.test.mean"), 
       timeboth.test.mean = map_dbl(bmr_res$Sonar, "timeboth.test.mean")
) %>% 
  arrange(mmce.test.mean, timeboth.test.mean) %T>%
  print() %>%
  ggplot(aes(x = timeboth.test.mean, y = mmce.test.mean, color = factor(learner))) +
  geom_point()

## classif.randomForest 在测试集上错误分类率最低，但消耗时间最多
## classif.svm 和 classif.knn ：错误分类率低 + 耗时最短



# A tibble: 10 × 3
# learner mmce.test.mean timeboth.test.mean
# <chr>          <dbl>              <dbl>
# 1  classif.randomForest      0.1442857              0.257
# 2           classif.knn      0.1683333              0.002
# 3          classif.nnet      0.1683333              0.045
# 4           classif.svm      0.1780952              0.035
# 5           classif.lda      0.2500000              0.028
# 6           classif.lqa      0.2502381              0.083
# 7         classif.rpart      0.2695238              0.016
# 8      classif.binomial      0.2840476              0.039
# 9        classif.logreg      0.2840476              0.048
# 10   classif.naiveBayes      0.3264286              0.051

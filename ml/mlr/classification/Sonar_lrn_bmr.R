
library(mlr)

library(MASS)
library(rpart)
library(randomForest)
library(e1071)
library(class)
library(nnet)
library(lqa)
library(stats)

library(dplyr)
library(purrr)
library(magrittr)
library(ggplot2)

data(Sonar, package = "mlbench")

## Generate the task
task <- makeClassifTask(data = Sonar, target = "Class")

## Task Info
task
# Supervised task: Sonar
# Type: classif
# Target: Class
# Observations: 208
# Features:
#   numerics  factors  ordered 
# 60        0        0 
# Missings: FALSE
# Has weights: FALSE
# Has blocking: FALSE
# Classes: 2
# M   R 
# 111  97 
# Positive class: M

## 数据集：目标3类，分类样本是等比例的；4个特征权重相同，均为连续性数值变量

## Learners to be compared
lrns <- list(
  ## multi-class
  makeLearner("classif.lda"), 
  makeLearner("classif.rpart"), 
  makeLearner("classif.randomForest"),
  makeLearner("classif.naiveBayes"),
  makeLearner("classif.knn"),
  makeLearner("classif.svm"),
  makeLearner("classif.nnet"),
  ## two-class (binary)
  makeLearner("classif.binomial"),
  makeLearner("classif.logreg"),
  makeLearner("classif.lqa") # Fitting penalized Generalized Linear Models with the LQA algorithm
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
# 1  classif.randomForest      0.1500000             0.2125
# 2           classif.svm      0.1630952             0.0260 *
# 3           classif.knn      0.1926190             0.0024 *
# 4          classif.nnet      0.1971429             0.0406
# 5           classif.lqa      0.2216667             0.0751
# 6           classif.lda      0.2457143             0.0232
# 7      classif.binomial      0.2738095             0.0341
# 8        classif.logreg      0.2738095             0.0354
# 9         classif.rpart      0.3021429             0.0198
# 10   classif.naiveBayes      0.3069048             0.0428

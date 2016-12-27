## Load packages
library(mlr)
library(purrr)
library(dplyr)
library(magrittr)

## Load data
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

## Load the learners
source("classification/classif_learners.R", echo = TRUE, encoding = "UTF-8")
# map(twoclass_learners, makeLearner)
# map(multiclass_learners, makeLearner)

# for (i in twoclass_learners) {
#   if (i %in% multiclass_learners) print(i)
# }
#   

## Learners to be compared
## lrns <- map(c(twoclass_learners,multiclass_learners), makeLearner)

lrns <- task %>% 
  listLearners %>% 
  filter(class != "classif.xgboost") %>% # 错误: 'predict' is not an exported object from 'namespace:xgboost'
  use_series(class) %>% 
  map(makeLearner)

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
  filter(timeboth.test.mean < 5, mmce.test.mean < 0.3) %>%
  ggplot(aes(x = timeboth.test.mean, y = mmce.test.mean, color = factor(learner))) +
  geom_point() +
  guides(color = FALSE)


# A tibble: 66 × 3
# learner mmce.test.mean timeboth.test.mean
# <chr>          <dbl>              <dbl>
# 1          classif.extraTrees   0.1204761905             0.1177
# 2                classif.rknn   0.1245238095             0.1612
# 3            classif.boosting   0.1250000000            20.1639
# 4  classif.randomForestSRCSyn   0.1438095238            20.8026
# 5                classif.kknn   0.1440476190             0.0168
# 6                 classif.svm   0.1535714286             0.0248
# 7               classif.dcSVM   0.1535714286             0.0273
# 8        classif.randomForest   0.1540476190             0.2191
# 9         classif.bartMachine   0.1588095238             1.6516
# 10             classif.avNNet   0.1638095238             0.1909

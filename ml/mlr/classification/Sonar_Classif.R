## Load packages
library(mlr)
library(purrr)
library(dplyr)
library(magrittr)
library(parallelMap)
library(forcats)

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

## List the learners


nlrns <- c("classif.bartMachine", "classif.boosting", "classif.extraTrees", "classif.xgboost")

lrns <- task %>% 
  listLearners %>% 
  filter(!class %in% nlrns) %>%
  use_series(class) %>% 
  map(makeLearner)

parallelStartMulticore(cpus = parallel::detectCores() - 1, level = "mlr.resample")

## Specify the resampling strategy (10-fold cross-validation)
rdesc <- makeResampleDesc("CV", iters = 10)

## Conduct the benchmark experiment
bmr <- benchmark(lrns, task, rdesc, measures = list(acc, timetrain))


parallelStop()

## Accessing benchmark results
bmr_res <- getBMRAggrPerformances(bmr)

## Print & Plot
tibble(learner = names(bmr_res$Sonar), 
       acc.test.mean = map_dbl(bmr_res$Sonar, "acc.test.mean"), 
       timetrain.test.mean = map_dbl(bmr_res$Sonar, "timetrain.test.mean")
) %>% 
  arrange(desc(acc.test.mean), timetrain.test.mean) %T>%
  print() %>%
  # filter(timeboth.test.mean < 5, mmce.test.mean < 0.3) %>%
  ggplot(aes(x = acc.test.mean, y = fct_rev(fct_inorder(learner)))) +
  geom_point() +
  xlim(0.7, 0.85) +
  guides(color = FALSE)

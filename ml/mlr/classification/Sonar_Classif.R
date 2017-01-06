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
lrns <- task %>%
  listLearners() %>% 
  filter(!package %in% c("h2o", "RWeka", "bartMachine")) %>%
  filter(!class %in% c("classif.bartMachine", "classif.boosting", "classif.extraTrees", "classif.xgboost")) %>%
  use_series(class) %T>% 
  print() %>%
  map(makeLearner)

## Resample 
rdesc <- makeResampleDesc("CV", iters = 10)

ptm1 <- proc.time()

## Start parallel
parallelStartMulticore(cpus = parallel::detectCores() - 1, level = "mlr.benchmark") # elapsed = 251.754
# user  system elapsed 
# 438.368  50.520 255.478 

# parallelStartMulticore(cpus = parallel::detectCores() - 1, level = "mlr.resample") # elapsed = 121.745 
# user  system elapsed 
# 901.396 232.264 121.745 



profvis({
## Conduct the benchmark experiment
bmr <- benchmark(lrns, task, rdesc, measures = list(acc, timetrain), keep.pred = FALSE, models = FALSE)
})



## Stop parallel
parallelStop()

ptm2 <- proc.time()
ptm2 - ptm1


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

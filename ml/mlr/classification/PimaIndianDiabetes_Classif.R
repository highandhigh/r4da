## Load packages
library(mlr)
library(purrr)
library(dplyr)
library(magrittr)
library(forcats)

## Load data
data(PimaIndiansDiabetes, package = "mlbench")

## Generate the task
task <- makeClassifTask(data = PimaIndiansDiabetes, target = "diabetes")

## Task Info
task
# Supervised task: PimaIndiansDiabetes
# Type: classif
# Target: diabetes
# Observations: 768
# Features:
#   numerics  factors  ordered 
# 8        0        0 
# Missings: FALSE
# Has weights: FALSE
# Has blocking: FALSE
# Classes: 2
# neg pos 
# 500 268 
# Positive class: neg

## Learners to be compared
lrns <- task %>% 
  listLearners %>% 
  filter(class != "classif.xgboost") %>% # Error
  filter(class != "classif.boosting") %>% # Too slow
  filter(class != "classif.dcSVM") %>% # Error
  filter(class != "classif.gaterSVM") %>% # Error
  filter(class != "classif.LiblineaRMultiClassSVC") %>% # Too slow
  filter(class != "classif.randomForestSRCSyn") %>% # Too slow
  filter(class != "classif.rknn") %>% # Error
  filter(class != "classif.neuralnet") %>% # Error
  filter(class != "classif.bartMachine") %>% # Error
  filter(class != "classif.extraTrees") %>% # Error
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
tibble(learner = names(bmr_res$PimaIndiansDiabetes), 
       acc.test.mean = map_dbl(bmr_res$PimaIndiansDiabetes, "acc.test.mean"), 
       timetrain.test.mean = map_dbl(bmr_res$PimaIndiansDiabetes, "timetrain.test.mean")) %>% 
  arrange(desc(acc.test.mean), timetrain.test.mean) %T>%
  print() %>%
  ggplot(aes(x = acc.test.mean, y = fct_rev(fct_inorder(learner)))) +
  geom_point() +
  scale_x_continuous(name = "Predictive accuracy", limits = c(0.5, 1)) +
  ylab("Classif learners") +
  labs(title = paste0(getTaskId(task), " ", getTaskType(task)), 
       subtitle = paste0(getTaskSize(task), " observations, ", 
                         getTaskNFeats(task), " features."))

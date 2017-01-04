## Load packages
library(mlr)
library(parallelMap)
library(purrr)
library(dplyr)
library(magrittr)
library(forcats)



# Car Evaluation Data Set 
# http://archive.ics.uci.edu/ml/datasets/Car+Evaluation
# | names file (C4.5 format) for car evaluation domain
# 
# | class values
# 
# unacc, acc, good, vgood
# 
# | attributes
# 
# buying:   vhigh, high, med, low.
# maint:    vhigh, high, med, low.
# doors:    2, 3, 4, 5-more.
# persons:  2, 4, more.
# lug_boot: small, med, big.
# safety:   low, med, high.


## Load data
car <- data.table::fread("http://archive.ics.uci.edu/ml/machine-learning-databases/car/car.data")
names(car) <- c("buying", "maint", "doors", "persons", "lug_boot", "safety", "class")

car$class <- factor(car$class, levels = c("unacc", "acc", "good", "vgood"), ordered = FALSE)
car$buying <- factor(car$buying, levels = c("vhigh", "high", "med", "low"), ordered = TRUE)
car$maint <- factor(car$maint, levels = c("vhigh", "high", "med", "low"), ordered = TRUE)
car$doors <- factor(car$doors, levels = c("2", "3", "4", "5more"), ordered = TRUE)
car$persons <- factor(car$persons, levels = c("2", "4", "more"), ordered = TRUE)
car$lug_boot <- factor(car$lug_boot, levels = c("small", "med", "big"), ordered = TRUE)
car$safety <- factor(car$safety, levels = c("low", "med", "high"), ordered = TRUE)

car <- as.data.frame(car)

str(car)

## Generate the task
task <- makeClassifTask(data = car, target = "class")

## Task Info
task
# Supervised task: car
# Type: classif
# Target: class
# Observations: 1728
# Features:
#   numerics  factors  ordered 
# 0        0        6 
# Missings: FALSE
# Has weights: FALSE
# Has blocking: FALSE
# Classes: 4
# unacc   acc  good vgood 
# 1210   384    69    65 
# Positive class: NA

## Learners to be compared
lrns <- task %>% 
  listLearners %>% 
  # filter(class != "classif.xgboost") %>% # Error
  # filter(class != "classif.boosting") %>% # Too slow
  # filter(class != "classif.dcSVM") %>% # Error
  # filter(class != "classif.gaterSVM") %>% # Error
  # filter(class != "classif.LiblineaRMultiClassSVC") %>% # Too slow
  # filter(class != "classif.randomForestSRCSyn") %>% # Too slow
  filter(class != "classif.rknn") %>% # Error
  # filter(class != "classif.neuralnet") %>% # Error
  # filter(class != "classif.bartMachine") %>% # Error
  # filter(class != "classif.extraTrees") %>% # Error
  # filter(class != "classif.cforest") %>% # Error
  # filter(class != "classif.ctree") %>% # Error
  # filter(class != "classif.randomForest") %>% # Error
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
tibble(learner = names(bmr_res$car), 
       acc.test.mean = map_dbl(bmr_res$car, "acc.test.mean"), 
       timetrain.test.mean = map_dbl(bmr_res$car, "timetrain.test.mean")) %>% 
  arrange(desc(acc.test.mean), timetrain.test.mean) %T>%
  print() %>%
  ggplot(aes(x = acc.test.mean, y = fct_rev(fct_inorder(learner)))) +
  geom_point() +
  scale_x_continuous(name = "Predictive accuracy", limits = c(0.5, 1)) +
  ylab("Classif learners") +
  labs(title = paste0(getTaskId(task), " ", getTaskType(task)), 
       subtitle = paste0(getTaskSize(task), " observations, ", 
                         getTaskNFeats(task), " features."))

library(mlr)

## Generate the task
task <- makeClassifTask(data = iris, target = "Species")

## Generate the learner
learner <- makeLearner("classif.naiveBayes")

## Train the learner
n <- task$task.desc$size

set.seed(n)

train.index <- sample(n, size = n %/% 2)

test.index <- seq(1, n)[-train.index]

task.model <- train(learner = learner, task = task, subset = train.index)

print(task.model)

task.pred <- predict(task.model, task = task, subset = test.index)

getConfMatrix(task.pred)

# predicted
# true         setosa versicolor virginica -SUM-
#   setosa         28          0         0     0
# versicolor      0         25         0     0
# virginica       0          3        19     3
# -SUM-           0          3         0     3

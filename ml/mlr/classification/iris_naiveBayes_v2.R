library(mlr)

## Generate the task
task <- makeClassifTask(data = iris, target = "Species")

## Generate the learner
lrn <- makeLearner("classif.naiveBayes")

## Train the learner
n <- task$task.desc$size

set.seed(n)

train.set <- sample(n, size = floor(n * 0.75))

test.set <- seq(1, n)[-train.set]

mod <- train(learner = lrn, task = task, subset = train.set)

print(task.model)

# Predicting Outcomes for New Data
pred <- predict(mod, task = task, subset = test.set)

# Evaluating Learner Performance
performance(pred, measures = list(mmce, timeboth), model = mod)


getConfMatrix(pred)

# predicted
# true         setosa versicolor virginica -SUM-
#   setosa         13          0         0     0
# versicolor      0         14         1     1
# virginica       0          0        10     0
# -SUM-           0          0         1     1

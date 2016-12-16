library(tidyverse)


breast_cancer <- read_csv(file = 'http://archive.ics.uci.edu/ml/machine-learning-databases/breast-cancer-wisconsin/breast-cancer-wisconsin.data', col_names = FALSE)

df <- breast_cancer %>%
  set_names(nm= c("sampleNo", "clumpThickness", "sizeUniformity", "shapeUniformity", "marginalAdhesion",
                           "singleEpithelialCellSize", "bareNuclei", "blandChromatin", "normalNucleoli", "mitosis", "class")) %>%
  select(-sampleNo)

# class (2 for benign 良性 , 4 for malignant 恶性)


library("caret")

df$class <- as.factor(df$class)

idx.train <- createDataPartition(df$class, p = 0.7, list = FALSE)

df.train <- df[idx.train,]
df.validate <- df[-idx.train,]

# 逻辑回归

lr.model <- glm(class~., data = df.train, family = binomial())

summary(lr.model)

# 用逐步回归方法，更新模型，并利用模型对验证集进行预测。

lr.model.reduced <- step(lr.model)

prob <- predict(lr.model.reduced, df.validate, type = "response")

lr.model.pred <- factor(prob > .5, levels = c(FALSE, TRUE), labels = c("benign", "malignant"))

lr.model.perf <- table(df.validate$class, lr.model.pred, dnn = c("Actual", "Predicted"))

print(lr.model.perf)

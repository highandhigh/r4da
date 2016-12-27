multiclass_learners <- paste0("classif.", c(
  #### Discriminant Analysis 判别分析 ####
  "lda", "linDA", # Linear Discriminant Analysis
  "qda", "quaDA",  # Quadratic Discriminant Analysis
  "mda", # Mixture Discriminant Analysis
  "rda", # Regularized Discriminant Analysis
  "sda", # Shrinkage Discriminant Analysis
  "sparseLDA", # Sparse Discriminant Analysis
  "rrlda", # Robust Regularized Linear Discriminant Analysis
  "geoDA", # Geometric Predictive Discriminant Analysis

  ##### Random Forest 随机森林 ####
  "randomForest", "randomForestSRC", "ranger", # Random Forest
  "randomForestSRCSyn", # Synthetic Random Forest
  # "RRF", # Regularized Random Forests ## S3 method 'makeRLearner.classif.RRF' not found
  "cforest", # Random forest based on conditional inference trees
  
  #### Decision Tree 决策树 ####
  "rpart", # Decision Tree
  # "C50", # C50 ## S3 method 'makeRLearner.classif.C50' not found
  "ctree", # Conditional Inference Trees
  "extraTrees", # Extremely Randomized Trees
  
  #### Naive Bayes 朴素贝叶斯 ####
  "naiveBayes", # Naive Bayes
  
  #### k-Nearest Neighbor K最近邻 ####
  "knn", "kknn", # k-Nearest Neighbor
  "rknn", # Random k-Nearest-Neighbors
  
  #### Support Vector Machines 支持向量机 ####
  "svm", "ksvm", # Support Vector Machines
  "lssvm", # Least Squares Support Vector Machine
  
  #### Boosting ####
  "boosting", # Adabag Boosting
  "xgboost", # eXtreme Gradient Boosting
  "gbm", # Gradient Boosting Machine
  
  #### Conditional Inference Trees ####
  "ctree", # Conditional Inference Trees
  "cforest", # Random forest based on conditional inference trees
  
  #### Neural Network ####
  "nnet", "avNNet", # Neural Network
  "nnTrain", # Training Neural Network by Backpropagation
  #### Deep Neural Network ####
  "saeDNN", #Deep neural network with weights initialized by Stacked AutoEncoder
  "dbnDNN", # Deep neural network with weights initialized by DBN
  
  #### Others ####
  "cvglmnet", # GLM with Lasso or Elasticnet Regularization (Cross Validated Lambda)
  "glmnet", # GLM with Lasso or Elasticnet Regularization
  # "gausspr", # Gaussian Processes ## S3 method 'makeRLearner.classif.gausspr' not found
  "mlp", # Multi-Layer Perceptron
  "rFerns", # Random ferns
  "xyf", # X-Y fused self-organising maps
  "bdk", # Bi-Directional Kohonen map
  "multinom" # Multinomial Regression
)
)


twoclass_learners <- paste0("classif.",c(
  "ada", # ada Boosting
  "bartMachine", # Bayesian Additive Regression Trees
  "binomial", # Binomial Regression
  "bst", # Gradient Boosting
  "clusterSVM", # Clustered Support Vector Machines
  "dcSVM", # Divided-Conquer Support Vector Machines
  "gaterSVM", # Mixture of SVMs with Neural Network Gater Function
  "glmboost", # Boosting for GLMs
  "hdrda", # High-Dimensional Regularized Discriminant Analysis
  "lqa", # Fitting penalized Generalized Linear Models with the LQA algorithm
  "neuralnet", # Neural Network from neuralnet
  "nodeHarvest", # Node Harvest
  "pamr", # Nearest shrunken centroid
  # "penalized.fusedlasso", # Logistic Fused Lasso Regression ## S3 method 'makeRLearner.classif.penalized.fusedlasso' not found
  # "penalized.lasso", # Logistic Lasso Regression ## S3 method 'makeRLearner.classif.penalized.fusedlasso' not found
  # "penalized.ridge", # Logistic Ridge Regression ## S3 method 'makeRLearner.classif.penalized.fusedlasso' not found
  "plr", # Logistic Regression with a L2 Penalty
  "plsdaCaret", # Partial Least Squares (PLS) Discriminant Analysis
  "probit", # Probit Regression
  "rotationForest" # Rotation Forest
)
)

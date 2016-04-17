#------------ allgemein ------------#
seed <- 1234
k.fold <- 5
wd <- "H:/Kaggle_raw/santander/Pipeline/cache"
folder <- "groups ranger"
dir.create(file.path(wd, folder), showWarnings = FALSE)
#------------ allgemein ------------#




#------------ xgboost --------------#

param <- list(  objective           = "binary:logistic", 
                 booster             = "gbtree",
                 eval_metric         = "auc",
                 eta                 = 0.1,
                 max_depth           = 4,
                 subsample           = 0.8,
                 colsample_bytree    = 0.9
)
rounds = 50

param1 <- list(  objective           = "binary:logistic", 
                 booster             = "gbtree",
                 eval_metric         = "auc",
                 eta                 = 0.0202048,
                 max_depth           = 5,
                 subsample           = 0.6815,
                 colsample_bytree    = 0.701
)
rounds = 560

param2 <- list(  objective           = "binary:logistic", 
                booster             = "gbtree",
                eval_metric         = "auc",
                eta                 = 0.0201,
                max_depth           = 5,
                lambda              = 0.9,
                subsample           = 0.6815,
                colsample_bytree    = 0.7
) # nrounds = 577 | 572

param3 <- list(  objective           = "binary:logistic", 
                booster             = "gbtree",
                eval_metric         = "auc",
                eta                 = 0.02009,
                max_depth           = 5,
                subsample           = 0.68155,
                colsample_bytree    = 0.7
) # nrounds = 572

param4 <- list(  objective           = "binary:logistic", 
                booster             = "gbtree",
                eval_metric         = "auc",
                eta                 = 0.0203,
                max_depth           = 5,
                subsample           = 0.683,
                colsample_bytree    = 0.7
) # nrounds = 574

param.forest <- list(  objective           = "binary:logistic", 
                booster             = "gbtree",
                eval_metric         = "auc",
                eta                 = 0.0201,
                max_depth           = 5,
                subsample           = 0.6815,
                colsample_bytree    = 0.7
)


#------------ xgboost --------------#




#------------- ranger --------------#
ranger.mtry <- 25
ranger19.mtry <- 4
ranger.ntree <- 250
#------------- ranger --------------#




#--------------- et ----------------#
et.mtry <- 21
et19.mtry <- 5
et.ntree <- 50
#--------------- et ----------------#


#--------------- kknn --------------#
# c("rectangular", "triangular", "epanechnikov",
#   "gaussian", "rank", "optimal")
kern = "rectangular"
n.k = 125
#--------------- kknn --------------#
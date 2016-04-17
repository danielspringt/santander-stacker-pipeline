source("./param/param.R")
source("./data/prepare_data.R")

param = param1
rounds = 572
param.name <- "param1"
source("./crossvalidater/xgboost_raw.R")
source("./crossvalidater/xgboost_clean.R")
source("./crossvalidater/xgboost_pseudolog.R")
source("./crossvalidater/xgboost_19.R")

param = param2
rounds = 577 
param.name <- "param2"
source("./crossvalidater/xgboost_raw.R")
source("./crossvalidater/xgboost_clean.R")
source("./crossvalidater/xgboost_pseudolog.R")
source("./crossvalidater/xgboost_19.R")

param = param2
rounds = 572
param.name <- "param2"
source("./crossvalidater/xgboost_raw.R")
source("./crossvalidater/xgboost_clean.R")
source("./crossvalidater/xgboost_pseudolog.R")
source("./crossvalidater/xgboost_19.R")

param = param3
rounds = 572
param.name <- "param3"
source("./crossvalidater/xgboost_raw.R")
source("./crossvalidater/xgboost_clean.R")
source("./crossvalidater/xgboost_pseudolog.R")
source("./crossvalidater/xgboost_19.R")

param = param4
rounds = 574
param.name <- "param4"
source("./crossvalidater/xgboost_raw.R")
source("./crossvalidater/xgboost_clean.R")
source("./crossvalidater/xgboost_pseudolog.R")
source("./crossvalidater/xgboost_19.R")


source("./crossvalidater/et_raw.R")
source("./crossvalidater/et_clean.R")
source("./crossvalidater/et_pseudolog.R")
source("./crossvalidater/et_19.R")

source("./crossvalidater/ranger_raw.R")
source("./crossvalidater/ranger_clean.R")
source("./crossvalidater/ranger_pseudolog.R")
source("./crossvalidater/ranger_19.R")
source("./crossvalidater/knn_pseudolog.R")




library(dplyr)
library(Matrix)
library(xgboost)
library(Rtsne)
setwd("H:/Kaggle_raw/santander/Pipeline")
#------------ load csv  --------------#
options(stringsAsFactors = FALSE)

train.csv <- read.csv("data/train.csv")
test.csv <- read.csv("data/test.csv")
test.tsne <- readRDS("data/tsneTest.RDATA")
train.tsne <- readRDS("data/tsneTrain.RDATA")
feature.5.pairs.I <- read.csv("data/feature_groups.csv")
feature.5.pairs.I$X <- NULL
feature.5.pairs.II <- read.csv("data/feature_groupsII.csv")
feature.5.pairs.II$X <- NULL
feature.5.pairs <- rbind(feature.5.pairs.I[1:15,],
                         feature.5.pairs.II[1:15,])
feature.5.pairs <- arrange(feature.5.pairs, desc(combinedAUC))
feature.5.pairs$combinedAUC <- NULL
#------------ load csv ---------------#


#------------- raw set ---------------#
train.raw <- train.csv
train.raw.id <- train.raw$ID

train.raw.y <- train.raw$TARGET
train.raw.y.factor <- as.factor(train.raw.y)
levels(train.raw.y.factor) <- c("null","eins")

train.raw$TARGET <- NULL
train.raw$ID <- NULL

test.raw <- test.csv
test.raw.id <- test.raw$ID
test.raw$ID <- NULL

dtrain.raw <- xgb.DMatrix(data=as.matrix(train.raw),label=train.raw.y)
dtest.raw <- xgb.DMatrix(data=as.matrix(test.raw))
#------------- raw set ---------------#

# group.1 <- as.character(feature.5.pairs[1,]); group.1.train <- train.tsne[group.1]; group.1.test <- test.tsne[group.1] 
# group.2 <- as.character(feature.5.pairs[2,]); group.2.train <- train.tsne[group.2]; group.2.test <- test.tsne[group.2] 
# group.3 <- as.character(feature.5.pairs[3,]); group.3.train <- train.tsne[group.3]; group.3.test <- test.tsne[group.3] 
# group.4 <- as.character(feature.5.pairs[4,]); group.4.train <- train.tsne[group.4]; group.4.test <- test.tsne[group.4] 
# group.5 <- as.character(feature.5.pairs[5,]); group.5.train <- train.tsne[group.5]; group.5.test <- test.tsne[group.5] 
# group.6 <- as.character(feature.5.pairs[6,]); group.6.train <- train.tsne[group.6]; group.6.test <- test.tsne[group.6] 
# group.7 <- as.character(feature.5.pairs[7,]); group.7.train <- train.tsne[group.7]; group.7.test <- test.tsne[group.7] 
# group.8 <- as.character(feature.5.pairs[8,]); group.8.train <- train.tsne[group.8]; group.8.test <- test.tsne[group.8] 
# group.9 <- as.character(feature.5.pairs[9,]); group.9.train <- train.tsne[group.9]; group.9.test <- test.tsne[group.9] 
# group.10 <- as.character(feature.5.pairs[10,]); group.10.train <- train.tsne[group.10]; group.10.test <- test.tsne[group.10] 
# group.11 <- as.character(feature.5.pairs[11,]); group.11.train <- train.tsne[group.11]; group.11.test <- test.tsne[group.11] 
# group.12 <- as.character(feature.5.pairs[12,]); group.12.train <- train.tsne[group.12]; group.12.test <- test.tsne[group.12] 
# group.13 <- as.character(feature.5.pairs[13,]); group.13.train <- train.tsne[group.13]; group.13.test <- test.tsne[group.13] 
# group.14 <- as.character(feature.5.pairs[14,]); group.14.train <- train.tsne[group.14]; group.14.test <- test.tsne[group.14] 
# group.15 <- as.character(feature.5.pairs[15,]); group.15.train <- train.tsne[group.15]; group.15.test <- test.tsne[group.15] 
# 
# group.16 <- as.character(feature.5.pairs[16,]); group.16.train <- train.tsne[group.16]; group.16.test <- test.tsne[group.16] 
# group.17 <- as.character(feature.5.pairs[17,]); group.17.train <- train.tsne[group.17]; group.17.test <- test.tsne[group.17] 
# group.18 <- as.character(feature.5.pairs[18,]); group.18.train <- train.tsne[group.18]; group.18.test <- test.tsne[group.18] 
# group.19 <- as.character(feature.5.pairs[19,]); group.19.train <- train.tsne[group.19]; group.19.test <- test.tsne[group.19] 
# group.20 <- as.character(feature.5.pairs[20,]); group.20.train <- train.tsne[group.20]; group.20.test <- test.tsne[group.20] 
# group.21 <- as.character(feature.5.pairs[21,]); group.21.train <- train.tsne[group.21]; group.21.test <- test.tsne[group.21] 
# group.22 <- as.character(feature.5.pairs[22,]); group.22.train <- train.tsne[group.22]; group.22.test <- test.tsne[group.22] 
# group.23 <- as.character(feature.5.pairs[23,]); group.23.train <- train.tsne[group.23]; group.23.test <- test.tsne[group.23] 
# group.24 <- as.character(feature.5.pairs[24,]); group.24.train <- train.tsne[group.24]; group.24.test <- test.tsne[group.24] 
# group.25 <- as.character(feature.5.pairs[25,]); group.25.train <- train.tsne[group.25]; group.25.test <- test.tsne[group.25] 
# group.26 <- as.character(feature.5.pairs[26,]); group.26.train <- train.tsne[group.26]; group.26.test <- test.tsne[group.26] 
# group.27 <- as.character(feature.5.pairs[27,]); group.27.train <- train.tsne[group.27]; group.27.test <- test.tsne[group.27] 
# group.28 <- as.character(feature.5.pairs[28,]); group.28.train <- train.tsne[group.28]; group.28.test <- test.tsne[group.28] 
# group.29 <- as.character(feature.5.pairs[29,]); group.29.train <- train.tsne[group.29]; group.29.test <- test.tsne[group.29] 
# group.30 <- as.character(feature.5.pairs[30,]); group.30.train <- train.tsne[group.30]; group.30.test <- test.tsne[group.30] 
# 
# setwd("H:/Kaggle_raw/santander/Pipeline/data/groups/")
# for(q in 1:30){
#   file.tr <- paste0("group.",q,".train")
#   file.te <- paste0("group.",q,".test")
#   name.tr <- paste0("group.",q,".train.csv")
#   name.te <- paste0("group.",q,".test.csv")
#   write.csv(get(file.tr), file = name.tr, row.names = FALSE)
#   write.csv(get(file.te), file = name.te, row.names = FALSE)
# }
#-------------- 5 Feat ---------------#




#-------------- 5 Feat ---------------#




#------------ clean set --------------#
train.clean <- train.raw
test.clean <- test.raw
##### 0 count per line
count0 <- function(x) {
  return( sum(x == 0) )
}
train.clean$n0 <- apply(train.clean, 1, FUN=count0)
test.clean$n0 <- apply(test.clean, 1, FUN=count0)

##### Removing constant features
for (f in names(train.clean)) {
  if (length(unique(train.clean[[f]])) == 1) {
    train.clean[[f]] <- NULL
    test.clean[[f]] <- NULL
  }
}
##### Removing identical features
features_pair <- combn(names(train.clean), 2, simplify = F)
toRemove <- c()
for(pair in features_pair) {
  f1 <- pair[1]
  f2 <- pair[2]
  
  if (!(f1 %in% toRemove) & !(f2 %in% toRemove)) {
    if (all(train.clean[[f1]] == train.clean[[f2]])) {
      cat(f1, "and", f2, "are equals.\n")
      toRemove <- c(toRemove, f2)
    }
  }
}

feature.names <- setdiff(names(train.clean), toRemove)

train.clean <- train.clean[, feature.names]
test.clean <- test.clean[, feature.names]

dtrain.clean <- xgb.DMatrix(data=as.matrix(train.clean), label = train.raw.y)
dtest.clean <- xgb.DMatrix(data=as.matrix(test.clean))
#------------ clean set --------------#


to.keep <- c('num_var39_0',  # 0.00031104199066874026
'ind_var13',  # 0.00031104199066874026
'num_op_var41_comer_ult3',  # 0.00031104199066874026
'num_var43_recib_ult1',  # 0.00031104199066874026
'imp_op_var41_comer_ult3',  # 0.00031104199066874026
'num_var8',  # 0.00031104199066874026
'num_var42',  # 0.00031104199066874026
'num_var30',  # 0.00031104199066874026
'saldo_var8',  # 0.00031104199066874026
'num_op_var39_efect_ult3',  # 0.00031104199066874026
'num_op_var39_comer_ult3',  # 0.00031104199066874026
'num_var41_0',  # 0.0006220839813374805
'num_op_var39_ult3',  # 0.0006220839813374805
'saldo_var13',  # 0.0009331259720062209
'num_var30_0',  # 0.0009331259720062209
'ind_var37_cte',  # 0.0009331259720062209
'ind_var39_0',  # 0.001244167962674961
'num_var5',  # 0.0015552099533437014
'ind_var10_ult1',  # 0.0015552099533437014
'num_op_var39_hace2',  # 0.0018662519440124418
'num_var22_hace2',  # 0.0018662519440124418
'num_var35',  # 0.0018662519440124418
'ind_var30',  # 0.0018662519440124418
'num_med_var22_ult3',  # 0.002177293934681182
'imp_op_var41_efect_ult1',  # 0.002488335925349922
'var36',  # 0.0027993779160186624
'num_med_var45_ult3',  # 0.003110419906687403
'imp_op_var39_ult1',  # 0.0037325038880248835
'imp_op_var39_comer_ult3',  # 0.0037325038880248835
'imp_trans_var37_ult1',  # 0.004043545878693624
'num_var5_0',  # 0.004043545878693624
'num_var45_ult1',  # 0.004665629860031105
'ind_var41_0',  # 0.0052877138413685845
'imp_op_var41_ult1',  # 0.0052877138413685845
'num_var8_0',  # 0.005598755832037325
'imp_op_var41_efect_ult3',  # 0.007153965785381027
'num_op_var41_ult3',  # 0.007153965785381027
'num_var22_hace3',  # 0.008087091757387248
'num_var4',  # 0.008087091757387248
'imp_op_var39_comer_ult1',  # 0.008398133748055987
'num_var45_ult3',  # 0.008709175738724729
'ind_var5',  # 0.009953343701399688
'imp_op_var39_efect_ult3',  # 0.009953343701399688
'num_meses_var5_ult3',  # 0.009953343701399688
'saldo_var42',  # 0.01181959564541213
'imp_op_var39_efect_ult1',  # 0.013374805598755831
'PCATwo',  # 0.013996889580093312
'num_var45_hace2',  # 0.014618973561430793
'num_var22_ult1',  # 0.017107309486780714
'saldo_medio_var5_ult1',  # 0.017418351477449457
'PCAOne',  # 0.018040435458786936
'saldo_var5',  # 0.0208398133748056
'ind_var8_0',  # 0.021150855365474338
'ind_var5_0',  # 0.02177293934681182
'num_meses_var39_vig_ult3',  # 0.024572317262830483
'saldo_medio_var5_ult3',  # 0.024883359253499222
'num_var45_hace3',  # 0.026749611197511663
'num_var22_ult3',  # 0.03452566096423017
'saldo_medio_var5_hace3',  # 0.04074650077760498
'saldo_medio_var5_hace2',  # 0.04292379471228616
'SumZeros',  # 0.04696734059097978
'saldo_var30',  # 0.09611197511664074
'var38',  # 0.1390357698289269
'var15')  # 0.20964230171073095




#-------------- log set ---------------#
# pseudoLog10 <- function(x) { asinh(x/2)/log(10) }
# 
# train.log <- pseudoLog10(train.raw[,1:ncol(train.raw)])
# test.log <- pseudoLog10(test.raw[,1:ncol(test.raw)])
# 
# dtrain.log <- xgb.DMatrix(data=as.matrix(train.log), label = train.raw.y)
# dtest.log <- xgb.DMatrix(data=as.matrix(test.log))
#-------------- log set ---------------#



#-------------- 19 Feat ---------------#
# nineteenfeatures = c('imp_ent_var16_ult1',
#                     'var38',
#                     'ind_var30',
#                     'delta_imp_aport_var13_1y3',
#                     'saldo_medio_var13_corto_hace2',
#                     'num_op_var39_hace3',
#                     'imp_var43_emit_ult1',
#                     'num_meses_var5_ult3',
#                     'delta_num_aport_var13_1y3',
#                     'num_var42_0',
#                     'imp_op_var40_ult1',
#                     'num_var22_ult1',
#                     'saldo_var5',
#                     'num_op_var40_ult1',
#                     'imp_aport_var13_ult1',
#                     'saldo_var42', 'ind_var39_0',
#                     'num_aport_var13_ult1',
#                     'var15')
# train.19 <- train.raw[,nineteenfeatures]
# test.19 <- test.raw[,nineteenfeatures]
# 
# dtrain.19 <- xgb.DMatrix(as.matrix(train.19),label=train.raw.y)
# dtest.19 <- xgb.DMatrix(as.matrix(test.19))
#-------------- 19 Feat ---------------#


#-------------- 100 Feat --------------#
# top100<-readRDS("./data/top100predictor.RDATA")
# top100 <- names(top100)
# 
# train.100 <- train.raw[,top100]
# test.100 <- test.raw[,top100]
# 
# dtrain.100 <- xgb.DMatrix(as.matrix(train.100),label=train.raw.y)
# dtest.100 <- xgb.DMatrix(as.matrix(test.100))
#-------------- 100 Feat --------------#


#-------------- 100 log ---------------#
# train.100.log <- pseudoLog10(train.100[,1:ncol(train.100)])
# test.100.log <- pseudoLog10(test.100[,1:ncol(test.100)])
#-------------- 100 log ---------------#





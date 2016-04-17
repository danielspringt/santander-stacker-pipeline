library(dplyr)
library(caret)
library(xgboost)
library(verification)
library(kknn)


auc_function <- function (actual, predicted) {
  
  r <- as.numeric(rank(predicted))
  
  n_pos <- as.numeric(sum(actual == 1))
  n_neg <- as.numeric(length(actual) - n_pos)
  auc <- (sum(r[actual == 1]) - n_pos * (n_pos + 1)/2)/(n_pos *  n_neg)
  auc
}   




#source("../param/param.R")
#source("../data/prepare_data.R")
set.seed(seed)
final <- list()
for(ii in 1:30){
  print(ii)
  #train.ii <- get("group.",ii,".train")
  #test.ii <- get("group.",ii,".test")
  train.ii <- read.csv(paste0("H:/Kaggle_raw/santander/Pipeline/data/groups/","group.",ii,".train.csv"))
  test.ii <- read.csv(paste0("H:/Kaggle_raw/santander/Pipeline/data/groups/","group.",ii,".test.csv"))
  flds <- createFolds(train.raw.y, k = k.fold)
  info <- list()
  
  
  model.name <- paste0("knn_5_group","kernel_",kern,"_k",n.k)
  print(paste("#--------------",model.name,"--------------#"))
  for(i in 1:length(flds)){
    #------ split in train und test ------#
    test.index <- flds[[i]]
    train.index <- unlist(flds[-i])
    names(train.index) <- NULL
    #------ split in train und test ------#
    
    
    cv.train <- train.ii[train.index,] ### anpassen
    cv.test <- train.ii[test.index,]   ### anpassen
    
    cv.train.y <- train.raw.y[train.index]
    cv.test.y <- train.raw.y[test.index]

    cv.train$TARGET <- cv.train.y
    #------------- Training cv--------------#
    (train.con <- train.kknn(TARGET ~.,
                             data=cv.train,
                             kmax = n.k, 
                             kernel = kern,
                             prob=TRUE
    ))
    
    Pred <- predict(train.con,cv.test)
    
    
    result <- roc.area(cv.test.y, Pred)$A
    print(paste("___ AUC =", result))
    #------------- Training cv--------------#
    
    
    #------------- Training test------------#
    test <- test.ii
    Pred.test <- predict(train.con, test) ### anpassen
    
    #------------- Training test------------#
    
    
    #-------- speichere fold info --------#
    fold_info <- list()
    fold_info[["fold"]] <- i
    fold_info[["seed"]] <- seed
    fold_info[["test.index"]] <- test.index
    fold_info[["train.index"]] <- train.index
    fold_info[["AUC"]] <- result
    fold_info[["prediction.cv"]] <- Pred
    fold_info[["prediction.test"]] <- Pred.test
    info[[i]] <- fold_info
    #-------- speichere fold info --------#
  }
  
  Predictions <- unlist(lapply(info, `[`, "prediction.cv"))
  index <- unlist(lapply(info, `[`, "test.index"))
  auc <- unlist(lapply(info, `[`, "AUC"))
  auc <- mean(auc)
  train.df <- data_frame(index=index, cv.pred=Predictions)
  train.df <- arrange(train.df, index)
  
  mean.df <- data.frame(matrix(NA,nrow=(nrow(test.raw))))
  for(p in 1:length(info)){
    Predictions2 <-info[[p]]$prediction.test
    mean.df <- cbind(mean.df, Predictions2)
  }
  mean.df[,1]<-NULL
  mean.df$mean <- rowMeans(mean.df)
  
  #mean auc
  result <- list()
  result[["model"]] <- model.name
  result[["seed"]]<-seed
  result[["AUC"]]<- auc
  result[["cv.train"]]<-train.df$cv.pred
  result[["test"]]<-mean.df$mean
  result[["param"]]<-param
  final[[ii]] <- result
  print(paste(model.name, "___", auc))
}


saveRDS(final, paste0("./cache/",folder,"/","knn_30grp_","kernel_",kern,"_k",n.k,".RData"))

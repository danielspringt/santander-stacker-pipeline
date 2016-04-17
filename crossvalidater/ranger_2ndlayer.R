library(dplyr)
library(caret)
library(ranger)
library(verification)


#source("../param/param.R")
#source("../data/prepare_data.R")
set.seed(seed)

flds <- createFolds(train.raw.y, k = k.fold)
info <- list()
model.name <- paste0("ranger_2ndlayer_5F_","mtry",ranger19.mtry,"_ntree",ranger.ntree)
print(paste("#--------------",model.name,"--------------#"))
for(i in 1:length(flds)){
  #------ split in train und test ------#
  test.index <- flds[[i]]
  train.index <- unlist(flds[-i])
  names(train.index) <- NULL
  #------ split in train und test ------#
  
  
  cv.train <- model.train.5[train.index,] ### anpassen
  cv.test <- model.train.5[test.index,]   ### anpassen
  
  cv.train.y <- train.raw.y.factor[train.index]
  cv.test.y <- train.raw.y[test.index]
  
  cv.train$TARGET <- cv.train.y
  #------------- Training cv--------------#
  forest.cv <- ranger(TARGET ~ ., data = cv.train, 
                      num.trees = ranger.ntree, 
                      mtry = 6,       
                      importance = "impurity",
                      write.forest = TRUE,
                      verbose=TRUE,
                      probability = TRUE,   
                      save.memory = FALSE)
  
  
  Pred <- predict(forest.cv, cv.test, probability=TRUE)
  Pred <- Pred$predictions[,2]
  result <- roc.area(cv.test.y, Pred)$A
  print(paste("___ AUC =", result))
  #------------- Training cv--------------#
  
  
  #------------- Training test------------#
  Pred.test <- predict(forest.cv, model.test.5) ### anpassen
  Pred.test <- Pred.test$predictions[,2]
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
result[["seed"]]<-seed
result[["AUC"]]<- auc
result[["cv.train"]]<-train.df$cv.pred
result[["test"]]<-mean.df$mean
saveRDS(result, paste0("./cache/",folder,"/",model.name,"_",auc,".RData"))

print(paste(model.name, "___", auc))


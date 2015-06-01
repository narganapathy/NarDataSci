sf <- function() {
	library("rpart")
	library("randomForest")
	library("e1071")
	seaflow_full <- read.csv("seaflow_21min.csv")
	seaflow_filter <- (seaflow_full$file_id != 208)
	seaflow <- seaflow_full[seaflow_filter,]
	set.seed(12345)
      sf_size <- nrow(seaflow)
	sf_rand <- seaflow[order(runif(sf_size)), ]
	sf_train_size <- (0.50*sf_size)
	sf_train <- sf_rand[1:sf_train_size,]
	print(nrow(sf_train));
      
      sf_test <- sf_rand[sf_train_size:sf_size,]
	print(nrow(sf_test));
	
	mean(sf_train$time)
	fol <- (pop ~ fsc_small + fsc_perp + fsc_big + pe + chl_big + chl_small)
	model <- rpart(fol, method="class", data=sf_train)
	sf_pred <- predict(model, sf_test, type="vector")
      sf_pop_factor <- as.numeric(factor(sf_test$pop))
	sf_eval <- (sf_pred == sf_pop_factor)
	accuracy <- sum(sf_eval)/length(sf_eval)
	print(sum(sf_eval))
      print(length(sf_eval))
      print(accuracy)
      rf_model <- randomForest(fol, data=sf_train)
      rf_pred <- predict( rf_model, sf_test, type="response")
      print(importance(rf_model))
      svm_model <- svm(fol, data=sf_train)
      svm_pred <- predict( svm_model, sf_test, type="response")
      print(table(pred = sf_pred, true=sf_test$pop))
      print(table(pred = rf_pred, true=sf_test$pop))
      print(table(pred = svm_pred, true=sf_test$pop))
}

## qplot(seaflow$pe, seaflow$chl_small, colour=seaflow$pop) used for plotting

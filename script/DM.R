library(data.table)

userTrain = as.data.frame(fread("~/DataMining/Airbnb/train_users_2.csv"))
View(userTrain)
userTest = as.data.frame(fread("~/DataMining/Airbnb/test_users.csv"))
#add a empty column 
userTest = data.frame(userTest, "country_destination"= rep('',nrow(userTest)))
View(userTest)

#nrow of Training and Testing 
nrow(userTrain)
nrow(userTest)


#merge Traning and  testing data
userTotal = rbind(userTrain,userTest)
View(userTotal)
nrow(userTotal)

#Missing data 

#gender 
userTotal[which(userTotal$gender == "-unknown-"),"gender"] = NaN

#remove id and date_first_booking 
userTotal = userTotal[,c(-1,-4)]

#odd age range
summary(userTotal$age)
userTotal[which(userTotal$age > 120),"age"] = NaN
userTotal[which(userTotal$age < 13),"age"] = NaN
summary(userTotal$age)


#userTotal = lapply(userTotal , factor)

userTrain = userTotal[1:213451,]
userTest = userTotal[213452:nrow(userTotal),] 

userTrain = userTrain[,c(-1,-2)]
userTest = userTest[,c(-1,-2)]

# it will cause a crash
rpart(formula = country_destination ~. , userTrain )

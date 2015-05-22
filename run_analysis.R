##loading nessecary lybraries
library(data.table)

##reading 6 data files from working directory

path <- file.path(getwd(), "UCI HAR Dataset")
setwd(path)

subject_train <- fread(file.path(getwd(), "train", "subject_train.txt"))
subject_test <- fread(file.path(getwd(), "test", "subject_test.txt"))
y_train <- fread(file.path(getwd(), "train", "Y_train.txt"))
y_test <- fread(file.path(getwd(), "test", "Y_test.txt"))
x_train <- read.table(file.path(getwd(), "train", "X_train.txt"))
x_test <- read.table(file.path(getwd(), "test", "X_test.txt"))

##reading features description file
features <- fread(file.path(getwd(), "features.txt"))

##merging 3 corresponding test and training data sets
subject<-rbind(subject_train,subject_test)
x<-rbind(x_train,x_test)
y<-rbind(y_train,y_test)

setnames(y,"V1","activity_n")
setnames(subject,"V1","subject")

##merging 3 tables: x,y and subject
data<-cbind(subject,y)
data<-cbind(data,x)

##definig only mean and standrt devation values in features file
features_needed<-grepl("mean|std",features$V2)
##subsetting features of mean and std values only
features<-features[features_needed,]

##adding "V" to the number of features left to match it with column names in table "data"
features$V1<-paste0("V",features$V1)

##subsetting "data" table for needed columns
setkey(data,subject,activity_n)
data<-data[,c(key(data),features$V1), with=F]

## reading activities lables
activity_labels <- fread(file.path(getwd(), "activity_labels.txt"))
setnames(activity_labels,c("V1","V2"),c("activity_n","activity_name"))
## descripting activities with its names in the data table
data <- merge(data, activity_labels, by="activity_n", all.x=TRUE)
##naming variables in columns
setnames(data,names(data),c("activity_n","subject",features$V2,"activity_name"))

## reshaping data for further calculations
library(reshape2)
data_melt<-melt(data,id=c("activity_n","subject","activity_name"),measure.vars=features$V2)

## calculating average for all combinations of variables, subjects and activities
tidy<-data_melt[,list(average = mean(value)), by=key(data_melt)]
library(dplyr)
setwd("C:/Users/dhan/Desktop/R course/Course 3_cleaning/wk4/UCI HAR Dataset")


## Read in training data
train.y <- read.table("train/y_train.txt")
train.x <- read.table("train/X_train.txt")
train.sj <- read.table("train/subject_train.txt")


## Read in test data
test.y <- read.table("test/y_test.txt")
test.x <- read.table("test/X_test.txt")
test.sj <- read.table("test/subject_test.txt")


## Read in features and select columns for mean and standard deviation only
feat <- read.table("features.txt")
feat.use <- grep("-std\\(\\)|-mean\\(\\)", feat$V2)

## Clean up the feature name (remove the parenthesis and replace '-' with '_') for use as variable names
feat$V2 <- gsub("\\(|\\)", "", feat$V2)
feat$V2 <- gsub("-", "_", feat$V2)

names(train.x) <- feat$V2
train.use <- train.x[, feat.use]

names(test.x) <- feat$V2
test.use <- test.x[, feat.use]


## Read in acitivity labels - these correspond to training labels 'y_' in the train and test data
alab <- read.table("activity_labels.txt")
train.lab <- left_join(train.y, alab)
test.lab <- left_join(test.y, alab)


## Put together all data components, label the data ("training" or "test") before combining them
train <- bind_cols(train.sj, train.lab, train.use)
test <- bind_cols(test.sj, test.lab, test.use)

train$data.type <- "Training data"
test$data.type <- "Test data"
dat <- bind_rows(train, test)

## Name any unnamed variables, drop redudant variable, and reorder columns
names(dat)[1:3] <- c("subject", "todrop", "activity")
dat <- dat[, !names(dat) %in% c("todrop")]
dat <- dat[, c(ncol(dat), 1:ncol(dat)-1)]

## Aggregate the data to the average of each feature variable for each activity and each subject
dat2 <- dat %>% group_by(data.type, subject, activity) %>% 
                summarise_at(vars(tBodyAcc_mean_X:fBodyBodyGyroJerkMag_std), mean, na.rm = TRUE)
names(dat2)[4:69] <- paste0("avg_", names(dat2)[4:69])

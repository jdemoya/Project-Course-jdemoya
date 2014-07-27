#Part 1
x_test <- read.table("./test/X_test.txt");
y_test <- read.table("./test/y_test.txt");
subject_test <-read.table("./test/subject_test.txt");
x_train<-read.table("./train/X_train.txt");
y_train<-read.table("./train/y_train.txt");
subject_train<-read.table("./train/subject_train.txt");
x_merge <- rbind(x_test,x_train);
y_merge <- rbind(y_test,y_train);
subject_merge <- rbind(subject_test,subject_train);
x_merge$activity <- y_merge;
x_merge$subject <- subject_merge;

#Part 2
activity_labels <- read.table("./activity_labels.txt")
features <- read.table("./features.txt");

z <- x_merge[,c(grep("mean",features$V2),grep("Mean",features$V2),grep("std",features$V2))];

#Part 3
#factor(x_merge[,562],activity_labels[,1],activity_labels[,2])
x_merge[x_merge[,562] == 1,562] <- "WALKING"
x_merge[x_merge[,562] == 2,562] <- "WALKING_UPSTAIRS"
x_merge[x_merge[,562] == 3,562] <- "WALKING_DOWNSTAIRS"
x_merge[x_merge[,562] == 4,562] <- "SITTING"
x_merge[x_merge[,562] == 5,562] <- "STANDING"
x_merge[x_merge[,562] == 6,562] <- "LAYING"

#Part4 
names(x_merge) <- features[,2]
names(x_merge)[562] <- "activity"
names(x_merge)[563] <- "subject"

#Part5
library(reshape2)
x_melt <- melt(x_merge,id=c("activity","subject"),measure.vars=c(names(x_merge)[1]))

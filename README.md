Project-Course-jdemoya
======================

Project Course of Getting and Cleaning Data jdemoya

This project includes a file called run_analysis.R which run several R commands:

The explanation is following 

#Part 1
#Read the files test and train with the dataset and subject and #activities file
x_test <- read.table("./test/X_test.txt");
y_test <- read.table("./test/y_test.txt");
subject_test <-read.table("./test/subject_test.txt");
x_train<-read.table("./train/X_train.txt");
y_train<-read.table("./train/y_train.txt");
subject_train<-read.table("./train/subject_train.txt");

#Merge files with command rbind
x_merge <- rbind(x_test,x_train);
y_merge <- rbind(y_test,y_train);
subject_merge <- rbind(subject_test,subject_train);

#Add columns activity and subject
x_merge$activity <- y_merge;
x_merge$subject <- subject_merge;

#Part 2

#Load activity labels and features in R variables
activity_labels <- read.table("./activity_labels.txt")
features <- read.table("./features.txt");

@Extracts only the mean and std measurements
z <- x_merge[,c(grep("mean",features$V2),grep("Mean",features$V2),grep("std",features$V2))];

#Part 3
#Assign activity description at the last column

x_merge[x_merge[,562] == 1,562] <- "WALKING"
x_merge[x_merge[,562] == 2,562] <- "WALKING_UPSTAIRS"
x_merge[x_merge[,562] == 3,562] <- "WALKING_DOWNSTAIRS"
x_merge[x_merge[,562] == 4,562] <- "SITTING"
x_merge[x_merge[,562] == 5,562] <- "STANDING"
x_merge[x_merge[,562] == 6,562] <- "LAYING"

#Part4 
#Assign features names to the columns
names(x_merge) <- features[,2]
names(x_merge)[562] <- "activity"
names(x_merge)[563] <- "subject"

#Part5
#Generate a new tidy data file with mean of the measurements #grouped by activity and subject

library(reshape2)
x_melt <- melt(x_merge,id=c("activity","subject"),measure.vars=c(names(x_merge)[1]))

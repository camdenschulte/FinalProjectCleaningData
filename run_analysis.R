#Final Project: Cleaning Data

library(tidyverse)

#Downloading zip file
URL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
dest <- "/Users/gregschulte/Desktop/datasciencecoursera/Class 3: Cleaning Data/samsung.zip"
download.file(url = URL,destfile = dest,method = "curl")

#Setting working directory to the zip file
setwd("/Users/gregschulte/Desktop/datasciencecoursera/Class 3: Cleaning Data/UCI HAR Dataset/")

#Reading in labels and features
activity_labels <- read.table("./activity_labels.txt",col.names = c("numbers","activity"))
features <- read.table("./features.txt",col.names = c("index","measurements"))

#Reading in the training files
Trainsubject <- read.table("./train/subject_train.txt", header=FALSE,col.names = "subject")
xTrain <- read.table("./train/X_train.txt", header=FALSE,col.names = features$measurements)
yTrain <- read.table("./train/y_train.txt", header=FALSE,col.names = "numbers")

#Reading in the test files
Testsubject <- read.table("./test/subject_test.txt", header=FALSE,col.names = "subject")
xTest <- read.table("./test/X_test.txt", header=FALSE,col.names = features$measurements)
yTest <- read.table("./test/y_test.txt", header=FALSE,col.names = "numbers")

#Merging the training and test data to create one dataset
x <- rbind(xTrain,xTest)
y <- rbind(yTrain, yTest)
subjects <- rbind(Trainsubject, Testsubject) 
data <- cbind(subjects, y, x)

#Extracting measurements with only mean or std. deviation
cleandata <- data %>% select(subject, numbers, contains("mean"), contains("std"))

#Naming acivities in the dataset
cleandata$numbers <- activity_labels[cleandata$numbers, 2]

#Labeling the dataset with descriptive variable names
cleandata <- cleandata %>% rename(activity = numbers)
names(cleandata)<-gsub("Acc", "Accelerometer", names(cleandata))
names(cleandata)<-gsub("Gyro", "Gyroscope", names(cleandata))
names(cleandata)<-gsub("BodyBody", "Body", names(cleandata))
names(cleandata)<-gsub("Mag", "Magnitude", names(cleandata))
names(cleandata)<-gsub("^t", "Time", names(cleandata))
names(cleandata)<-gsub("^f", "Frequency", names(cleandata))
names(cleandata)<-gsub("tBody", "TimeBody", names(cleandata))
names(cleandata)<-gsub("-mean()", "Mean", names(cleandata), ignore.case = TRUE)
names(cleandata)<-gsub("-std()", "STD", names(cleandata), ignore.case = TRUE)
names(cleandata)<-gsub("-freq()", "Frequency", names(cleandata), ignore.case = TRUE)
names(cleandata)<-gsub("angle", "Angle", names(cleandata))
names(cleandata)<-gsub("gravity", "Gravity", names(cleandata))

#Creating second dataset
seconddataset <- cleandata %>% group_by(subject,activity) %>% summarise_all(funs(mean))
write.table(seconddataset,file = "Final.txt", row.names = FALSE)

         
            
            
# You should create one R script called run_analysis.R that does the following.

        # 1. Merges the training and the test sets to create one data set.
        # 2. Extracts only the measurements on the mean and standard deviation for each measurement.
        # 3. Uses descriptive activity names to name the activities in the data set
        # 4. Appropriately labels the data set with descriptive variable names.
        # 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.


if (!require("data.table")){
        install.packages("data.table")
}

if (!require("reshape2")){
        install.packages("reshape2")
}

library(data.table)
library(reshape2)
library(dplyr)


#Reading Data
X_test <- read.table("./data/UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("./data/UCI HAR Dataset/test/y_test.txt")
subject_test <- read.table("./data/UCI HAR Dataset/test/subject_test.txt")

X_train <- read.table("./data/UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("./data/UCI HAR Dataset/train/y_train.txt")
subject_train <- read.table("./data/UCI HAR Dataset/train/subject_train.txt")

activity_labels <- read.table("./data/UCI HAR Dataset/activity_labels.txt")
features <- read.table("./data/UCI HAR Dataset/features.txt")


# 1. Merging training and test sets
Merged_Data <- rbind(X_train, X_test)


# 2. Extracting only the measurements on the mean and standard deviation for each measurement:
extract_features <- grep("mean()|std()", features[,2])
Merged_Data <- Merged_Data[, extract_features]

# 3. Uses descriptive activity names to name the activities in the data set

#Names
cleanFNames <- sapply(features[,2], function(x){
        gsub("[()]", "",x)})

names(Merged_Data) <- cleanFNames[extract_features]

#label the data set with descriptive labels

subject <- bind_rows(subject_test, subject_train)
names(subject) <- 'subject'
activity <- bind_rows(y_train, y_test)
names(activity) <- 'activity'

#Combining subject, activity, mean and std in only dataset:
Merged_Data <- bind_cols(subject, activity, Merged_Data)


#4. Renaming labels of levels with activity_levels, and apply it to dataSet
activity_ID <- factor(Merged_Data$activity)
levels(activity_ID) <- activity_labels[,2]
Merged_Data$activity <- activity_ID
View(Merged_Data)

#5. Tidy data set with the average of each variable for each activity and each subject.

Data <- melt(Merged_Data, (id.vars=c("subject", "activity")))
tidy_data <- dcast(Data, subject + activity ~ variable, mean)
names(tidy_data)[-c(1:2)] <- paste("[mean of]", names(tidy_data)[-c(1:2)])
                                   

write.table(tidy_data, file = "./tidy_data.txt", sep=",")

View(tidy_data)

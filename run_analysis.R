# Read Training Table
x_train <- read.table("train/x_train.txt");
y_train <- read.table("train/y_train.txt");
subject_train <- read.table("train/subject_train.txt");

# Read Test Table
x_test <- read.table("test/x_test.txt");
y_test <- read.table("test/y_test.txt");
subject_test <- read.table("test/subject_test.txt");

# Read Feature Table
feature <- read.table("features.txt");

# Read Activity labels
act_label <- read.table("activity_labels.txt");

# 4. Appropriately labels the data set with descriptive variable names.
colnames(x_train) <- feature[,2];
colnames(y_train) <- "classLabel";
colnames(subject_train) <- "subject";
colnames(x_test)  <- feature[,2];
colnames(y_test)  <- "classLabel";
colnames(subject_test) <- "subject";
colnames(act_label) <-c("classLabel", "activityName");

# 1. Merges the training and the test sets to create one data set.
train <- cbind(subject_train,y_train,x_train);
test <- cbind(subject_test,y_test,x_test);
dataset <- rbind(test, train);

# 2. Extracts only the measurements on the mean and standard deviation for each measurement.
mean_std <- (grepl("subject",colnames(dataset))|grepl("classLabel",colnames(dataset))|grepl("mean()",colnames(dataset))|grepl("std()",colnames(dataset)));
dataset_mean_std <- dataset[,mean_std];

# 3. Uses descriptive activity names to name the activities in the data set
dataset_mean_std_act <- merge(dataset_mean_std,act_label,by='classLabel',all.x=TRUE);

# 4. From the data set in step 4, creates a second, independent tidy data set with the 
#    average of each variable for each activity and each subject.
data_aggregate <- aggregate(. ~subject + classLabel,dataset_mean_std_act,mean);

# Export dataset
write.table(data_aggregate, "data_aggregate.txt", row.name=FALSE);
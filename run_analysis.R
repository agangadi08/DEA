file_url <- 'https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip'
file_name <-"Dataset.zip" 

# Downloading the file if not exists already

if (!file.exists(file_name)){
        download.file(file_url, destfile = "./Dataset.zip", method = "curl")
}

#unzip the zip file

if (!file.exists("./Dataset")) { 
        unzip(file_name) 
}

# load train tables:
x_train <- read.table("./UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("./UCI HAR Dataset/train/y_train.txt")
subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt")

# load test tables:
x_test <- read.table("./UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("./UCI HAR Dataset/test/y_test.txt")
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")

# load feature details:
features <- read.table('./UCI HAR Dataset/features.txt')

# load activity labels:
activityLabels = read.table('./UCI HAR Dataset/activity_labels.txt')

# set colnames for test, train and subject data frames
colnames(x_train) <- features[,2] 
colnames(y_train) <-"activityId"
colnames(subject_train) <- "subjectId"

colnames(x_test) <- features[,2] 
colnames(y_test) <- "activityId"
colnames(subject_test) <- "subjectId"

colnames(activityLabels) <- c('activityId','activityType')

# Merge train and test data

col_train_m <- cbind(y_train, subject_train, x_train)
col_test_m <- cbind(y_test, subject_test, x_test)
allData <- rbind(col_train_m, col_test_m)

colNames <- colnames(allData)



subset_data <- (grepl("activityId" , colNames) | 
                         grepl("subjectId" , colNames) | 
                         grepl(".mean.." , colNames) | 
                         grepl(".std.." , colNames) 
)

mean_SD_data <- allData[ , subset_data == TRUE]



mean_SD_data_ActivityNames <- merge(mean_SD_data, activityLabels,
                             by='activityId',
                             all.x=TRUE)


aggre_data <- aggregate(. ~subjectId + activityId, mean_SD_data_ActivityNames, mean)

write.table(aggre_data, "Tidy.txt", row.name=FALSE,quote = FALSE)

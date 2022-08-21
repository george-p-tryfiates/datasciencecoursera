setwd('UCI HAR Dataset')
library(dplyr)
# Features
features <- readLines('features.txt')
# Activities
activities <- read.table('activity_labels.txt', col.names = c("ACTIVITYCODE", "ACTIVITYLABEL"))
# Test
# X Test
UCIdata <- read.table('test/X_test.txt')
names(UCIdata) <- features
# Y Test (Activities)
y_data <- read.table('test/Y_test.txt', col.names = "ACTIVITYCODE")
dplyr::left_join(y_data, activities, by = c("ACTIVITYCODE"="ACTIVITYCODE")) -> y_data
# Combine X & Y
cbind(y_data, UCIdata) -> UCIdata
# Subject
subject <- read.table("test/subject_test.txt", col.names = "SUBJECT")
cbind(subject, UCIdata) -> UCIdata

# Train
train <- read.table('train/X_train.txt')
names(train) <- features
subject <- read.table('train/subject_train.txt', col.names = "SUBJECT")
y_data <- read.table('train/Y_train.txt', col.names = "ACTIVITYCODE")
dplyr::left_join(y_data, activities, by = c("ACTIVITYCODE"="ACTIVITYCODE")) -> y_data
cbind(subject, y_data, train ) -> train

# Combine Train & Test
rbind(UCIdata, train) -> UCIdata

# Select the means & std variables
UCIdata %>% select(grep("mean|std", names(UCIdata))) -> selectData

# Combine
filtered_data <- cbind(UCIdata[, 1:3], selectData)

# Group and Average
filtered_data %>% group_by(SUBJECT, ACTIVITYLABEL) %>% summarise_at(vars(-ACTIVITYCODE), funs(mean(.))) -> final_data

# Tidy
names<- names(final_data)
names[3:81] <- gsub("[0-9]{1,3}", "Mean of", names[3:81])
names(final_data) <- names
janitor::clean_names(final_data) -> final_data
final_data$activitylabel <- tolower(final_data$activitylabel)
write.table(final_data, file = "SummaryofUCIData.txt", row.names = FALSE)



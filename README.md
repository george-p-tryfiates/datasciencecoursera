---
title: "README"
author: "Tryfiates, George"
date: '2022-08-21'
output: html_document
---

This sets the working directory and imports the `dplyr` library.
```{r}
setwd('UCI HAR Dataset')
library(dplyr)
```

This imports the feature labels (the 561 column headers).
```{r}
# Features
features <- readLines('features.txt')
```

This imports the activity labels and their corresponding code.
```{r}
# Activities
activities <- read.table('activity_labels.txt', col.names = c("ACTIVITYCODE", "ACTIVITYLABEL"))
```

This imports the first dataset--the test data.
```{r}
# Test
# X Test
UCIdata <- read.table('test/X_test.txt')
# We will assign the feature labels to the column names in our dataset
names(UCIdata) <- features
# Y Test (Activities)
y_data <- read.table('test/Y_test.txt', col.names = "ACTIVITYCODE")
dplyr::left_join(y_data, activities, by = c("ACTIVITYCODE"="ACTIVITYCODE")) -> y_data
# Combine X & Y--adding the activity labels to our test data
cbind(y_data, UCIdata) -> UCIdata
# Subject Data: Import the subject identifier and add it to the test data
subject <- read.table("test/subject_test.txt", col.names = "SUBJECT")
cbind(subject, UCIdata) -> UCIdata
```


This imports the training data
```{r}
# Training data
train <- read.table('train/X_train.txt')
# Assign feature labels as column headers
names(train) <- features
# Import the new subject identifiers
subject <- read.table('train/subject_train.txt', col.names = "SUBJECT")
# Import the new activity labels
y_data <- read.table('train/Y_train.txt', col.names = "ACTIVITYCODE")
# Join the activity labels to the training data
dplyr::left_join(y_data, activities, by = c("ACTIVITYCODE"="ACTIVITYCODE")) -> y_data
# Join the subject identifiers and activity labels to the training data
cbind(subject, y_data, train ) -> train
```


Join the Test and Training Data together
```{r}
# Combine Train & Test
rbind(UCIdata, train) -> UCIdata
```

Filter the 561-vector for just the features that are means or standard deviations
```{r}
# Select the means & std variables
UCIdata %>% select(grep("mean|std", names(UCIdata))) -> selectData

# Combine
filtered_data <- cbind(UCIdata[, 1:3], selectData)
```

Average the 81 features for each subject by each activity
```{r}
# Group and Average
filtered_data %>% group_by(SUBJECT, ACTIVITYLABEL) %>% summarise_at(vars(-ACTIVITYCODE), funs(mean(.))) -> final_data
```

Clean the column headers and specify that the new features are the averages of the previous observations
```{r}
# Tidy
names<- names(final_data)
names[3:81] <- gsub("[0-9]{1,3}", "Mean of", names[3:81])
names(final_data) <- names
janitor::clean_names(final_data) -> final_data
```

Lowercase the activity labels
```{r}
final_data$activitylabel <- tolower(final_data$activitylabel)
```

Export the data to "SummaryofUCIData.txt"
```{r}
write.table(final_data, file = "SummaryofUCIData.txt", row.names = FALSE)
```


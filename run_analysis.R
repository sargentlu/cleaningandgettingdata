library(data.table)
library(dplyr)

#   Helper functions
read_file <- function(var, type) {
    fread(paste(var, "_", type, ".txt", sep=""))
}

download_dataset <- function() {
    if (!dir.exists("data")) {
        dir.create("data")
    }
    
    setwd("data")
    
    file_url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
    zip_file <- "dataset.zip"
    
    if (!dir.exists("UCI HAR Dataset")) {
        download.file(file_url, zip_file)
        unzip(zip_file)
        file.remove(zip_file)    
    }
    
    setwd("..")
}

create_dataset <- function() {
    features <- fread("features.txt")
    activity_labels <- fread("activity_labels.txt")
    data_types <- c("test", "train")
    colnames(activity_labels) <- c("activity_id", "activity_type")
    
    all_datasets <- lapply(data_types, function(d_type) {
        setwd(d_type)
        
        x <- read_file("X", d_type)
        y <- read_file("y", d_type)
        subject <- read_file("subject", d_type)
        
        setwd("..")
        
        #   4. Appropriately labels the data set with descriptive variable
        #      names.
        colnames(x) <- features[[2]]
        colnames(y) <- "activity_id"
        colnames(subject) <- "subject_id"
        
        #   2. Extracts only the measurements on the mean and standard
        #      deviation for each measurement.
        mean_std <- grepl("mean|std", colnames(x))
        d_set <- bind_cols(subject, y, x[, ..mean_std])
    })
    
    #    1. Merges the training and the test sets
    #       to create one data set.
    dataset <- bind_rows(all_datasets[1], all_datasets[2]) %>%
               #    3. Uses descriptive activity names to name
               #       the activities in the data set
               merge(activity_labels, by = "activity_id") %>%
               arrange(activity_id)
}

create_summary <- function(d_set) {
    activity_labels <- fread("activity_labels.txt")
    colnames(activity_labels) <- c("activity_id", "activity_type")
    
    #   5. From the data set, creates a second, independent tidy data set with
    #      the average of each variable for each activity and each subject.
    d_summary <- d_set %>%
                 group_by(activity_id, subject_id) %>%
                 summarize_if(is.numeric, c(mean)) %>%
                 merge(activity_labels, by = "activity_id") %>%
                 select(c("activity_id",
                          "activity_type",
                          "subject_id",
                          colnames(d_set)[grepl("mean|std", colnames(d_set))]))
}

#   Download and extract dataset
download_dataset()

data_path <- file.path("data", "UCI HAR Dataset")
setwd(data_path)

dataset <- create_dataset()
data_summary <- create_summary(dataset)

#   Remove temporary objects
rm(list = c("activity_labels", "create_dataset", "create_summary",
            "data_path", "download_dataset", "read_file"))
setwd("../..")

fwrite(data_summary, "tidy_data.csv")

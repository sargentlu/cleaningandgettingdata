## Code Book

This code book describes the data used for the Getting and Cleaning Data Course Project and the processing steps for creating the resulting tidy dataset.

### Overview

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING). The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

### Explanation of each file

* `activity_labels.txt`: Links the class labels with their activity name.
* `features.txt`: List of all features.

* `README.txt`: Information about the activity recognition project and files.
* `features_info.txt`: Contains information about each feature in `features.txt`.

* `subject_test.txt`: Each row identifies the subject who performed the activity for each window sample as per `X_test.txt`.
* `X_test.txt`: Test set, 2947 observations of the 561 features.
* `y_test.txt`: Training set labels (activity_ids for `X_test.txt`).

* `subject_train.txt`: Each row identifies the subject who performed the activity for each window sample as per `X_train.txt`.
* `X_train.txt`: Training set, 7352 observations of the 561 features.
* `y_train.txt`: Training set labels (activity_ids for `X_train.txt`).

### Unused data files

Raw data was not used to make the analysis, files in the `/Inertial Signals` folder were ignored.

### Processing steps

1. The dataset is downloaded and extracted if it's not yet available in the system.

2. For each data type (`test` and `train`), the relevant files are read to create data tables for `X`, `y`, and `subject`. Data tables were chosen to improve handle times, especially given the size of the `X` data.

3. For each data type, the datasets are labeled according to the included `activity_labels`, or as an `activity/subject_id`.

4. For each data type, the `X`, `y` and `subject` datasets are column binded. For `X`, only columns that have either `mean` or `std` are included.

5. All the resulting datasets are row binded and then sorted by the `activity_id` column, in order to create a tidy dataset.

6. The tidy dataset is then grouped by its `activity_id` and `subject_id`, and summarized into a dataset with the mean value of each group.

7. The `activity_type` is included into the summarized dataset, and is then exported to the `tidy_data.csv` file.

# Cleaning and Getting Data Course Project

The purpose of the `run_analysis.R` script is to tidy and summarize the data on the Human Activity Recognition Using Smartphones Dataset. Run it on your workspace as:

`source(run_analysis.R)`

This will do the following

1. Download and unzip the Human Activity Recognition Using Smartphones Dataset.

2. Read the datasets, labelling the data and filtering only the relevant variables.

3. Bind the datasets for each data type (`test` and `train`) to include the activity, subject and relevant variables (`mean` and `std`) .

4. Merge the test and train data into a single dataset.

7. Bind the new dataset with the related `activity_types`.

8. Groups the tidy dataset by its `activity_id` and `subject_id`, and create a summarized dataset with the mean value of each group.

9. Exports the resulting tidy dataset as 'tidy_data.csv, which can be found on the `data` directory.
# Getting and Cleaning Data Course Project

This is the course project for the Getting and Cleaning Data course. The R script, run_analysis.R, does the following:

1.	If the data doesn’t already exist in the working directory, it is downloaded. 
2.	The activity (the things subjects were doing when the data was collected) and feature (the labels for the raw signals captured when the activity was going on) are loaded.
3.	Only the labels which contain mean and standard deviation are kept.  The labels are also cleaned of dashes.
4.	The training and test datasets are loaded, and only those columns which reflect a mean or standard deviation are kept
5.	The activity and subject data for each dataset are loaded, and those columns are merged with the dataset
6.	The two datasets, test and train, are merged
7.	The activity and subject columns are converted into factors
8.	A  tidy dataset is created that is the average (mean) value of each variable for each subject and activity pair.

The end result is shown in the file tidy.txt.

The data is tidy because:

1. Each variable forms a column
2. Each observation forms a row
3. Each type of observational unit forms a table
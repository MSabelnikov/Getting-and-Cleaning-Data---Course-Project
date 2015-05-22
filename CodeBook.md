---
title: "CodeBook"
output: html_document
---

###Description of dataset

The tidy dataset has 14220 observations and 4 variables.

###Variables description

* subject - person that performed acativities for the experiment (integer)
* activity_name - action performed
* variable - features \ variables
* average value

###Description of run_analysis.R script

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names. 
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

For full script please see readme.md



Tidy data 'dat' contains both the training and test data from the original HAR data on the mean and standard deviation of each type of signals generated during the study, each row of the 'dat' is a measurement for a study subject within a window of 2.56 sec for a specific activity

'dat' contains the follwing variables:

data.type: whether it's test or training data

subject: identifier for subjects participating in the study

activity: one of the six activities being studied (walking, walking downstairs, walking upstairs, sitting, standing, laying)

tBodyAcc_mean_X ~ fBodyBodyGyroJerkMag_std: a pair of mean ('mean') and standard deviation ('std') for each type of signals generated from the study, there are 33 signals and so 66 variables in this category



Tidy data 'dat2' is a derivative of 'dat', each row of 'dat2' is the average of all measurements of signals for an activity and a subject,

'dat2' contains the following variables:

data.type: whether it's test or training data

subject: identifier for subjects participating in the study

activity: one of the six activities being studied (walking, walking downstairs, walking upstairs, sitting, standing, laying)

avg_tBodyAcc_mean_X ~ avg_fBodyBodyGyroJerkMag_std: the average ('avg') of tBodyAcc_mean_X ~ fBodyBodyGyroJerkMag_std in 'dat' for each activity and each subject
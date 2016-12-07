## Cleaning and summarizing Smartphone accelerometer data

The dataset in this repo (tidydata.csv) was compiled from data orignially collected from the accelerometers from the Samsung Galaxy S smartphones. A full description of the original data is available here:   http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones and the data that were input into the script shared in this repo can be downloaded here:  https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

The script (run_analysis.R) does the following steps:
1.  downloads and reads the orginal data sets
2.  merges them together into a data frame that contains the following variables-
        a) participant ID (1-30), 
        b) the group type (70% from training group and 30% from test group), 
        c) activity performed durng the measurements (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING),
        d) measurements as described in links above
3.  selects variables that represent a measurement mean or standard deviation and discards the rest,
4.  calculating the mean of each of the 78 remaining measurement variables for each partipant, during each type of activity.
        





From original data set-
License:
========
Use of this dataset in publications must be acknowledged by referencing the following publication [1] 

[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

This dataset is distributed AS-IS and no responsibility implied or explicit can be addressed to the authors or their institutions for its use or misuse. Any commercial use is prohibited.

Jorge L. Reyes-Ortiz, Alessandro Ghio, Luca Oneto, Davide Anguita. November 2012.


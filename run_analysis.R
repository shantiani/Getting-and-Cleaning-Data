##  Merges the training and the test sets to create one data set.
    
    ##  download and read files          
        if(!file.exists("./data")){dir.create("./data")}
        fileUrl = "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
        download.file(fileUrl, destfile = "./data/data", method = "curl")
        unzip("./data/data", exdir = "./data")
    ## put training and test data into data frames
        testsubjectids <- read.table("./data/UCI HAR Dataset/test/subject_test.txt")
        testmeasurements <- read.table("./data/UCI HAR Dataset/test/X_test.txt")
        testlabels <- read.table("./data/UCI HAR Dataset/test/Y_test.txt")
        trainsubjectids <- read.table("./data/UCI HAR Dataset/train/subject_train.txt")
        trainmeasurements <- read.table("./data/UCI HAR Dataset/train/X_train.txt")
        trainlabels <- read.table("./data/UCI HAR Dataset/train/Y_train.txt")
        activitylabels <- read.table("./data/UCI HAR Dataset/activity_labels.txt")
        featurenums <- read.table("./data/UCI HAR Dataset/features.txt")
        
        ## add a column to label test vs. training subjects before tables are combined
        testsubjectids<- cbind(testsubjectids, rep("test", times=length(testsubjectids)), testlabels)
        trainsubjectids<- cbind(trainsubjectids, rep("training", times=length(trainsubjectids)), trainlabels)
        names(testsubjectids)<- c("subjectid", "group", "activity")
        names(trainsubjectids)<- c("subjectid", "group", "activity")
        
        library(dplyr)
        testids <- tbl_df(testsubjectids)
        testmeas <- tbl_df(testmeasurements)
        testactivities <- tbl_df(testlabels)
        trainids <- tbl_df(trainsubjectids)
        trainmeas <- tbl_df(trainmeasurements)
        trainactivities <- tbl_df(trainlabels)
        actlabels <- tbl_df(activitylabels)
        features <- tbl_df(featurenums)
        
        rm(testsubjectids, testmeasurements, testlabels, trainsubjectids, trainmeasurements, 
           trainlabels, activitylabels, featurenums)
        
## label variables and merge data frames
        testdata <-testids
        testdata[,4:564] <- testmeas
        traindata <- trainids
        traindata[,4:564] <- trainmeas
        alldata <- rbind(testdata, traindata)

##  Extracts only the measurements on the mean and standard deviation for each measurement.
        meanandstd <- grep("mean|std", features[,2][[1]], value = FALSE)
        selectdata <- select(alldata, c(1,2,3,3+meanandstd))
        
##  Uses descriptive activity names to name the activities in the data set
        selectdata$activity<- factor(selectdata$activity, labels=activitylabels$V2)
##  Appropriately labels the data set with descriptive variable names.
        names(selectdata) <- c("id","group","activity",as.character(features[meanandstd,2][[1]]))
##  From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
        s<-matrix(nrow = 180, ncol = 82)
        counter<-0
        for (j in 1:30) {
          a<-filter(selectdata, id == j) 
          for (k in 1:6){
            counter <- counter+1
            b<-filter(a, activity==actlabels[k,2][[1]]) 
            d <- sapply(b, mean) 
            s[counter,1:3]<-c(j, as.character(b[1,2][[1]]), as.character(actlabels[k,2][[1]]))
            s[counter,4:82]<-unname(d[4:82])
            }
          }
        summaryaverages<-tbl_df(s)
        names(summaryaverages)<- names(selectdata)
        write.csv(summaryaverages, file = "tidydata.csv", quote = FALSE, row.names = FALSE)       
        
       
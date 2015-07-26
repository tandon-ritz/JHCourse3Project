## SET THE WORKING DIRECTORY

## NOTE - UNCOMMENT FOLLOWING LINE AND SET THE WORKING DIRECTORY ACCORDING TO YOUR DIRECTORY STRUCTURE

#setwd("D:\\ritesh\\data-science\\JohnHopkins\\course-3-datacleaning\\course-project\\UCI HAR Dataset")


## READ X TEST, Y TEST, SUBJECT TEST DATA INTO DATA FRAME

Xtest = read.table(".\\test\\X_test.txt")
Ytest = read.table(".\\test\\y_test.txt")
SubjectTest = read.table(".\\test\\subject_test.txt")

## ADD Y TEST COLUMN TO X TEST

Xtest<-cbind(Xtest,Ytest)

## ADD SUBJECT TEST COLUMN TO X TEST

Xtest<-cbind(Xtest,SubjectTest)

## READ X TRAIN, Y TRAIN, SUBJECT TRAIN DATA INTO DATA FRAME

Xtrain = read.table(".\\train\\X_train.txt")
Ytrain = read.table(".\\train\\y_train.txt")
SubjectTrain = read.table(".\\train\\subject_train.txt")

## ADD Y TRAIN FEATURE ( COLUMN ) TO X TRAIN DATA FRAME

Xtrain<-cbind(Xtrain,Ytrain)

## ADD SUBJECT TRAIN FEATURE ( COLUMN ) TO X TRAIN DATA FRAME

Xtrain<-cbind(Xtrain,SubjectTrain)


# MERGE THE X TEST AND X TRAIN DATA INTO ONE DATA FRAME

MergeDS<-rbind(Xtest,Xtrain)


# READ THE FEATURE NAMES FROM THE features.txt FILE 

VarNames<-read.table("features.txt", sep = " ",as.is = TRUE)$V2

#ASSIGN FEATURE NAMES ( VARIABLE NAMES ) TO MERGED DATA FRAME

colnames(MergeDS)<-c(VarNames,"Activity","Subject")

#REMOVED DUPLICATE FEATURES

MergeDS <- MergeDS[ , !duplicated(colnames(MergeDS))] 

#LOAD DPLYR LIBRARY

library(dplyr)

#FILTER ONLY FEATURE NAMES THAT HAS MAIN() IN IT AND STORE IT IN CHARACTER VECTOR

meanCol<-names(MergeDS %>% select(contains("mean()")))

#FILTER ONLY FEATURE NAMES THAT HAS STD() IN IT AND STORE IT IN CHARACTER VECTOR

stdCol<-names(MergeDS %>% select(contains("std()")))

# CREATE NEW DATAFRAME WITH DATA OF ONLY MEAN

meanDF<-MergeDS[, meanCol]

# CREATE NEW DATAFRAME WITH DATA OF ONLY STANDARD DEVIATION

stdDF<-MergeDS[, stdCol]

# ADD BOTH MEAN AND STANDARD DEVIATION FEATURE DATA INTO ONE DATA FRAME

XMeanStd<-cbind(meanDF,stdDF)

# WHILE FILTERING MEAN AND STD FEATURES , ACTIVITY AND SUBJECT FEATURE WERE LEFT OUT, SO NOW ADD THOSE IN DATA FRAME

XMeanStd<-cbind(XMeanStd,MergeDS$Activity,MergeDS$Subject)

# NOW GIVE FATURE NAMES ( VARIABLE NAMES ) TO THE NEWLY FORMED DATA FRAME

colnames(XMeanStd)<-c(meanCol,stdCol,"Activity","Subject")

# UPDATE THE DATA FRAME ACTIVITY COLUMN VALUES TO ITS DESCRIPTION


for( i in 1:nrow(XMeanStd))
{
  if ( XMeanStd[i,"Activity"] == 1 )
  {
    XMeanStd[i,"Activity"]<-c("WALKING")
  }
  else if ( XMeanStd[i,"Activity"] == 2 )
  {
    XMeanStd[i,"Activity"]<-c("WALKING_UPSTAIRS")
  }
  else if ( XMeanStd[i,"Activity"] == 3 )
  {
    XMeanStd[i,"Activity"]<-c("WALKING_DOWNSTAIRS")
  }
  else if ( XMeanStd[i,"Activity"] == 4 )
  {
    XMeanStd[i,"Activity"]<-c("SITTING")
  }
  else if ( XMeanStd[i,"Activity"] == 5 )
  {
    XMeanStd[i,"Activity"]<-c("STANDING")
  }
  else if ( XMeanStd[i,"Activity"] == 6 )
  {
    XMeanStd[i,"Activity"]<-c("LAYING")
  }
}

# LOAD PLR LIBRARY

library(plyr)

# GROUP THE DATAFRAME BY SUBJECT AND ACTIVITY AND APPLY AVERAGE ( MEAN ) FUNCTION 

tidydata<-ddply(XMeanStd, .(Subject, Activity), colwise(mean))

# STORE THE RESULT IN A TEXT FILE

write.table(tidydata, "tidydata.txt", sep=" ", quote=FALSE, row.names=FALSE)




### STEPS TO EXECUTE Run_Analyis.R FILE

* Place the script into your working directory.

* Open. R file and change the path of first line , inside setwd folder as per your working directory path.

* Make sure files/folders under Samsung Data root folder ( UCI HAR Dataset ) is inside your working directory.

* Following files and folders should be inside your working directory-
	- test (folder ). This folder should contain X_test.txt, Y_test.txt and Subject_Test.txt file
	- train ( folder ) . This folder should contain X_test.txt, Y_test.txt and Subject_Test.txt file
	- activity_labels.txt
	- features.txt
	- features_info.txt
	- Run_Analysis.R

* Execute the Run_Analysis.R

* tidydata.txt file will be created inside your working directory.

* tidydata.txt file is having 180 observations of 68 variables. Refer to CodeBook.md file for variable description. 



### DESCRIPTION OF Run_Analysis.R CODE

* SET THE WORKING DIRECTORY - Using setwd function
* READ X TEST, Y TEST, SUBJECT TEST DATA INTO DATA FRAME - Using read.table function 
* ADD Y TEST COLUMN TO X TEST - Using cbind function 
* ADD SUBJECT TEST COLUMN TO X TEST - Using cbind function
* READ X TRAIN, Y TRAIN, SUBJECT TRAIN DATA INTO DATA FRAME - Using read.table function
* ADD Y TRAIN FEATURE ( COLUMN ) TO X TRAIN DATA FRAME - Using cbind function
* ADD SUBJECT TRAIN FEATURE ( COLUMN ) TO X TRAIN DATA FRAME - Using cbind function
* MERGE THE X TEST AND X TRAIN DATA INTO ONE DATA FRAME - Using rbind function into MergeDS data frame
* READ THE FEATURE NAMES FROM THE features.txt FILE - Using read.table function
* ASSIGN FEATURE NAMES ( VARIABLE NAMES ) TO MERGED DATA FRAME - Using colnames function passing merged data frame to it
* REMOVED DUPLICATE FEATURES - Removed duplicate variables from data frame using duplicated function by passing feature name to it
* LOAD DPLYR LIBRARY - Load dplyr library for filtering the mean and std features 
* FILTER ONLY FEATURE NAMES THAT HAS MEAN() IN IT AND STORE IT IN CHARACTER VECTOR. - Using Select and Contains function. THIS GIVES US 33 FEATURES
* FILTER ONLY FEATURE NAMES THAT HAS STD() IN IT AND STORE IT IN CHARACTER VECTOR.  - Using Select and Contains function. THIS GIVES US 33 FEATURES
* CREATE NEW DATAFRAME WITH DATA OF ONLY MEAN - Select only Mean variable data from merged data frame and store into mean data frame
* CREATE NEW DATAFRAME WITH DATA OF ONLY STANDARD DEVIATION - Select only standard deviation variable data from merged data frame and store into std data frame
* ADD BOTH MEAN AND STANDARD DEVIATION FEATURE DATA INTO ONE DATA FRAME. - Using cbind functin. THIS GIVES US DATA FRAME WITH 66 FEATURES.
* ACTIVITY AND SUBJECT FEATURE WERE LEFT OUT WHILE FILTERING MEAN AND STD FEATURES,SO NOW ADD THOSE IN DATA FRAME. -Using cbind function. THIS GIVES US TOTAL 68 FEATURES IN FINAL DATA FRAME
* NOW GIVE FEATURE NAMES ( VARIABLE NAMES ) TO THE NEWLY FORMED DATA FRAME - Using colnames function
* UPDATE THE DATA FRAME ACTIVITY VARIABLE VALUES TO ITS DESCRIPTION - Loop through every row and change the value of Activity colmn of data frame with corresponding description
* LOAD PLR LIBRARY - To group the final data frame by Subject and Activity
* GROUP THE DATAFRAME BY SUBJECT AND ACTIVITY AND APPLY AVERAGE ( MEAN ) FUNCTION - passing group by column and function to apply ( mean ) to ddply function
* STORE THE RESULT IN A TEXT FILE



CODE BOOK
Generate a Code Book describing the variables, the data, and any transformations or 
work performed to clean up the data.

1. Load the necessary Libraries
library(dplyr)
library(tidyr)

2. Create directory if none exists and get ZIP file from website 
"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip" and unZIP the file

3. Read (read.table) the unZIPed training and testing tables plus 
the features and activity vectors into their respective variables: 
test.x, train.x, test.y, train.y, test.subject, train.subject, features and activity.

4. Merge the training and testing tables into subject, activity and 
features data frames and assign the variable names “subject”, “activity” and 
the values from the features vector.

5. Column bind the subject, activity and feature tables into one data 
frame then get just the standard deviation and mean variables.

6. Assign descriptive variable names and create the Tidy data file.

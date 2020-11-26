# Getting and Cleaning Data Project Assignment

This is the assignment for the 'Getting and Cleaning Data' course.  The provided
R script will take the raw dataset provided with the course instructions and perform
various steps to create a tidy data set.

The output is a file containing summarized data by Activity and Subject.
The summarized data shows the mean (average) of each requested measurement - mean
and standard deviatons of the original measurements.  There is a data row for
each Activity and Subject compbination: 180 rows (6 Activities for 30 Subjects).

## Usage

The process should be executed using the following steps:

1) Download the data file from the Coursera project or by clicking [here](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip).  The file should be named as follows: 'getdata-projectfiles-UCI HAR Dataset.zip'
2) Unzip the file to your working directory.  You should then have a folder within your working directory named as follows: 'UCI HAR Dataset'
3) It should be noted that the R script to be run below makes use of the dplyr package.  So, that package must be installed.  You can use the following command to see if the package is already installed:
```
is.element("dplyr", installed.packages()[,1])
```
4) If TRUE is returned in the previous step, the package is installed - proceed to the next step.  If FALSE is returned, the package is not intalled and will need to be installed.  Run the following command to install the dplyr package:
```
install.packages("dplyr")
```
5) Run the R code contained in the following file: 'run_analysis.R'
6) A file named 'Samsung-SummarizedData.txt' should be written to your working directory.  This is the tidy data set referenced above.

## Evalution of Results
To evaluate the resulting data, use the following code to load this data into R:
```
peerReviewData <- read.table("Samsung-SummarizedData.txt", header = TRUE)
View(peerReviewData)
```
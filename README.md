Getting-and-Cleaning-Data
=========================

Course Project


Unzip the source ( https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip )

into a folder on your local drive, say C:\Users\yourname\Documents\R\

Put run_analysis.R to C:\Users\yourname\Documents\R\UCI HAR Dataset\

in RStudio: setwd("C:\\Users\\yourname\\Documents\\R\\UCI HAR Dataset\\")

and then: source("run_analysis.R")

The latter will run the R script, it will read the dataset and write these files:

merged_clean_data.txt -- 8.35 Mb, a 10299x68 data frame

tidy_data_set_with_the_averages.txt -- 0.225 Mb, a 180x68 data frame

The script takes about ~30 seconds to complete, although, it depends on your system configuration.

Use data <- read.table("tidy_data_set_with_the_averages.txt") to read the latter. It's dimension is 180x68 where 180=30(subjects)*6(activities). 

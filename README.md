Getting and Cleaning Data - Course Project


The github project contains three files:

run_analysis.R -- a script that generates tidy dataset: tidy.txt
CodeBook.md -- a markdown file that explains the variables included in the above datasets
readme.md -- a markdown file that primarily explains how the run_analysis.R script works


The R script - run_analysis.R does the following: 

* Load the test, train , activity, subject and feature data
* set the column names to the datasets.
* Merges the test and train datsets along with subject and activity vectors.
* Fetch only the SD and mean columns from the merge dataset.
* creates a tidy dataset with the average value of each variable for subject and activity.
* write the tidy dataset to a new file called Tidy.txt


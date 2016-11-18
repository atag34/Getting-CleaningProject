Script for COursera Course: Getting and Cleaning Data, Course Projects

script: run_analysis.R


The script will look in the current working directory for file "UCIHAR_Dataset.zip". If the file does not exist, it will download and unzip the required documents for running the rest of the script.

It will then begin pulling the various .txt tables from the file and organizing them into a Train and Test data table. It then combines the tables and cleans the column headers(removes special characters and forces all letter to lower-case.

It then creates the desired Tidy Data Set by creating a Table, grouping the data by activity type and then subject, and calculating the mean of every variable for these groups.

It will then create a .txt table withiout row names and save it to the current working directory.
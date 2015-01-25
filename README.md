# tidydatacoursera
=========
Course project for Getting and Cleaning Data course on Coursera, part of the Data Science specialization.
=========
## README

This repo contains the course project for the Getting and Cleaning Data course on Coursera, part of the Data Science Specialization. Additional information on the course and specialization is available at: https://www.coursera.org/specialization/jhudatascience/1/courses

The project involves the loading, merging, cleaning, and summarizing of training and test data sets on human activity collected by accelerometers. The data is from the UCI Machine Learning repository, with additional information available at: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

The following files are included in the repo:
* run_analysis.R - this R script contains the run_analysis() function which performs all of the processing of the data sets.
* CodeBook.md - this MarkDown file describes the variables returned by run_analysis() as well as the processing steps performed in the function.
* tidy_data.txt - the tidy data set output by the run_analysis() function.
* This README file.

=========
## Project Description

This is a copy of the project description from the Getting and Cleaning data course page on Coursera, obtained on 01/25/2015. It was accessed at: https://class.coursera.org/getdata-010/human_grading/view/courses/973497/assessments/3/submissions

### Project Description Start

The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis. You will be graded by your peers on a series of yes/no questions related to the project. You will be required to submit: 1) a tidy data set as described below, 2) a link to a Github repository with your script for performing the analysis, and 3) a code book that describes the variables, the data, and any transformations or work that you performed to clean up the data called CodeBook.md. You should also include a README.md in the repo with your scripts. This repo explains how all of the scripts work and how they are connected.  

One of the most exciting areas in all of data science right now is wearable computing - see for example this article . Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained: 

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

Here are the data for the project: 

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

 You should create one R script called run_analysis.R that does the following. 
Merges the training and the test sets to create one data set.
Extracts only the measurements on the mean and standard deviation for each measurement. 
Uses descriptive activity names to name the activities in the data set
Appropriately labels the data set with descriptive variable names. 
From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

Good luck!

### Project Description End

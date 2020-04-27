## Code Book

This code book was created to provide informations about the dataset in this repository. It describes variables, data and modifications on the original dataset. You can check R script "run_analysis.R" for more information. 

Three packages are required: `data.table`, `reshape2`and `dplyr`. If you still don't have these packages installed in your machine you can adapt the script with another similar packages and functions. However, modifying packages will result in significant changes on the original script. 

### 1. Read Data

- **X_test**:  values of variables in test
- **y_test**: activity ID in test.
- **subject_test**: subject IDs for test.

- **X_train**:  values of variables in train
- **y_train**: activity ID in train
- **subject_train**: subject IDs for train 

- **activity_labels**: description of activity IDs in y_test and y_train 
- **features**: description of each variables in both X_test and X_train
- **Merged_Data**: bind of X_test and X_train
____
### 2. Extracting only the measurements on the mean and standard deviation for each measurement. 

A new vector was created in order to subset *Merged_Data*. Its name is *extract_features*. This vector contains only mean and standard deviation labels extracted from the second column of *features* document. 
___

### 3. Using descriptive activity names to name the activities in the dataset
this step was inspired by the instructions of Kosamari (2014). Her suggestion was to create a "cleaning vector" for *features* names. This vector removes "()" at the end of names and rename Merged_Data's column labels.  

- *cleanFNames*: a vector of "clean" feature names.
____
### 4. Combining subject, activity, mean and std in only dataset:
Combine *test* and *train* data of subject and activity, then give descriptive labels. Then, bind this new combination with *Merged_Data*. At the end of this step, *Merged_Data* has 2 additonal columns: 'subject' and 'activity'. 

____
### 5. Renaming labels of levels with activity_levels and applying it to *Merged_Data*
Group the activity column of dataSet as "activity_ID". Rename each levels with 2nd column of activity_labels. Finally apply the renamed "activity_ID" to Merged_Data's activity column.

____
### 6. Tidy data set with the average of each variable for each activity and each subject.
In this final part, Merged_Data was melted to create tidy data. The output of data was named as "tidy_data.txt".  

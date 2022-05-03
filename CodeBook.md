# Adapted Code Book

The following description has been adapted according to the modifications performed by the submission's script.

## Abstract: 

Human Activity Recognition database built from the recordings of 30 subjects performing activities of daily living (ADL) while carrying a waist-mounted smartphone with embedded inertial sensors.

## Source:

Jorge L. Reyes-Ortiz(1,2), Davide Anguita(1), Alessandro Ghio(1), Luca Oneto(1) and Xavier Parra(2)
1 - Smartlab - Non-Linear Complex Systems Laboratory DITEN - Università degli Studi di Genova, Genoa (I-16145), Italy.
2 - CETpD - Technical Research Centre for Dependency Care and Autonomous Living Universitat Politècnica de Catalunya (BarcelonaTech). Vilanova i la Geltrú (08800), Spain activityrecognition@smartlab.ws

## Data Set Information:

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset was first randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data and then bind together in a single tidy data set.

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain.

Check the README.txt file for further details about this dataset.

## Attribute Information:

For each record in the dataset it is provided:
- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
- Triaxial Angular velocity from the gyroscope.
- A 561-feature vector with time and frequency domain variables.
- Its activity label.
- An identifier of the subject who carried out the experiment.


## Transformations performed on original data set to make it tidy

The data set was tidied by the script run_analysis.R which executes the following steps

STEP 0. Download tables to computer and load tables on R with read.table.
   - features (561 observations of 2 variables): List of all features.
   - activities (6 observations of 2 variables): Links the activity ID with their activity name.
   - subject_train (7352 observations of 1 variable): Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30.
   - x_train (7352 observations of 561 variables): Training set.
   - y_train (7352 observations of 1 variable): Training labels.    
   - subject_test (2947 observations of 1 variable): Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30.
   - x_test (2947 observations of 561 variable): Test set.
   - y_test (2947 observations of 1 variable): Test labels. 
  
### STEP 1. Merge the training and the test sets to create one data set.

Bind training and test tables of labels (y), datasets (x) and subject ids (subject) by row with rbind then bind columns of the 3 resulting tables to form a single data set named All_Data with cbind.

### STEP 2. Extract only the measurements on the mean and standard deviation for each measurement.

First identify which features are means or standard deviation from the features' labels using grep. Then filter the columns from All_Data to get the Tidy_Data table which contains the desired columns.

### STEP 3. Set descriptive activity names to name the activities in the data set. 

The type of activity on the Tidy_Data table are identified with numbers on the column named code. with the filter attached we change the number ID to its corresponding activity name (WALKIN, STANDING, Etc.)

### STEP 4. Label the data set with descriptive variable names.

To improve the variables' names to make them descriptive, several abbreviations were changed to the full word, special caracters were eliminated and an error was fixed as discribed:

* mean()     was changed to Mean
* std()      was changed to SD
* freq()     was changed to Frequency
* meanFreq() was changed to MeanFrequency

* Acc        was changed to Accelerometer
* Gyro       was changed to Gyroscope
* Mag        was changed to Magnitude
* leading t  was changed to Time
* leading f  was changed to Frequency
* BodyBody   was changed simply to Body

All changes were made with gsub on a vector with the variables' names and then were assigned to the names of the variables of the Tidy_Data table.

### STEP 5. Create new tidy data set with the average of each variable for each activity and each subject.

A new tidy data set was created with chained functions which included the means of each activity and subject. 

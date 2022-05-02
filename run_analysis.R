library(dplyr)

##############################################################################
# STEP 0. Download tables on computer and load tables on R. ##################
##############################################################################

Directorio<-"C:/Users/usuario/Desktop/TEMPORAL/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset"

features      <- read.table(paste0(Directorio,"/features.txt"),             col.names = c("n","functions"))
activities    <- read.table(paste0(Directorio,"/activity_labels.txt"),      col.names = c("code", "activity"))
subject_test  <- read.table(paste0(Directorio,"/test/subject_test.txt"),   col.names = "subject")
x_test        <- read.table(paste0(Directorio,"/test/X_test.txt"),         col.names = features$functions)
y_test        <- read.table(paste0(Directorio,"/test/y_test.txt"),         col.names = "code")
subject_train <- read.table(paste0(Directorio,"/train/subject_train.txt"), col.names = "subject")
x_train       <- read.table(paste0(Directorio,"/train/X_train.txt"),       col.names = features$functions)
y_train       <- read.table(paste0(Directorio,"/train/y_train.txt"),       col.names = "code")

#################################################################################
# STEP 1. Merge the training and the test sets to create one data set. ##########
#################################################################################

x_both       <-rbind(x_train,x_test)
y_both       <-rbind(y_train,y_test)
subject_both <-rbind(subject_train,subject_test)
All_Data     <-cbind(subject_both,x_both,y_both)

##########################################################################################################
# STEP 2. Extract only the measurements on the mean and standard deviation for each measurement. #########
##########################################################################################################

Cols             <- grep("-(mean|std).*", as.character(features[,2]))
Tidy_Data        <- All_Data[c(1,563,Cols+1)]

###########################################################################################
# STEP 3. Set descriptive activity names to name the activities in the data set. ##########
###########################################################################################

Tidy_Data$code   <-activities[Tidy_Data$code,2]

#############################################################################
# STEP 4. Label the data set with descriptive variable names. ###############
#############################################################################

ColsNames        <- features$functions[Cols]
ColsNames <- gsub("mean\\(\\)", "Mean", ColsNames, ignore.case = TRUE)
ColsNames <- gsub("std\\(\\)", "SD", ColsNames, ignore.case = TRUE)
ColsNames <- gsub("meanFreq\\(\\)", "MeanFrequency", ColsNames, ignore.case = TRUE)
ColsNames <- gsub("freq\\(\\)", "Frequency", ColsNames, ignore.case = TRUE)

ColsNames <- gsub("Acc", "Accelerometer", ColsNames)
ColsNames <- gsub("Gyro", "Gyroscope", ColsNames)
ColsNames <- gsub("Mag", "Magnitude", ColsNames)
ColsNames <- gsub("^t", "Time", ColsNames)
ColsNames <- gsub("^f", "Frequency", ColsNames)
ColsNames <- gsub("BodyBody", "Body", ColsNames)

names(Tidy_Data) <- c("subject","activity",ColsNames)

##############################################################################################################
# STEP 5. Create new tidy data set with the average of each variable for each activity and each subject. ####
##############################################################################################################

New_Tidy_Data <- Tidy_Data %>%
  group_by(subject, activity) %>%
  summarize_all(funs(mean))

write.table(New_Tidy_Data, "New_Tidy_Data.txt", row.name=FALSE)



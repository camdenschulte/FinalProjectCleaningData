run_analysis.R runs and completes the following tasks 

The dataset was downloaded under the folder called UCI HAR Dataset

Data was assigned to different variables

features <- features.txt
The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ.
activity_labels <- activity_labels.txt
List of activities performed when the corresponding measurements were taken and its labels
Testsubject <- test/subject_test.txt
test data of 9 volunteer test subjects being observed
xTest <- test/X_test.txt
recorded features of test data
yTest <- test/y_test.txt
test data of activities' code labels
Trainsubject <- test/subject_train.txt
train data of 21 volunteer subjects being observed
xTrain <- test/X_train.txt
recorded features of train data
yTrain <- test/y_train.txt
contains train data of activities’code labels

Merge training and test datasets
x : merge xTrain and xTest using rbind() 
y : merge yTrain and yTest using rbind() 
subjects: merge Trainsubject and Testsubject using rbind() 
data: merge subjects, x and y using cbind()

Get measurements with only mean and std. deviation
cleandata : subset data, with columns: subject, numbers and measurements inlcuding "mean" or "std"

Describe activities in data set
Entire numbers in numbers column of the cleandata replaced with corresponding activity

Give descriptive variable names
Activity column in cleandata renamed into numbers
Abbreviations replaced with full names as shown below
All Acc in column’s name replaced by Accelerometer
All Gyro in column’s name replaced by Gyroscope
All BodyBody in column’s name replaced by Body
All Mag in column’s name replaced by Magnitude
All start with character f in column’s name replaced by Frequency
All start with character t in column’s name replaced by Time

Second tidy set created with average of each variable for each activity and subject
seconddataset created by grouping by variable and subject and averaging across all variables
Export seconddtaset into Final.txt file

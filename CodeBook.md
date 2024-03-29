==========
Analysis by George Tryfiates
==========
- The two datasets were joined (X_train.txt & X_test.txt) such that only the features of mean and standard deviation were retained from the Triaxial acceleration from the accelerometer (total acceleration).
- The 561-feature vector was thereby reduced to 79-features
- The new dataset averaged the observations for each subject (30 subjects) by each activity (6 activities)
- Each record also includes the subject label and an identifier for the subject who carried out the experiment
- The new dataset is 180 rows x 81 columns




License:
========
Use of this dataset in publications must be acknowledged by referencing the following publication [1] 

[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

This dataset is distributed AS-IS and no responsibility implied or explicit can be addressed to the authors or their institutions for its use or misuse. Any commercial use is prohibited.

Jorge L. Reyes-Ortiz, Alessandro Ghio, Luca Oneto, Davide Anguita. November 2012.

#' This is an introduction to the caret R package from the link 
#' (https://www.machinelearningplus.com/machine-learning/caret-package/). 
#' We will be using a dataset on two orange juice brands to predict what product 
#' a customer would buy in the future


#required packages
# 
# install.packages(c('caret', 
#                    'skimr'
#                    , 'RANN'
#                    , 'randomForest'
#                    , 'fastAdaboost'
#                    , 'gbm'
#                    , 'xgboost'
#                    , 'caretEnsemble'
#                    , 'C50'
#                    , 'earth')
#                  )


# The caret package ----

library(caret)

# The orange juice customer data file ----
orange <- read.csv('https://raw.githubusercontent.com/selva86/datasets/master/orange_juice_withmissing.csv')
# View(orange)


#' this is not part of the tutorial but I want to save the data in case it becomes
#' unavailable in the future
# write.csv(orange, file = '../../../data/orange_juice_customer_data.csv')


# Test and training sets ----
#' split the data into 80% training and 20% test sets

set.seed(1)
# Step 1: Get row numbers for the training data
trainset_row_numbers <- createDataPartition(orange$Purchase, p = 0.8, list = F)

# Step 2: Create the training  dataset
training_data <- orange[trainset_row_numbers, ]

# Step 3: Create the test dataset
testing_data <- orange[-trainset_row_numbers, ]

# let's store the predictor and response variables
response_var <- training_data$Purchase
predictor_vars <- training_data[2:ncol(training_data), ]


# Descriptive statistics

library(skimr)
skimmed <- skim_to_wide(training_data)

skimmed[, c(1:5, 9:11, 13, 15:16)] #choose to view certain variables of the output

# Missing value imputation with k-nearest neigbor prediction ----

# The missing values model ====
missing_data_model <- preProcess(training_data, method = 'knnImpute')
missing_data_model

# Input the missing values using the model on itself ====
library('RANN')

training_data_inputed <- predict(missing_data_model, newdata = training_data)
training_data_inputed
anyNA(training_data_inputed) #check if there are any NAs anywhere in the data


# One-hot encoding ----
# Creating dummy variables ====
#' That is, converting a categorical variable to as many 
#' binary variables as there are categories.
dummies_model <- dummyVars(Purchase ~ ., data = training_data)
dummies_model

#' Create the dummy variables using predict. The Response variable (Purchase) will not 
#' be present in the result, hence, the warning message.
training_data_matrix <- predict(dummies_model, newdata = training_data)
training_data_df <- as.data.frame(training_data_matrix)
str(training_data_df)


# Data transformation (as needed) ----'
#' There are many transformation functions in the caret package that can be used
#' based on the desired transformation but here, we'll use the range option to
#' transform the data to be between 0 and 1.
#' 
preProcess_range_model <- preProcess(training_data_df, method = 'range')
training_data <- predict(preProcess_range_model, newdata = training_data_df)

# Append the Response variable
training_data$Purchase <- response_var

#' Check that the transformation worked

apply(training_data[, 1:10], 2, FUN = function(x){c('min' = min(x), 'max' = max(x))})

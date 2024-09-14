# Load necessary libraries
library(dplyr)      # For data manipulation
library(ggplot2)    # For data visualization
library(caret)      # For machine learning models and evaluation

# Step 1: Data Preprocessing
# Load the dataset
telecom_data <- read.csv("telecom_data.csv")

# Handle missing values
telecom_data <- telecom_data %>% 
  na.omit()

# Encode categorical variables
telecom_data <- telecom_data %>% 
  mutate_if(is.character, as.factor)

# Feature scaling (optional)
# telecom_data$numeric_variable <- scale(telecom_data$numeric_variable)

# Step 2: Exploratory Data Analysis (EDA)
# Summary statistics
summary(telecom_data)

# Visualizations
# Example: Histogram of call duration
ggplot(telecom_data, aes(x = call_duration)) +
  geom_histogram(fill = "blue", bins = 30) +
  labs(title = "Histogram of Call Duration")

# Step 3: Model Building
# Split data into training and testing sets
set.seed(123) # for reproducibility
train_index <- createDataPartition(telecom_data$churn_status, p = 0.8, list = FALSE)
train_data <- telecom_data[train_index, ]
test_data <- telecom_data[-train_index, ]

# Train machine learning models
# Example: Logistic Regression
model <- train(churn_status ~ ., data = train_data, method = "glm", trControl = trainControl(method = "cv", number = 5))
print(model)

# Step 4: Model Evaluation
# Predictions on test data
predictions <- predict(model, newdata = test_data)

# Evaluate performance
confusionMatrix(predictions, test_data$churn_status)

# Step 5: Model Deployment (Optional)
# Once satisfied with the model, deploy it into production to predict churn for new customers.

# Conclusion: Summarize findings and insights from the project.


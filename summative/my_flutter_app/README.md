# my_flutter_app

## Body Temperature Prediction App
This project is a Flutter application that integrates with a publicly available API to predict body temperature based on user input. The API endpoint is hosted on a publicly routable URL and can be tested using Swagger UI.

## Features
# User Input: 
Collects input values for Age, SystolicBP, DiastolicBP, Blood Glucose, and Heart Rate.

# API Integration: 
Sends the input values to a publicly available API endpoint for prediction.

# Prediction Display:
Displays the predicted body temperature or an error message if something goes wrong.

# Validation:
Ensures all input fields are filled before making a prediction.

## API Endpoint
The API endpoint used for predictions is publicly available and can be accessed via the following URL:


'''https://linear-regression-model-10-l1dl.onrender.com/predict'''
Swagger UI
You can test the API using Swagger UI at:

Copy
https://linear-regression-model-10-l1dl.onrender.com/docs#/default/predict_predict_post
API Request and Response
Request
Method: POST

URL: https://linear-regression-model-10-l1dl.onrender.com/predict

Headers:

json
Copy
{
  "Content-Type": "application/json"
}
Body:

json
Copy
{
  "Age": 22,
  "SystolicBP": 120,
  "DiastolicBP": 80,
  "Blood_glucose": 90,
  "HeartRate": 70
}
Response
Success:

json
Copy
{
  "predicted_body_temperature": 98
}
Error:

json
Copy
{
  "error": "Invalid input"
}
How to Use the App
Prerequisites
Flutter SDK installed on your machine.

An IDE (e.g., Android Studio, VS Code) with Flutter and Dart plugins.

Steps to Run the App
Clone the repository:

bash
Copy
git clone https://github.com/your-username/your-repo-name.git
cd your-repo-name
Install dependencies:

bash
Copy
flutter pub get
Run the app:

bash
Copy
flutter run
Use the app:

Enter values for Age, SystolicBP, DiastolicBP, Blood Glucose, and Heart Rate.

Click the Predict button to see the predicted body temperature.

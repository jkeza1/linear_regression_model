# 🌡️ Health Metrics to Body Temperature Prediction System

[![Flutter](https://img.shields.io/badge/Flutter-3.13-blue)](https://flutter.dev)
[![API Status](https://img.shields.io/website?url=https%3A%2F%2Flinear-regression-model-10-l1dl.onrender.com%2Fpredict)](https://linear-regression-model-10-l1dl.onrender.com/predict)
[![Demo Video](https://img.shields.io/badge/2_Min_Demo-YouTube-red)](https://youtu.be/12yGa9exx0s)

## 📌 Overview
This machine learning system predicts human body temperature using key health metrics. By analyzing relationships between vital signs and thermal regulation, it provides accurate temperature forecasts without direct measurement.


## 📌 Project Overview
This system predicts body temperature based on five health parameters:
1. Age (years)
2. Systolic Blood Pressure (mmHg)
3. Diastolic Blood Pressure (mmHg)  
4. Blood Glucose Level (mg/dL)
5. Heart Rate (bpm)

## 🛠️ Technical Components
1. **ML Model**: Random Forest regression (MSE: 0.35)
2. **API**: FastAPI endpoint with Swagger docs
3. **Mobile**: Flutter cross-platform application
 
## 🎥 Video Demo
[![Demo Thumbnail](https://img.youtube.com/vi/12yGa9exx0s/maxresdefault.jpg)](https://youtu.be/12yGa9exx0s)

2-minute demo covering:
- Mobile app prediction
- Swagger UI API testing
- Model performance comparison

## 🔗 Live API Documentation
**Swagger UI**:  
[API Docs][(https://linear-regression-model-10-l1dl.onrender.com/docs#/)]

**Endpoint**:  
`POST https://linear-regression-model-10-l1dl.onrender.com/predict`

**Example Request**:
```json
{
  "Age": 32,
  "SystolicBP": 115,
  "DiastolicBP": 75,
  "Blood_glucose": 89,
  "HeartRate": 72
}

 ## Example Response:
{
  "predicted_body_temperature": 98.34
}



```

## 🛠️ Installation Guide

**Clone repository**:

git clone https://github.com/jkeza1/linear_regression_model.git
cd linear_regression_model

# Run Jupyter notebook
cd summative/linear_regression
jupyter notebook multivariate.ipynb

# Start API
cd ../API
pip install -r requirements.txt
uvicorn prediction:app --reload

# Launch Flutter app
cd ../../my_flutter_app
flutter pub get
flutter run

## 📂 Repository Structure
linear_regression_model/
├── summative/
│   ├── linear_regression/    # Jupyter notebook & dataset
│   ├── API/                  # FastAPI implementation
│   └── my_flutter_app/           # Mobile application
└── README.md

## License


This version:
1. Uses simple Markdown formatting
2. Includes all required sections
3. Provides clear installation steps
4. Shows API documentation
5. Links to demo video
6. Maintains clean file structure

You can copy and paste this directly into your README.md file. All technical details are included while keeping it concise and easy to read.

MIT License © 2023 Joan Keza

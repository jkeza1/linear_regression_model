# linear_regression_model

# Body Temperature Prediction System

![App Demo](https://img.shields.io/badge/Demo-YouTube-red) ![API Status](https://img.shields.io/badge/API-Live-brightgreen) ![Flutter](https://img.shields.io/badge/Flutter-3.13-blue)

A complete system for predicting body temperature using health metrics, featuring:
- Machine Learning model (Notebook)
- Flask API backend
- Flutter mobile application

## 📺 Video Demo

[![Watch the Demo](https://img.youtube.com/vi/12yGa9exx0s/maxresdefault.jpg)](https://youtu.be/12yGa9exx0s)

*Click the image above to watch the 2-minute demo video*

## 🔌 API Endpoint

**Live Prediction API**:  
`https://linear-regression-model-10-l1dl.onrender.com/predict`

**Interactive Documentation**:  
[Swagger UI](https://linear-regression-model-10-l1dl.onrender.com/docs)

**Example Usage**:
```bash
curl -X POST "https://linear-regression-model-10-l1dl.onrender.com/predict" \
-H "Content-Type: application/json" \
-d '{"Age":35,"SystolicBP":118,"DiastolicBP":76,"Blood_glucose":92,"HeartRate":68}'



🌡️ Health Metrics to Body Temperature Prediction System
Flutter
Python
API Status
Demo Video

📌 Table of Contents
Project Overview

Video Demo

Live API

Installation Guide

Project Structure

Model Development

API Implementation

Flutter App

License

🎯 Project Overview
This system predicts body temperature based on five health parameters using machine learning:

Age (years)

Systolic Blood Pressure (mmHg)

Diastolic Blood Pressure (mmHg)

Blood Glucose Level (mg/dL)

Heart Rate (bpm)

The project implements:

Linear regression model trained on health metrics

Production API with FastAPI

Cross-platform Flutter mobile app

🎥 Video Demo
Demo Thumbnail

2-minute demo covering:

Mobile app prediction workflow

Swagger UI API testing

Model performance comparison

🔗 Live API Documentation
Interactive API Docs:
Swagger UI

Prediction Endpoint:
POST https://linear-regression-model-10-l1dl.onrender.com/predict

Example Request:

json
Copy
{
  "Age": 32,
  "SystolicBP": 115,
  "DiastolicBP": 75,
  "Blood_glucose": 89,
  "HeartRate": 72
}
Example Response:

json
Copy
{
  "predicted_body_temperature": 98.34,
  "confidence": 0.92
}
🛠️ Installation Guide
1. Clone Repository
bash
Copy
git clone https://github.com/yourusername/health-temperature-prediction.git
cd health-temperature-prediction
2. Model Development (Jupyter Notebook)
bash
Copy
cd linear_regression_model/summative/linear_regression
jupyter notebook multivariate.ipynb
3. API Setup
bash
Copy
cd ../API
python -m venv venv
source venv/bin/activate  # Linux/Mac
venv\Scripts\activate     # Windows
pip install -r requirements.txt
uvicorn prediction:app --reload
4. Flutter App
bash
Copy
cd ../../FlutterApp
flutter pub get
flutter run

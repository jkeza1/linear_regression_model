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

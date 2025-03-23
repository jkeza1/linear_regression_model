from fastapi import FastAPI, HTTPException
from pydantic import BaseModel, confloat, conint
import joblib
import numpy as np
import pandas as pd
from fastapi.middleware.cors import CORSMiddleware
import os  # Import the os module for path handling

# Load the best model
BASE_DIR = os.path.dirname(os.path.abspath(__file__))

# Construct the absolute path to the model file
model_path = os.path.join(BASE_DIR, "../linear_regression/best_model.pkl")

# Load the trained model
try:
    model = joblib.load(model_path)
except Exception as e:
    raise RuntimeError(f"Failed to load the model from {model_path}. Error: {e}")

# Define the input data model using Pydantic
class PredictionInput(BaseModel):
    Age:int  # Age must be between 18 and 100
    SystolicBP: int  # Systolic BP must be between 80 and 200
    DiastolicBP: int  # Diastolic BP must be between 60 and 120
    Blood_glucose: float # Blood glucose must be between 70.0 and 200.0
    HeartRate: int # Heart rate must be between 60 and 120

# Initialize FastAPI app
app = FastAPI(
    title="Body Temperature Prediction API",
    description="API for predicting body temperature using a trained DecisionTreeRegressor model."
)

# Add CORS middleware
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],  # Allows all origins
    allow_credentials=True,
    allow_methods=["*"],  # Allows all methods
    allow_headers=["*"],  # Allows all headers
)

# Define the prediction endpoint
@app.post("/predict")
def predict(input_data: PredictionInput):
    try:
        # Convert input data to a DataFrame
        input_dict = input_data.dict()
        input_df = pd.DataFrame([input_dict])

        # Rename columns to match the model's training data
        input_df.columns = ['Age', 'SystolicBP', 'DiastolicBP', 'Blood glucose', 'HeartRate']

        # Make prediction
        prediction = model.predict(input_df)[0]

        # Return the prediction
        return {"predicted_body_temperature": float(prediction)}
    except Exception as e:
        raise HTTPException(status_code=400, detail=str(e))

# Run the API
#if __name__ == "__main__":
    #import uvicorn
    #uvicorn.run(app, host="0.0.0.0", port=8000)
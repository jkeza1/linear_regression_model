from fastapi import FastAPI 
from pydantic import BaseModel, Field 
import joblib
import numpy as np 
from typing import List
from fastapi.middleware.cors import CORSMiddleware # type: ignore

# Load the trained model
model = joblib.load("summative/linear_regression/risk_level_model.pkl)")

# Define the input data model (request body)
class PredictionRequest(BaseModel):
    age: int
    systolic_bp: int
    diastolic_bp: int
    blood_glucose: float
    body_temp: float
    heart_rate: int

# Create FastAPI app
app = FastAPI()

# Add CORS middleware to allow cross-origin requests
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],  # Allow all origins (You can restrict this to specific URLs)
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# Define prediction endpoint
@app.post("/predict")
async def predict(request: PredictionRequest):
    # Extract input data from the request
    input_data = np.array([
        [request.age, request.systolic_bp, request.diastolic_bp, request.blood_glucose, request.body_temp, request.heart_rate]
    ])
    
    # Make prediction using the model
    prediction = model.predict(input_data)[0]
    
    # Return the prediction result
    return {"predicted_risk_level": int(prediction)}

# Run the app (use uvicorn to serve the FastAPI app in development)
# To run locally: uvicorn main:app --reload

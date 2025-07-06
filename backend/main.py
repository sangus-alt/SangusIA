import json
import os
from fastapi import FastAPI
from pydantic import BaseModel

MODEL_FILE = "selected_model.json"
DEFAULT_MODEL = "llama3"

def load_model():
    if os.path.exists(MODEL_FILE):
        with open(MODEL_FILE, "r") as f:
            return json.load(f).get("model", DEFAULT_MODEL)
    return DEFAULT_MODEL

def save_model(model):
    with open(MODEL_FILE, "w") as f:
        json.dump({"model": model}, f)

app = FastAPI()
app.state.current_model = load_model()

class ModelSelectRequest(BaseModel):
    model: str

@app.post("/select-model")
def select_model(req: ModelSelectRequest):
    app.state.current_model = req.model
    save_model(req.model)
    return {"message": f"Modèle IA changé pour {req.model}"}

@app.get("/current-model")
def current_model():
    return {"model": app.state.current_model}
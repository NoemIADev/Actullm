#!/bin/bash
echo "Starting ActuLLM..."

python -m pip install --upgrade pip
pip install -r requirements.txt

uvicorn api_front:app --host 0.0.0.0 --port 8002 &
uvicorn C3:app --host 0.0.0.0 --port 8004 &
uvicorn Api_LLM:app --host 0.0.0.0 --port 8005 &

streamlit run app.py --server.port $PORT --server.address 0.0.0.0
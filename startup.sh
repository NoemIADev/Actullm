#!/bin/bash
echo "Starting ActuLLM..."

python -m pip install --upgrade pip
pip install -r requirements.txt

echo "Starting api_front..."
python -m uvicorn api_front:app --host 0.0.0.0 --port 8002 &

echo "Starting C3..."
python -m uvicorn C3:app --host 0.0.0.0 --port 8004 &

echo "Starting LLM gateway..."
python -m uvicorn Api_LLM:app --host 0.0.0.0 --port 8005 &

echo "Starting Streamlit..."
streamlit run app.py --server.port $PORT --server.address 0.0.0.0
streamlit run app.py --server.port $PORT --server.address 0.0.0.0
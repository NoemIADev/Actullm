#!/bin/bash
set -e

echo "Starting ActuLLM..."

# Port Azure fourni par App Service, sinon 8501 en local
export PORT=${PORT:-8501}

# --- CHROMA DESACTIVE POUR EVITER LE CRASH SQLITE ---
echo "Skipping ChromaDB startup (disabled for demo)..."
# chroma run --path /app/ma_bdd --host 0.0.0.0 --port 8000 &

# --- API ARTICLES ---
echo "Starting articles API on 8001..."
python -m uvicorn Api_add_articles:app --host 0.0.0.0 --port 8001 &

# --- API FRONT ---
echo "Starting api_front on 8002..."
python -m uvicorn api_front:app --host 0.0.0.0 --port 8002 &

# --- VECTORISATION DESACTIVE ---
echo "Skipping vectorization script C3..."
# python C3.py

# --- API RAG ---
echo "Starting RAG API C2 on 8004..."
python -m uvicorn C2:app --host 0.0.0.0 --port 8004 &

# --- API LLM ---
echo "Starting LLM gateway on 8005..."
python -m uvicorn Api_LLM:app --host 0.0.0.0 --port 8005 &

# --- FRONT STREAMLIT ---
echo "Starting Streamlit on $PORT..."
exec streamlit run streamlit_app.py --server.port $PORT --server.address 0.0.0.0
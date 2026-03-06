uvicorn Api_add_articles:app --host 0.0.0.0 --port 8001 --reload & \
uvicorn api_front:app --host 0.0.0.0 --port 8002 --reload & \
uvicorn C3:app --host 0.0.0.0 --port 8004 --reload & \
uvicorn Api_LLM:app --host 0.0.0.0 --port 8005 --reload & \
streamlit run app.py --server.port 8501
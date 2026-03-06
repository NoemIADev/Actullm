# db.py
__import__("pysqlite3")
import sys
sys.modules["sqlite3"] = sys.modules.pop("pysqlite3")
import chromadb

def connect_collection(
    name: str = "News",
    host: str = "localhost",
    port: int = 8000,
):
    client = chromadb.HttpClient(host=host, port=port)
    collection = client.get_or_create_collection(name=name)
    return collection

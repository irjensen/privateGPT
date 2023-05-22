import os
from dotenv import load_dotenv
from langchain.embeddings import HuggingFaceEmbeddings
load_dotenv()
HuggingFaceEmbeddings(model_name=os.environ.get('EMBEDDINGS_MODEL_NAME'))
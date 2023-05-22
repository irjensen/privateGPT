# Using official Python base image
FROM python:3.10-slim-buster

# Setting working directory
WORKDIR /privateGPT

# Install C++ compiler for Python packages that may need it
RUN apt-get update && apt-get install -y \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# Add requirements.txt before rest of repo for caching
ADD requirements.txt /privateGPT

# Install Python dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy everything into the container
COPY . /privateGPT

# Downloading the model
ADD https://huggingface.co/eachadea/ggml-vicuna-13b-1.1/resolve/main/ggml-vic13b-q5_1.bin /privateGPT/models/ggml-vic13b-q5_1.bin

# Copy example.env to .env
RUN cp example.env .env

# load the embeddings
RUN python3 load_huggingface_embeddings.py

# Default command to run when starting a container with this image
CMD [ "/bin/bash" ]
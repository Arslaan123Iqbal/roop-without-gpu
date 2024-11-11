# Use a lightweight Python base image
FROM python:3.10-slim

# Set the working directory
WORKDIR /app

# Copy the requirements file first to leverage Docker caching
COPY requirements.txt .

# Install system dependencies and ffmpeg
RUN apt-get update && \
    apt-get install -y ffmpeg git && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Upgrade pip and install Python dependencies
RUN pip install --upgrade pip && \
    pip install --no-cache-dir -r requirements.txt

# Copy the application code
COPY . .

# Set environment variables
ENV GRADIO_SERVER_NAME="0.0.0.0"

# Expose the port the app runs on
EXPOSE 7860

# Command to run the application
ENTRYPOINT ["python", "./run.py"]
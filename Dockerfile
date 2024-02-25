# Use Python 3.9 base image
FROM python:3.9

# Set environment variables
ENV PYTHONUNBUFFERED 1
ENV LANG C.UTF-8
ENV LC_ALL C.UTF-8

# Install system dependencies
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# Install Microsoft Visual C++ build tools
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    g++ \
    && rm -rf /var/lib/apt/lists/*

# Install CoquiTTS dependencies
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    libogg-dev \
    libflac-dev \
    libvorbis-dev \
    libboost-all-dev \
    && rm -rf /var/lib/apt/lists/*

# Install Go programming language
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    golang \
    && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /app

# Copy project files
COPY . .

# Install Python dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Expose any necessary ports
EXPOSE 8080

# Command to run the application
CMD ["python", "src/main.py"]

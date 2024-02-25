# Use Python Slim as the base image
FROM python:3.9-slim AS python

# Install necessary system dependencies
RUN apt-get update && apt-get install -y \
    git \
    build-essential \
    wget \
    && rm -rf /var/lib/apt/lists/*

# Install Microsoft Visual C++ build tools
RUN wget https://aka.ms/vs/16/release/vs_buildtools.exe && \
    start /wait vs_buildtools.exe --quiet --wait --norestart --nocache --installPath "C:\BuildTools" --add Microsoft.VisualStudio.Workload.VCTools --remove Microsoft.VisualStudio.Component.Windows10SDK.10240 --remove Microsoft.VisualStudio.Component.Windows10SDK.10586 --remove Microsoft.VisualStudio.Component.Windows10SDK.14393 --remove Microsoft.VisualStudio.Component.Windows81SDK && \
    del vs_buildtools.exe

# Install Go programming language
RUN wget https://golang.org/dl/go1.17.6.linux-amd64.tar.gz && \
    tar -C /usr/local -xzf go1.17.6.linux-amd64.tar.gz && \
    rm go1.17.6.linux-amd64.tar.gz

# Set Go environment variables
ENV PATH="/usr/local/go/bin:${PATH}"
ENV GOPATH="/go"
ENV PATH="${GOPATH}/bin:${PATH}"

# Set environment variables for Python
ENV VIRTUAL_ENV=/opt/venv
ENV PATH="$VIRTUAL_ENV/bin:$PATH"

# Create and activate virtual environment
RUN python -m venv $VIRTUAL_ENV

# Set the working directory
WORKDIR /app

# Copy requirements.txt and install Python dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy the source code
COPY . .

# Expose the port for the application
EXPOSE 8000

# Command to run the application
CMD ["uvicorn", "src.main:app", "--host", "0.0.0.0", "--port", "8000", "--reload"]

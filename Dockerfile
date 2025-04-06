FROM ubuntu:18.04

ENV DEBIAN_FRONTEND=noninteractive

WORKDIR /app

# System dependencies
RUN apt-get update && apt-get install -y \
    locales \
    build-essential \
    python3 \
    python3-dev \
    python3-pip \
    python3-lxml \
    curl \
    git \
    wget \
    libssl-dev \
    libffi-dev \
    libpq-dev \
    pv \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Upgrade pip and install Python requirements
RUN pip3 install --upgrade pip setuptools wheel

# Install these first to avoid weird pip failures
RUN pip3 install yarl multidict

# Install Python dependencies
COPY requirements.txt .
RUN pip3 install -r requirements.txt

# Copy your bot code
COPY . /app

# Run the bot
CMD ["python3", "bot.py"]

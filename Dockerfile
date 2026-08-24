FROM node:18-slim

# Install system libraries required by the sharp module
RUN apt-get update && apt-get install -y \
    python3 \
    build-essential \
    libglib2.0-0 \
    libvips-dev \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Copy dependency files first
COPY package*.json ./
RUN npm install

# Copy all remaining repository files
COPY . .

EXPOSE 10000

# Execute the start script
CMD ["npm", "run", "start"]

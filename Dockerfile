FROM node:18-slim

WORKDIR /app

# Copy your core configuration metadata first
COPY package.json ./

# Force NPM to pass through environmental library warnings safely
RUN npm install --no-audit --legacy-peer-deps

# Copy your source code (including src/config.ts) into the workspace
COPY . .

# Globally install typescript and compile the code block
RUN npm install -g typescript
RUN tsc

EXPOSE 10000

# Fire up the compiled launcher file directly
CMD ["node", "launcher.js"]

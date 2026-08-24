FROM node:18-slim

WORKDIR /app

# Copy dependency files
COPY package*.json ./

# Install packages while forcing npm to ignore system-level compilation errors
RUN npm install --errors-only || npm install --legacy-peer-deps

# Copy all remaining repository files (including your updated src/config.ts)
COPY . .

# Install TypeScript globally and compile the project
RUN npm install -g typescript
RUN tsc

EXPOSE 10000

# Execute the start script
CMD ["node", "launcher.js"]

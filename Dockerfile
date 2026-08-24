FROM node:18-slim

WORKDIR /app

# Copy only package.json to the workspace
COPY package.json ./

# Install the clean dependency tree cleanly without strict locks
RUN npm install --no-audit --legacy-peer-deps

# Copy all remaining source files (including your src/config.ts)
COPY . .

# Install typescript globally and build the proxy code
RUN npm install -g typescript
RUN tsc

EXPOSE 10000

# Launch the script directly
CMD ["node", "launcher.js"]

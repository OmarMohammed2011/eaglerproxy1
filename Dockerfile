FROM node:18-slim

WORKDIR /app

# Only copy package.json first (ignoring package-lock.json if it's broken)
COPY package.json ./

# Force npm to install dependencies by omitting auditing and peer conflicts
RUN npm install --no-audit --progress=false --legacy-peer-deps

# Copy all remaining source files (including your src/config.ts)
COPY . .

# Install typescript globally and build the proxy code
RUN npm install -g typescript
RUN tsc

EXPOSE 10000

# Directly launch the entry script using Node
CMD ["node", "launcher.js"]

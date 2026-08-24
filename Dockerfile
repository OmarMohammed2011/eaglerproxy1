# --- STAGE 1: Build the TypeScript code ---
FROM node:18-slim AS builder

WORKDIR /app

# Only copy package.json first to isolate dependency mapping
COPY package.json ./

# Force build by treating warnings as non-breaking and ignoring locks
RUN npm install --no-audit --legacy-peer-deps

# Copy all repository source files into the container
COPY . .

# Install TypeScript globally and transpile your src/config.ts and launchers
RUN npm install -g typescript
RUN tsc

# --- STAGE 2: Run the production application ---
FROM node:18-slim

WORKDIR /app

# Copy over package definitions and the newly compiled production files
COPY package.json ./
RUN npm install --omit=dev --no-audit --legacy-peer-deps

# Bring over everything that was safely compiled from the builder stage
COPY --from=builder /app ./

EXPOSE 10000

# Fire up the compiled launcher file directly
CMD ["node", "launcher.js"]

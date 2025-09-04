# ---- Stage 1: The Builder ----
# This stage installs all dependencies (including dev) and builds the code.
FROM node:18-alpine AS builder

WORKDIR /app

# Copy package files
COPY package*.json ./

# Install all dependencies
RUN npm install

# Copy the rest of the project source code
COPY . .

# Build the TypeScript project
RUN npm run build


# ---- Stage 2: The Final Image ----
# This stage creates the final, lean image for production.
FROM node:18-alpine

WORKDIR /app

# Copy package files again
COPY package*.json ./

# Install ONLY production dependencies
RUN npm install --production

# Copy the compiled code from the 'builder' stage
COPY --from=builder /app/dist ./dist

# Expose the app port
EXPOSE 5000

# Start the app by running the compiled JavaScript directly
# Note: Adjust "dist/index.js" to match your build output file
CMD ["node", "dist/index.js"]
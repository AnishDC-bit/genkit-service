# Use official Node.js LTS image
FROM node:18

# Set working directory
WORKDIR /app

# Copy package.json and package-lock.json
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of the project
COPY . .

# Build TypeScript
RUN npm run build

# Expose the app port
EXPOSE 5000

# Start the app
CMD ["npm", "start"]

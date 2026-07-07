# Use Node 18 as parent image
#FROM node:18

# Change the working directory on the Docker image to /app
#WORKDIR /app

# Copy package.json and package-lock.json to the /app directory
#COPY package.json package-lock.json ./

# Install dependencies
#RUN npm install

# Copy the rest of project files into this image
#COPY . .

# Expose application port
#EXPOSE 3000

# Start the application
#CMD npm start


# ---------- Stage 1: Build ----------
FROM node:18-slim AS builder

WORKDIR /app

COPY package*.json ./

RUN npm install

COPY . .

# If your project requires a build step (React, Angular, TypeScript)
# RUN npm run build

# ---------- Stage 2: Production ----------
FROM node:18-slim

WORKDIR /app

COPY package*.json ./

RUN npm install --omit=dev

COPY --from=builder /app .

EXPOSE 3000

CMD ["npm", "start"]

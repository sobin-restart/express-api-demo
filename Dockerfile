# -------- STAGE 1: Builder --------
FROM node:18-alpine AS builder

# Set working directory
WORKDIR /app

# Copy only package files first (for caching)
COPY package*.json ./

# Install all dependencies including dotenv
RUN npm install

# Now copy the rest of the app source
COPY . .

# -------- STAGE 2: Production --------
FROM node:18-alpine

# (Optional) Install curl — helpful for debugging or health checks
RUN apk add --no-cache curl

# Set working directory in final image
WORKDIR /app

# ✅ Copy only needed runtime files from builder — including node_modules!
COPY --from=builder /app/node_modules ./node_modules
COPY --from=builder /app/package*.json ./
COPY --from=builder /app/index.js ./
#COPY --from=builder /app/.env ./  # Optional: if you need .env in image, or skip if passed via --env-file

# Expose port
EXPOSE 3000

# Start the app
CMD ["node", "index.js"]

# -------- STAGE 1: Builder --------
FROM node:18-alpine AS builder

WORKDIR /app

COPY package*.json ./
RUN npm install

COPY . .

# -------- STAGE 2: Production --------
FROM node:18-alpine

WORKDIR /app

# Copy only the built app, not node_modules
COPY --from=builder /app .

EXPOSE 3000

CMD ["node", "index.js"]

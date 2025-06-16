# -------- STAGE 1: Builder --------
FROM node:18-alpine AS builder

WORKDIR /app

COPY package*.json ./
RUN npm install

COPY . .

# -------- STAGE 2: Production --------
FROM node:18-alpine

WORKDIR /app

# Copy node_modules explicitly
COPY --from=builder /app/node_modules ./node_modules
COPY --from=builder /app/index.js ./index.js
COPY --from=builder /app/package*.json ./
#COPY --from=builder /app/.env ./  # Optional, or use --env-file only

EXPOSE 3000

CMD ["node", "index.js"]

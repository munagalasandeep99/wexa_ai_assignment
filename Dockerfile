# Stage 1: Build the Next.js app
FROM node:20-alpine AS builder
WORKDIR /app
COPY package.json package-lock.json ./
RUN npm ci
COPY . .
RUN npm run build

# Stage 2: Create a minimal production image
FROM node:20-alpine
WORKDIR /app
ENV NODE_ENV=production
# Copy only the necessary files from the builder stage
COPY --from=builder /app/.next ./.next
COPY --from=builder /app/node_modules ./node_modules
COPY --from=builder /app/package.json ./package.json
COPY --from=builder /app/public ./public
# Expose the port Next.js runs on
EXPOSE 3000
# Start the Next.js app
CMD ["npm", "start"]
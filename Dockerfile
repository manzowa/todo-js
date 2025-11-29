# ---- Build Stage ----
FROM node:alpine AS builder

WORKDIR /app

# Copy package files
COPY package.json package-lock.json ./

# Install dependencies
RUN npm ci

# Copy sources
COPY . .

# Build the Webpack production bundle
RUN npm run prod


# ---- Nginx Stage ----
FROM nginx:alpine

# Copy build output (Webpack builds to /dist by default)
COPY --from=builder /app/dist /usr/share/nginx/html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]

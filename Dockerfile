# Stage 1: Build the application
FROM oven/bun:1 AS builder

WORKDIR /app

# Copy package.json, bun.lockb, and tsconfig.json
COPY package.json bun.lockb tsconfig.json ./

# Install dependencies
RUN bun install --frozen-lockfile

# Copy the rest of the application source code
COPY . .

# Build the application (assuming 'bun run build' is the command)
# We'll confirm the output directory later
RUN bun run build

# Stage 2: Serve the application with Nginx
FROM nginx:alpine

# Copy custom Nginx configuration
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Copy built static files from the builder stage
# Assuming the build output is in /app/build
COPY --from=builder /app/build /usr/share/nginx/html

# Expose port 80
EXPOSE 80

# Start Nginx
CMD ["nginx", "-g", "daemon off;"]

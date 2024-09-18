# Stage 1: Build the Rust code to WASM
FROM rust:latest AS builder

# Install wasm-pack
RUN cargo install wasm-pack

# Set the working directory to /cubeway inside the container
WORKDIR /cubeway

# Copy the Rust manifest files into the container
COPY cubeway/Cargo.toml cubeway/Cargo.lock ./

# Copy the Rust source code into the container
COPY cubeway/src ./src

# Build the WASM package and output it to /app/pkg
RUN wasm-pack build --target web --out-dir /pkg

# Stage 2: Build the frontend
FROM node:16-alpine AS frontend

# Set the working directory to /app inside the container
WORKDIR /app

# Copy package.json and package-lock.json into the container
COPY app/package*.json ./

# Install npm dependencies
RUN npm ci

# Copy the rest of your frontend code into the container
COPY app/. ./

# Copy the WASM output from the builder stage into the frontend's pkg directory
COPY --from=builder /pkg ../cubeway/pkg

# Build the frontend assets
RUN npm run build

# Stage 3: Serve the built files with simple-http-server
FROM rust:latest AS server

# Install simple-http-server
RUN cargo install simple-http-server

# Set the working directory to /app/dist inside the container
WORKDIR /app/dist

# Copy the built frontend files from the frontend stage
COPY --from=frontend /app/dist ./

# Stage 1: Build the Go application
FROM ubuntu:latest AS builder

ENV DEBIAN_FRONTEND=noninteractive

# Install dependencies
RUN apt-get update && apt-get install -y \
    wget \
    curl \
    git \
    build-essential \
    python3 \
    python3-pip \
    python3-venv \
    golang \
    && apt-get clean

# Set Go environment variables
ENV GOPATH=/go
ENV PATH=$GOPATH/bin:/usr/local/go/bin:$PATH

# Set the working directory
WORKDIR /app

# Copy go.mod and go.sum to download dependencies
COPY go.mod go.sum ./
RUN go mod download

# Copy the rest of the application code
COPY . .

# Build the application as a static binary
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o gin-app .

# Stage 2: Create a runtime image
FROM python:3.11-alpine

# Install additional dependencies (if required)
RUN apk add --no-cache \
    py3-pip \
    py3-setuptools

# Set environment variables
ENV GIN_MODE=release

# Set the working directory
WORKDIR /root/

# Copy the Go binary from the builder stage
COPY --from=builder /app/gin-app .

# Expose the port the application will run on
EXPOSE 8080

# Command to run the application
CMD ["./gin-app"]

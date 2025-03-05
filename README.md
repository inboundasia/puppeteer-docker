# Purpose
Puppeteer Environment

# Build & Publish
docker buildx build --platform linux/amd64,linux/arm64 -t inboundasia/puppeteer:latest --push .

# Run with Bash
docker run -it inboundasia/puppeteer /bin/bash

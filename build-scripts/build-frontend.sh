#!/bin/bash
# Build frontend React/TypeScript application

set -e

echo "Building frontend with Buck2..."
cd /home/runner/work/monobean/monobean

echo "Installing dependencies..."
npm install

echo "Building TypeScript and React app..."
npm run build

echo "Frontend build completed!"
echo "Output available in dist/ directory"
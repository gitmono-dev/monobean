#!/bin/bash
# Build complete Tauri application (frontend + backend + bundling)

set -e

echo "Building complete monobean application with Buck2..."
cd /home/runner/work/monobean/monobean

echo "Installing dependencies..."
npm install

echo "Building complete Tauri application..."
npm run tauri build

echo "Monobean application build completed!"
echo "Executable and bundles available in src-tauri/target/release/"
echo "Platform-specific bundles available in src-tauri/target/release/bundle/"
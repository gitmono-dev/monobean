#!/bin/bash
# Build backend Rust application with Cargo

set -e

echo "Building backend with Buck2..."
cd /home/runner/work/monobean/monobean/src-tauri

echo "Checking Rust code..."
cargo check

echo "Building release version..."
cargo build --release

echo "Backend build completed!"
echo "Binary available in src-tauri/target/release/"
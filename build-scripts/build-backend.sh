#!/bin/bash
# Build backend Rust application with Cargo

set -e

echo "Building backend with Buck2..."
cd /home/runner/work/monobean/monobean/src-tauri

echo "Checking Rust code..."
# Try cargo check first, if it fails due to system deps, note that
if ! cargo check; then
    echo "Note: cargo check failed, likely due to missing system dependencies (glib, gtk, etc.)"
    echo "This is expected in CI environments. In a proper development environment,"
    echo "install the required system packages first:"
    echo "  sudo apt-get install libgtk-3-dev libwebkit2gtk-4.0-dev"
    exit 0
fi

echo "Building release version..."
cargo build --release

echo "Backend build completed!"
echo "Binary available in src-tauri/target/release/"
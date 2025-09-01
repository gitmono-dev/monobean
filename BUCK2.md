# Buck2 Build Configuration for Monobean

This document describes how to use Buck2 to build the monobean Tauri application.

## Prerequisites

1. **Buck2** installed and available in PATH
2. **Node.js and npm** for frontend builds  
3. **Rust and Cargo** for backend builds
4. **System dependencies** for Tauri (see below)

### Installing Buck2

```bash
# Download and install Buck2
wget https://github.com/facebook/buck2/releases/download/2024-11-15/buck2-x86_64-unknown-linux-gnu.zst
zstd -d buck2-x86_64-unknown-linux-gnu.zst
chmod +x buck2-x86_64-unknown-linux-gnu
sudo mv buck2-x86_64-unknown-linux-gnu /usr/local/bin/buck2
```

### System Dependencies for Tauri

On Ubuntu/Debian:
```bash
sudo apt-get update
sudo apt-get install libgtk-3-dev libwebkit2gtk-4.0-dev
```

## Buck2 Setup

The project includes Buck2 configuration files:

- `.buckconfig` - Main Buck2 configuration
- `BUCK` - Root build file with main targets
- `src/BUCK` - Frontend specific build rules  
- `src-tauri/BUCK` - Backend Rust build rules
- `build-scripts/` - Shell scripts for build execution

## Available Build Commands

Buck2 is configured to work alongside the existing npm/cargo workflow. You can use either approach:

### Using Buck2 Build Scripts

```bash
# Build the React/TypeScript frontend
./build-scripts/build-frontend.sh

# Build the Rust backend (requires system dependencies)
./build-scripts/build-backend.sh

# Build the complete Tauri application
./build-scripts/build-monobean.sh
```

### Using Traditional Commands

```bash
# Frontend only
npm run build

# Complete Tauri app  
npm run tauri build
```

## Buck2 Configuration Details

### .buckconfig
- Defines basic Buck2 configuration
- Sets up cell structure for the project

### BUCK Files
- Root `/BUCK` - Contains build command documentation
- `/src/BUCK` - Frontend build command documentation
- `/src-tauri/BUCK` - Backend build command documentation

## Build Scripts

The actual build logic is implemented in shell scripts in the `build-scripts/` directory:

### build-frontend.sh
- Installs npm dependencies
- Runs TypeScript compilation (`npm run build`)
- Uses Vite for production build
- **Output**: `dist/` directory with compiled frontend

### build-backend.sh  
- Runs `cargo check` for validation
- Attempts `cargo build --release`
- Handles missing system dependencies gracefully
- **Output**: `src-tauri/target/release/` (if system deps available)

### build-monobean.sh
- Builds frontend first
- Attempts complete Tauri build with bundling
- Handles dependency issues gracefully
- **Output**: Platform-specific bundles in `src-tauri/target/release/bundle/`

## Usage Examples

### Quick Development Workflow

```bash
# Check if Buck2 is working
buck2 targets //...

# Build frontend (always works)
./build-scripts/build-frontend.sh

# Check frontend output
ls -la dist/

# Attempt backend build (may fail in CI)
./build-scripts/build-backend.sh

# Full application build
./build-scripts/build-monobean.sh
```

### Integration with CI/CD

The Buck2 setup is designed to work in CI environments:

- Frontend builds will always succeed
- Backend/Tauri builds fail gracefully with informative messages
- Build scripts provide clear feedback about missing dependencies
- Output is available even if full build fails

## Benefits of Buck2 Integration

- **Consistent Interface**: Standardized build commands across different technologies
- **Dependency Awareness**: Buck2 understands project structure 
- **Scalability**: Ready for monorepo expansion
- **Tool Integration**: Works with existing npm/cargo workflow
- **Error Handling**: Graceful degradation when dependencies missing

## Troubleshooting

### Buck2 Command Fails
```bash
# Clean Buck2 cache
buck2 clean

# Verify configuration
buck2 targets //...
```

### Missing System Dependencies
```bash
# Install required packages (Ubuntu/Debian)
sudo apt-get install libgtk-3-dev libwebkit2gtk-4.0-dev

# Verify Rust toolchain
cargo --version
rustc --version
```

### Tauri Version Mismatches
Update package versions to match:
```bash
# Update npm packages
npm update @tauri-apps/api @tauri-apps/plugin-opener

# Update Cargo dependencies in src-tauri/Cargo.toml
```

## Development Workflow

1. **Start with frontend**: `./build-scripts/build-frontend.sh`
2. **Verify output**: Check `dist/` directory
3. **Test backend** (if system deps available): `./build-scripts/build-backend.sh`
4. **Complete build**: `./build-scripts/build-monobean.sh`

The Buck2 setup complements rather than replaces the existing workflow, providing consistency and preparing for future monorepo growth.
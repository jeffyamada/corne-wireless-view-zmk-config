# Building ZMK Firmware Locally

This guide will help you build your ZMK firmware locally instead of relying on GitHub Actions.

## Prerequisites

1. **Python 3.8+** (check with `python3 --version`)
2. **West** - Zephyr's meta-tool for managing the workspace
3. **Zephyr SDK** (optional but recommended for faster builds)

## Setup Steps

### 1. Install West

```bash
pip3 install west
```

Or using pipx (recommended):
```bash
pipx install west
```

### 2. Initialize the West Workspace

From the root of your config repo:

```bash
west init -l config
west update
```

This will:
- Initialize the west workspace
- Clone the ZMK firmware repository (v0.3) as a submodule
- Download all required dependencies

**Note:** The first `west update` may take several minutes as it downloads the ZMK firmware and all dependencies.

### 3. Install Zephyr SDK (Optional but Recommended)

The Zephyr SDK provides pre-built toolchains and speeds up builds significantly:

```bash
# Download and install Zephyr SDK
# Visit: https://github.com/zephyrproject-rtos/sdk-ng/releases
# Download the latest macOS SDK and follow installation instructions
```

Or use the automatic installer:
```bash
# Linux/macOS
wget https://github.com/zephyrproject-rtos/sdk-ng/releases/download/v0.16.9/zephyr-sdk-0.16.9_macos-x86_64.tar.gz
tar xvf zephyr-sdk-0.16.9_macos-x86_64.tar.gz
cd zephyr-sdk-0.16.9
./setup.sh
```

## Building Firmware

Based on your `build.yaml`, you have two builds:

### Build Left Side (with ZMK Studio support)

```bash
west build -s zmk/app -b nice_nano_v2 -- -DSHIELD="corne_left nice_view_adapter nice_view" -DSNIPPET="studio-rpc-usb-uart" -DZMK_CONFIG=$(pwd)/config
```

### Build Right Side

```bash
west build -s zmk/app -b nice_nano_v2 -- -DSHIELD="corne_right nice_view_adapter nice_view" -DZMK_CONFIG=$(pwd)/config
```

### Build Both Sides (Quick Script)

Create a script `build.sh`:

```bash
#!/bin/bash

CONFIG_DIR=$(pwd)/config

echo "Building left side..."
west build -s zmk/app -b nice_nano_v2 --pristine -- -DSHIELD="corne_left nice_view_adapter nice_view" -DSNIPPET="studio-rpc-usb-uart" -DZMK_CONFIG=$CONFIG_DIR
cp build/zephyr/zmk.uf2 build/corne_left.uf2

echo "Building right side..."
west build -s zmk/app -b nice_nano_v2 --pristine -- -DSHIELD="corne_right nice_view_adapter nice_view" -DZMK_CONFIG=$CONFIG_DIR
cp build/zephyr/zmk.uf2 build/corne_right.uf2

echo "Build complete! Firmware files:"
ls -lh build/*.uf2
```

Make it executable:
```bash
chmod +x build.sh
./build.sh
```

## Build Options

- `--pristine` - Clean build (removes previous build artifacts)
- `-d build` - Specify build directory (default is `build/`)
- `-b nice_nano_v2` - Board name
- `-DSHIELD="..."` - Shield(s) to use
- `-DSNIPPET="..."` - Optional snippet (like studio-rpc-usb-uart)
- `-DZMK_CONFIG=$(pwd)/config` - Path to your config directory

## Output Files

After building, you'll find the firmware files at:
- `build/zephyr/zmk.uf2` - The compiled firmware (rename as needed)

## Troubleshooting

### West not found
```bash
pip3 install --user west
# Add ~/.local/bin to your PATH
export PATH=$HOME/.local/bin:$PATH
```

### Build errors
- Make sure `west update` completed successfully
- Check that your `config/corne.keymap` file has valid syntax
- Try a pristine build: `west build --pristine ...`

### Missing dependencies
```bash
# macOS
brew install cmake ninja dfu-util

# Linux (Ubuntu/Debian)
sudo apt-get install cmake ninja-build dfu-util
```

## Quick Reference

```bash
# Initialize workspace (first time only)
west init -l config
west update

# Build left side
west build -s zmk/app -b nice_nano_v2 -- -DSHIELD="corne_left nice_view_adapter nice_view" -DSNIPPET="studio-rpc-usb-uart" -DZMK_CONFIG=$(pwd)/config

# Build right side  
west build -s zmk/app -b nice_nano_v2 -- -DSHIELD="corne_right nice_view_adapter nice_view" -DZMK_CONFIG=$(pwd)/config

# Clean build
west build --pristine -s zmk/app -b nice_nano_v2 -- ...
```


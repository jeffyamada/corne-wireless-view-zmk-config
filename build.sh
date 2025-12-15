#!/bin/bash

# ZMK Local Build Script
# This script builds both halves of your Corne keyboard

set -e  # Exit on error

CONFIG_DIR=$(pwd)/config
BUILD_DIR=$(pwd)/build

# Add Python user bin to PATH (where west is typically installed)
export PATH="$HOME/Library/Python/3.11/bin:$PATH"

echo "=========================================="
echo "ZMK Firmware Build Script"
echo "=========================================="
echo ""

# Check for Zephyr SDK
check_zephyr_sdk() {
    # Check common installation locations
    local sdk_paths=(
        "$HOME/zephyr-sdk-*"
        "$HOME/.local/zephyr-sdk-*"
        "/opt/zephyr-sdk-*"
        "/usr/local/zephyr-sdk-*"
    )
    
    for path_pattern in "${sdk_paths[@]}"; do
        # Use find to handle globbing safely
        local found=$(find $(dirname "$path_pattern") -maxdepth 1 -type d -name "$(basename "$path_pattern")" 2>/dev/null | head -1)
        if [ -n "$found" ] && [ -f "$found/cmake/Zephyr-sdkConfig.cmake" ]; then
            echo "$found"
            return 0
        fi
    done
    
    # Check CMake package registry
    if [ -d "$HOME/.cmake/packages/Zephyr-sdk" ]; then
        # SDK might be registered but we need to find the actual path
        return 1
    fi
    
    return 1
}

SDK_PATH=$(check_zephyr_sdk)
if [ -z "$SDK_PATH" ]; then
    echo "⚠️  Zephyr SDK not found!"
    echo ""
    echo "The Zephyr SDK is required for building ARM targets."
    echo ""
    if [ -f "$(dirname "$0")/install_zephyr_sdk.sh" ]; then
        echo "An installation script is available. Run:"
        echo "  ./install_zephyr_sdk.sh"
        echo ""
        read -p "Would you like to install the SDK now? (y/N) " -n 1 -r
        echo ""
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            "$(dirname "$0")/install_zephyr_sdk.sh"
            echo ""
            echo "Re-running build script..."
            exec "$0" "$@"
        fi
    fi
    echo ""
    echo "Manual installation:"
    echo "  1. Download from: https://github.com/zephyrproject-rtos/sdk-ng/releases"
    echo "     For macOS $(uname -m), download: zephyr-sdk-*-macos-*.tar.xz"
    echo ""
    echo "  2. Extract and install:"
    echo "     tar xf zephyr-sdk-*.tar.xz"
    echo "     cd zephyr-sdk-*"
    echo "     ./setup.sh"
    echo ""
    echo "Alternatively, you can set ZEPHYR_SDK_INSTALL_DIR if installed elsewhere."
    echo ""
    echo "⚠️  Continuing without SDK - build will fail!"
    echo ""
fi

# Check if west is installed
if ! command -v west &> /dev/null; then
    echo "❌ Error: 'west' is not installed."
    echo "   Install it with: pip3 install --user west"
    echo "   Or: pipx install west"
    exit 1
fi

# Check if zmk directory exists
if [ ! -d "zmk" ]; then
    echo "⚠️  ZMK directory not found. Initializing workspace..."
    echo "   This may take a few minutes..."
    west init -l config
    west update
    echo "✅ Workspace initialized!"
    echo ""
fi

# Export Zephyr CMake package (required for CMake to find Zephyr)
# Always run this to ensure it's up to date
echo "Exporting Zephyr CMake package..."
west zephyr-export > /dev/null 2>&1 || true
echo "✅ Zephyr CMake package exported"
echo ""

# Source Zephyr environment to set up ZEPHYR_BASE and PATH
if [ -f "zephyr/zephyr-env.sh" ]; then
    echo "Setting up Zephyr environment..."
    source zephyr/zephyr-env.sh
    echo "✅ Zephyr environment configured"
    echo ""
else
    echo "⚠️  Warning: zephyr/zephyr-env.sh not found. Build may fail."
    echo ""
fi

# Create build directory
mkdir -p "$BUILD_DIR"

echo "Building left side (with ZMK Studio support)..."
west build -s zmk/app -b nice_nano_v2 -d "$BUILD_DIR/left" --pristine -- \
    -DSHIELD="corne_left nice_view_adapter nice_view" \
    -DSNIPPET="studio-rpc-usb-uart" \
    -DZMK_CONFIG="$CONFIG_DIR"

if [ -f "$BUILD_DIR/left/zephyr/zmk.uf2" ]; then
    cp "$BUILD_DIR/left/zephyr/zmk.uf2" "$BUILD_DIR/corne_left.uf2"
    echo "✅ Left side built: $BUILD_DIR/corne_left.uf2"
else
    echo "❌ Left side build failed!"
    exit 1
fi

echo ""
echo "Building right side..."
west build -s zmk/app -b nice_nano_v2 -d "$BUILD_DIR/right" --pristine -- \
    -DSHIELD="corne_right nice_view_adapter nice_view" \
    -DZMK_CONFIG="$CONFIG_DIR"

if [ -f "$BUILD_DIR/right/zephyr/zmk.uf2" ]; then
    cp "$BUILD_DIR/right/zephyr/zmk.uf2" "$BUILD_DIR/corne_right.uf2"
    echo "✅ Right side built: $BUILD_DIR/corne_right.uf2"
else
    echo "❌ Right side build failed!"
    exit 1
fi

echo ""
echo "=========================================="
echo "✅ Build Complete!"
echo "=========================================="
echo ""
echo "Firmware files:"
ls -lh "$BUILD_DIR"/*.uf2
echo ""
echo "To flash your keyboard:"
echo "  1. Put your nice!nano into bootloader mode (double-tap reset)"
echo "  2. Copy the .uf2 file to the USB drive that appears"
echo "  3. Repeat for the other half"


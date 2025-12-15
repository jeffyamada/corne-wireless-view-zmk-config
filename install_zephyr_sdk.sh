#!/bin/bash

# Zephyr SDK Installation Script
# This script downloads and installs the Zephyr SDK for macOS

set -e

ARCH=$(uname -m)
SDK_VERSION="0.17.4"
INSTALL_DIR="$HOME"

echo "=========================================="
echo "Zephyr SDK Installation Script"
echo "=========================================="
echo ""
echo "Architecture: $ARCH"
echo "SDK Version: $SDK_VERSION"
echo "Install Directory: $INSTALL_DIR"
echo ""

# Determine the correct SDK file based on architecture
if [ "$ARCH" = "arm64" ]; then
    SDK_FILE="zephyr-sdk-${SDK_VERSION}_macos-aarch64.tar.xz"
    SDK_URL="https://github.com/zephyrproject-rtos/sdk-ng/releases/download/v${SDK_VERSION}/${SDK_FILE}"
elif [ "$ARCH" = "x86_64" ]; then
    SDK_FILE="zephyr-sdk-${SDK_VERSION}_macos-x86_64.tar.xz"
    SDK_URL="https://github.com/zephyrproject-rtos/sdk-ng/releases/download/v${SDK_VERSION}/${SDK_FILE}"
else
    echo "❌ Unsupported architecture: $ARCH"
    exit 1
fi

# The extracted directory name is just the version, not the full filename
SDK_DIR="$INSTALL_DIR/zephyr-sdk-${SDK_VERSION}"

# Check if already installed
if [ -d "$SDK_DIR" ] && [ -f "$SDK_DIR/cmake/Zephyr-sdkConfig.cmake" ]; then
    echo "✅ Zephyr SDK already installed at: $SDK_DIR"
    echo ""
    read -p "Reinstall? (y/N) " -n 1 -r
    echo ""
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        echo "Skipping installation."
        exit 0
    fi
    rm -rf "$SDK_DIR"
fi

# Download SDK
echo "Downloading Zephyr SDK..."
echo "URL: $SDK_URL"
echo ""

cd "$INSTALL_DIR"
if [ -f "$SDK_FILE" ]; then
    echo "File already exists: $SDK_FILE"
    read -p "Re-download? (y/N) " -n 1 -r
    echo ""
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        rm -f "$SDK_FILE"
    else
        echo "Using existing file."
    fi
fi

if [ ! -f "$SDK_FILE" ]; then
    echo "Downloading (this may take a while)..."
    curl -L -o "$SDK_FILE" "$SDK_URL"
fi

# Extract SDK
echo ""
echo "Extracting SDK..."
tar xf "$SDK_FILE"

# Run setup script
echo ""
echo "Running setup script..."
cd "$SDK_DIR"
./setup.sh

echo ""
echo "=========================================="
echo "✅ Zephyr SDK installed successfully!"
echo "=========================================="
echo ""
echo "SDK Location: $SDK_DIR"
echo ""
echo "You can now run ./build.sh to build your firmware."
echo ""


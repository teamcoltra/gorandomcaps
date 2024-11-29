#!/bin/bash

# Enable Go modules
export GO111MODULE=on

# Set output directory
OUTPUT_DIR="build"
mkdir -p "$OUTPUT_DIR"

# Build for Windows
build_windows() {
    echo "Building for Windows..."
    GOOS=windows GOARCH=amd64 go build -ldflags "-H=windowsgui" -o "$OUTPUT_DIR/gorandomcaps.exe"
    if [ $? -eq 0 ]; then
        echo "Successfully built Windows executable: $OUTPUT_DIR/gorandomcaps.exe"
    else
        echo "Failed to build Windows executable."
        exit 1
    fi
}

# Build for macOS
build_macos() {
    echo "Building for macOS..."
    GOOS=darwin GOARCH=amd64 go build -o "$OUTPUT_DIR/gorandomcaps"
    if [ $? -eq 0 ]; then
        echo "Successfully built macOS executable: $OUTPUT_DIR/gorandomcaps"
    else
        echo "Failed to build macOS executable."
        exit 1
    fi
}

# Build for Linux
build_linux() {
    echo "Building for Linux..."
    GOOS=linux GOARCH=amd64 go build -o "$OUTPUT_DIR/gorandomcaps-linux"
    if [ $? -eq 0 ]; then
        echo "Successfully built Linux executable: $OUTPUT_DIR/gorandomcaps-linux"
    else
        echo "Failed to build Linux executable."
        exit 1
    fi
}

# Build for all platforms
build_windows
build_macos
build_linux

echo "All builds completed. Check the $OUTPUT_DIR directory for output files."

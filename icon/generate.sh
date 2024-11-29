#!/bin/bash

# Ensure GOPATH is set
if [ -z "$GOPATH" ]; then
    echo "GOPATH environment variable is not set."
    exit 1
fi

# Ensure 2goarray is installed
if [ ! -f "$GOPATH/bin/2goarray" ]; then
    echo "2goarray is not installed. Installing..."
    go install github.com/cratonica/2goarray@latest
    if [ $? -ne 0 ]; then
        echo "Failed to install 2goarray. Ensure Go is installed and in your PATH."
        exit 1
    fi
fi

# Validate inputs
WINDOWS_ICON=$1
DARWIN_ICON=${2:-$WINDOWS_ICON}
LINUX_ICON=${3:-$DARWIN_ICON}

if [ -z "$WINDOWS_ICON" ]; then
    echo "Usage: ./generate.sh <windows.ico> [darwin.ico] [linux.ico]"
    exit 1
fi

# Ensure input files exist
for ICON in "$WINDOWS_ICON" "$DARWIN_ICON" "$LINUX_ICON"; do
    if [ ! -f "$ICON" ]; then
        echo "Input file $ICON does not exist."
        exit 1
    fi
done

# Generate Windows icon file
echo "Creating iconwin.go"
echo "//+build windows" > iconwin.go
echo >> iconwin.go
cat "$WINDOWS_ICON" | "$GOPATH/bin/2goarray" Data icon >> iconwin.go
if [ $? -ne 0 ]; then
    echo "Failed to create iconwin.go."
    exit 1
fi

# Generate Darwin icon file
echo "Creating icondarwin.go"
echo "//+build darwin" > icondarwin.go
echo >> icondarwin.go
cat "$DARWIN_ICON" | "$GOPATH/bin/2goarray" Data icon >> icondarwin.go
if [ $? -ne 0 ]; then
    echo "Failed to create icondarwin.go."
    exit 1
fi

# Generate Linux icon file
echo "Creating iconlinux.go"
echo "//+build linux" > iconlinux.go
echo >> iconlinux.go
cat "$LINUX_ICON" | "$GOPATH/bin/2goarray" Data icon >> iconlinux.go
if [ $? -ne 0 ]; then
    echo "Failed to create iconlinux.go."
    exit 1
fi

echo "Finished creating icons."

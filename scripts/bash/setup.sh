#!/bin/bash

PLATFORM=$(python scripts/python/os_detect.py)

SHADERC_DIR="env"
SHADERC_PATH="${SHADERC_DIR}/shaderc" 
SHADERC_PATH_WIN="${SHADERC_DIR}/shaderc.exe"

EXECUTABLE_PATH="$SHADERC_PATH" 
NEEDS_CHMOD=true

rm -rf "$SHADERC_DIR"
mkdir "$SHADERC_DIR"

echo "Download shaderc for $PLATFORM"

case "$PLATFORM" in
    "linux")
        URL="https://github.com/CyberGangzTeam/bgfx-shaderc-binaries/releases/download/20251128/shaderc-linux-x64"
    ;;

    "android")
        URL="https://github.com/CyberGangzTeam/bgfx-shaderc-binaries/releases/download/20251128/shaderc-android-arm64"
    ;;

    "ios")
        URL="https://github.com/CyberGangzTeam/bgfx-shaderc-binaries/releases/download/20251128/shaderc-ios-aarch64"
    ;;

    "windows")
        URL="https://github.com/devendrn/newb-shader/releases/download/dev/shaderc-win-x64.exe"
        EXECUTABLE_PATH="$SHADERC_PATH_WIN"
        NEEDS_CHMOD=false
    ;;

    "macos")
        URL="https://github.com/CyberGangzTeam/bgfx-shaderc-binaries/releases/download/20251128/shaderc-osx-x64"
    ;;

    "other")
        echo "Error: Operating system '$PLATFORM' is not explicitly supported for automated download!" >&2
        exit 1
    ;;
esac

if [ -n "$URL" ]; then
    DOWNLOAD_DEST="$SHADERC_PATH"
    if [ "$PLATFORM" == "windows" ]; then
        DOWNLOAD_DEST="$SHADERC_PATH_WIN"
    fi
    
    wget -O "$DOWNLOAD_DEST" --show-progress -q "$URL"
    
    if [ $? -ne 0 ]; then
        echo "Error: Failed to download shaderc from $URL" >&2
        exit 1
    fi
    
    echo "Download successful."
fi

if $NEEDS_CHMOD ; then
    chmod +x "$EXECUTABLE_PATH"
    if [ $? -ne 0 ]; then
        echo "Error: Failed to set executable permission on $EXECUTABLE_PATH" >&2
        exit 1
    fi
    echo "Set executable permission: chmod +x $EXECUTABLE_PATH"
fi

if [ ! -f "$EXECUTABLE_PATH" ] && [ ! -f "$SHADERC_PATH" ]; then
    echo "Error: shaderc file not found after download/setup." >&2
    exit 1
fi

echo "Setup completed successfully."
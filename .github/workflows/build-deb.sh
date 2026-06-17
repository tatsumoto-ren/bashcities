#!/bin/bash

# Build script for creating a DEB package for bashcities

set -euo pipefail

PACKAGE_NAME="bashcities"
VERSION=${VERSION:?Version is not set.}
VERSION=${VERSION##v}
PACKAGE_DIR="deb_package"
OUTPUT_FILE="${PACKAGE_NAME}.deb"

ROOT_DIR=$(git rev-parse --show-toplevel)
cd -- "$ROOT_DIR" || exit 1

# Clean up previous build
rm -rf -- "$PACKAGE_DIR" "$OUTPUT_FILE"

# Create package directory structure
mkdir -p -- "$PACKAGE_DIR/DEBIAN"
mkdir -p -- "$PACKAGE_DIR/usr/bin"
mkdir -p -- "$PACKAGE_DIR/usr/share/doc/$PACKAGE_NAME"
mkdir -p -- "$PACKAGE_DIR/usr/share/licenses/$PACKAGE_NAME"

# Create control file
cat > "$PACKAGE_DIR/DEBIAN/control" << EOF
Package: $PACKAGE_NAME
Version: $VERSION
Section: utils
Priority: optional
Architecture: all
Maintainer: Ren Tatsumoto <tatsu@autistici.org>
Depends: bash, curl, python3
Recommends: git
Description: A Neocities client that actually works.
 A simple Neocities CLI client written in Bash.
 Handles pushing, deleting, listing, and backing up your site.
Homepage: https://github.com/tatsumoto-ren/bashcities
License: GPL-3.0
EOF

# Copy files to package directory
cp -- "$PACKAGE_NAME" "$PACKAGE_DIR/usr/bin/"
cp -- README.md "$PACKAGE_DIR/usr/share/doc/$PACKAGE_NAME/"
cp -- LICENSE "$PACKAGE_DIR/usr/share/licenses/$PACKAGE_NAME/"
chmod +x -- "$PACKAGE_DIR/usr/bin/$PACKAGE_NAME"

# Build the DEB package
dpkg-deb --build "$PACKAGE_DIR" "$OUTPUT_FILE"

echo "DEB package created: $OUTPUT_FILE"

# Show package info
echo "Package info:"
dpkg-deb --info "$OUTPUT_FILE"

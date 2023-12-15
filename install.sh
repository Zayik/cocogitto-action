#!/bin/sh

set -a

GITHUB_ACTION_PATH=$1

CUR_DIR=$(pwd)
VERSION=6.0.1
TAR="cocogitto-$VERSION-x86_64-pc-windows-msvc.tar.gz"
BIN_DIR="$GITHUB_ACTION_PATH/.local/bin"

mkdir -p "$BIN_DIR"
cd "$BIN_DIR" || exit
curl -OL https://github.com/cocogitto/cocogitto/releases/download/"$VERSION"/"$TAR"
tar xfz $TAR
cd "$CUR_DIR" || exit

COG_PATH=$(find "$BIN_DIR" -name 'cog.exe' | head -n 1)
echo "$COG_PATH"
mv "$COG_PATH" "$GITHUB_ACTION_PATH/cog.exe"


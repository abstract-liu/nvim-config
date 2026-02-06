#!/usr/bin/env bash
set -euo pipefail

# macOS (Apple Silicon) Neovim installer (copy full dir, link only bin)
# Usage:
#   NVIM_VERSION=v0.10.3 ./install-nvim-macos-arm.sh
# If NVIM_VERSION is not set, it will prompt you to check GitHub releases.

NVIM_VERSION="${NVIM_VERSION:-}"

if [[ -z "$NVIM_VERSION" ]]; then
  echo "NVIM_VERSION is not set."
  echo "Please set it, e.g.:  NVIM_VERSION=v0.10.3 $0"
  echo "Find versions here: https://github.com/neovim/neovim/releases"
  exit 1
fi

ARCH="$(uname -m)"
if [[ "$ARCH" != "arm64" ]]; then
  echo "This script is for macOS arm64. Current arch: $ARCH"
  exit 1
fi

INSTALL_DIR="/usr/local/bin"
# You asked to copy the whole extracted directory here (as a directory)
NVIM_DIR_TARGET="${INSTALL_DIR}/nvim-macos-arm64"
# And link only the bin
NVIM_BIN_LINK="${INSTALL_DIR}/nvim"
NVIM_BIN_TARGET="${NVIM_DIR_TARGET}/bin/nvim"

TARBALL_URL="https://github.com/neovim/neovim/releases/download/${NVIM_VERSION}/nvim-macos-arm64.tar.gz"

TMPDIR="$(mktemp -d)"
cleanup() { rm -rf "$TMPDIR"; }
trap cleanup EXIT

echo "Downloading: ${TARBALL_URL}"
curl -fL --retry 3 --retry-delay 1 -o "${TMPDIR}/nvim-macos-arm64.tar.gz" "$TARBALL_URL"

echo "Extracting..."
tar -xzf "${TMPDIR}/nvim-macos-arm64.tar.gz" -C "$TMPDIR"

EXTRACTED_DIR="${TMPDIR}/nvim-macos-arm64"
EXTRACTED_BIN="${EXTRACTED_DIR}/bin/nvim"

if [[ ! -x "$EXTRACTED_BIN" ]]; then
  echo "ERROR: Cannot find expected binary at: $EXTRACTED_BIN"
  echo "Archive layout may have changed."
  exit 1
fi

sudo mkdir -p "$INSTALL_DIR"

# Remove existing /usr/local/bin/nvim link or file
if [[ -e "$NVIM_BIN_LINK" || -L "$NVIM_BIN_LINK" ]]; then
  echo "Removing existing: $NVIM_BIN_LINK"
  sudo rm -f "$NVIM_BIN_LINK"
fi

# Remove existing target directory/file/symlink at /usr/local/bin/nvim-macos-arm64
if [[ -e "$NVIM_DIR_TARGET" || -L "$NVIM_DIR_TARGET" ]]; then
  echo "Removing existing: $NVIM_DIR_TARGET"
  sudo rm -rf "$NVIM_DIR_TARGET"
fi

echo "Copying full directory to: $NVIM_DIR_TARGET"
# Preserve permissions/links/etc
sudo cp -a "$EXTRACTED_DIR" "$NVIM_DIR_TARGET"

# Sanity check
if [[ ! -x "$NVIM_BIN_TARGET" ]]; then
  echo "ERROR: Installed binary not found/executable at: $NVIM_BIN_TARGET"
  exit 1
fi

echo "Linking: $NVIM_BIN_LINK -> $NVIM_BIN_TARGET"
sudo ln -s "$NVIM_BIN_TARGET" "$NVIM_BIN_LINK"

echo "Done."
"$NVIM_BIN_LINK" --version | head -n 2

#!/usr/bin/env bash
set -euo pipefail

# Neovim installer for macOS (Apple Silicon) and Linux (x86_64)
# Usage:
#   NVIM_VERSION=v0.10.3 ./install_nvim.sh
# If NVIM_VERSION is not set, it will prompt you to check GitHub releases.

NVIM_VERSION="${NVIM_VERSION:-}"

if [[ -z "$NVIM_VERSION" ]]; then
  echo "NVIM_VERSION is not set."
  echo "Please set it, e.g.:  NVIM_VERSION=v0.10.3 $0"
  echo "Find versions here: https://github.com/neovim/neovim/releases"
  exit 1
fi

OS="$(uname -s)"
ARCH="$(uname -m)"

if [[ "$OS" == "Darwin" && "$ARCH" == "arm64" ]]; then
  PLATFORM="macos-arm64"
elif [[ "$OS" == "Linux" && "$ARCH" == "x86_64" ]]; then
  PLATFORM="linux-x86_64"
else
  echo "Unsupported OS/arch: $OS/$ARCH"
  echo "Supported: Darwin/arm64, Linux/x86_64"
  exit 1
fi

INSTALL_DIR="/usr/local/bin"
NVIM_DIR_TARGET="${INSTALL_DIR}/nvim-${PLATFORM}"
NVIM_BIN_LINK="${INSTALL_DIR}/nvim"
NVIM_BIN_TARGET="${NVIM_DIR_TARGET}/bin/nvim"

TARBALL_NAME="nvim-${PLATFORM}.tar.gz"
if [[ "$OS" == "Linux" ]]; then
  TARBALL_URL="https://github.com/neovim/neovim-releases/releases/download/${NVIM_VERSION}/${TARBALL_NAME}"
else
  TARBALL_URL="https://github.com/neovim/neovim/releases/download/${NVIM_VERSION}/${TARBALL_NAME}"
fi

TMPDIR="$(mktemp -d)"
cleanup() { rm -rf "$TMPDIR"; }
trap cleanup EXIT

echo "Platform: $PLATFORM"
echo "Downloading: ${TARBALL_URL}"
curl -fL --retry 3 --retry-delay 1 -o "${TMPDIR}/${TARBALL_NAME}" "$TARBALL_URL"

echo "Extracting..."
tar -xzf "${TMPDIR}/${TARBALL_NAME}" -C "$TMPDIR"

EXTRACTED_DIR="${TMPDIR}/nvim-${PLATFORM}"
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

# Remove existing target directory
if [[ -e "$NVIM_DIR_TARGET" || -L "$NVIM_DIR_TARGET" ]]; then
  echo "Removing existing: $NVIM_DIR_TARGET"
  sudo rm -rf "$NVIM_DIR_TARGET"
fi

echo "Copying full directory to: $NVIM_DIR_TARGET"
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

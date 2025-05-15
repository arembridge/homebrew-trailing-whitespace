#!/usr/bin/env bash
set -euo pipefail

# === CONFIGURATION ===
REPO_OWNER="arembridge"
PROJECT_NAME="trailing-whitespace"
FORMULA_PATH="Formula/trailing-whitespace.rb"
BINARY_NAME="trailing-whitespace-macos"
FORMULA_CLASS="TrailingWhitespace"

# === INPUT ===
if [[ $# -ne 1 ]]; then
  echo "Usage: $0 <version (X.X.X)>"
  exit 1
fi

VERSION="$1"
TAG="v$VERSION"
BINARY_URL="https://github.com/${REPO_OWNER}/${PROJECT_NAME}/releases/download/${TAG}/${BINARY_NAME}"

# === DOWNLOAD & CHECKSUM ===
TMP_BIN=$(mktemp)
echo "Downloading binary from ${BINARY_URL}..."
curl -sL -o "$TMP_BIN" "$BINARY_URL"

echo "Calculating SHA256..."
SHA256=$(shasum -a 256 "$TMP_BIN" | awk '{print $1}')
rm "$TMP_BIN"

# === UPDATE FORMULA ===
echo "Updating ${FORMULA_PATH} with version ${VERSION}..."

cat > "$FORMULA_PATH" <<EOF
class ${FORMULA_CLASS} < Formula
  desc "Provide files, we'll make sure there is one empty line at the end.  Simples."
  homepage "https://github.com/${REPO_OWNER}/${PROJECT_NAME}"
  url "${BINARY_URL}"
  sha256 "${SHA256}"
  version "${VERSION}"

  def install
    bin.install "${BINARY_NAME}" => "${PROJECT_NAME}"
  end
end
EOF

echo "✅ Formula updated: ${FORMULA_PATH}"

#!/bin/bash
set -e

GITHUB_OUTPUT_FILE="$1"


# 提取 tag 名，去掉 refs/tags/
REF="${GITHUB_REF#refs/tags/}"

# 判断是否为预发布
if [[ "$REF" =~ - ]]; then
  ID="${REF#*-}"
  ID="${ID%%.*}"  # alpha.0 -> alpha
  echo "Detected tag: $ID"
  echo "tag=$ID" >> "$GITHUB_OUTPUT_FILE"
  echo "prerelease: true"
  echo "prerelease=true" >> "$GITHUB_OUTPUT_FILE"
else
  echo "Detected tag: latest"
  echo "tag=latest" >> "$GITHUB_OUTPUT_FILE"
  echo "prerelease: false"  
  echo "prerelease=false" >> "$GITHUB_OUTPUT_FILE"
fi

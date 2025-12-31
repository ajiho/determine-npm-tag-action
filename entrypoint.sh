#!/bin/bash
set -e

# 提取 tag 名，去掉 refs/tags/
REF="${GITHUB_REF#refs/tags/}"

# 判断是否为预发布
if [[ "$REF" =~ - ]]; then
  ID="${REF#*-}"
  ID="${ID%%.*}"  # alpha.0 -> alpha
  echo "Detected prerelease: $ID"
  echo "tag=$ID" >> "$GITHUB_OUTPUT"
  echo "isprerelease=true" >> "$GITHUB_OUTPUT"
else
  echo "Stable release, using 'latest'"
  echo "tag=latest" >> "$GITHUB_OUTPUT"
  echo "isprerelease=false" >> "$GITHUB_OUTPUT"
fi

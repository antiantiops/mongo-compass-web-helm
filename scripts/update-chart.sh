#!/bin/bash
set -e
NEW_TAG=$1
if [ -z "$NEW_TAG" ]; then
  echo "Usage: $0 <new-tag>"
  exit 1
fi
echo "Updating image to: $NEW_TAG"
yq -i ".appVersion = \"${NEW_TAG}\"" Chart.yaml
OLD_VERSION=$(yq '.version' Chart.yaml)
NEW_VERSION=$(echo "$OLD_VERSION" | awk -F. '{$NF++;print}' OFS=.)
yq -i ".version = \"${NEW_VERSION}\"" Chart.yaml
echo "Chart version: $OLD_VERSION -> $NEW_VERSION"
echo "App version: -> $NEW_TAG"

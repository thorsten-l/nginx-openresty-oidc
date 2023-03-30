#!/bin/bash

OPENRESTY_VERSION=$1
echo "OPENRESTY_VERSION=$OPENRESTY_VERSION"
shift

TAGS=""

while (( $# )); do
  TAGS="$TAGS --tag ghcr.io/thorsten-l/nginx-openresty-oidc:$1"
  shift
done

BUILDING_TAGS=$(echo $TAGS | tr ' ' "\n")

docker buildx build --no-cache \
  --build-arg OPENRESTY_VERSION="$OPENRESTY_VERSION" \
  --push \
  --platform linux/arm64,linux/amd64 $BUILDING_TAGS .

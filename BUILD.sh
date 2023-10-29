docker build --squash \
    --build-arg OPENRESTY_VERSION=1.21.4.2 \
    -t nginx-openresty-oidc:latest .

docker images | grep nginx-openresty-oidc

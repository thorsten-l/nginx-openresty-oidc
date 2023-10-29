ARG OPENRESTY_VERSION
FROM openresty/openresty:${OPENRESTY_VERSION}-jammy

RUN apt update -y && apt upgrade -y && apt install -y procps \
    && luarocks install lua-resty-session \
    && luarocks install lua-resty-http \
    && luarocks install lua-resty-jwt \
    && luarocks install lua-resty-openidc \
    && rm -rf /var/lib/apt

COPY default.conf /etc/nginx/conf.d/default.conf
COPY entrypoint.sh /entrypoint.sh

RUN chmod 0755 /entrypoint.sh \
  && mkdir -p /usr/local/openresty/nginx/dist \
  && mv /etc/nginx/conf.d /usr/local/openresty/nginx/dist \
  && mv /usr/local/openresty/nginx/html /usr/local/openresty/nginx/dist

LABEL description="NGINX OpenResty OpenID Connect"
LABEL maintainer="Thorsten Ludewig <t.ludewig@gmail.com>"
LABEL version="${OPENRESTY_VERSION}"
LABEL org.opencontainers.image.authors="Thorsten Ludewig <t.ludewig@gmail.com>"
LABEL org.opencontainers.image.source="https://github.com/thorsten-l/nginx-openresty-oidc"
LABEL org.opencontainers.image.documentation="https://github.com/thorsten-l/nginx-openresty-oidc"
LABEL org.opencontainers.image.description="NGINX OpenResty OpenID Connect"
LABEL org.opencontainers.image.license="Apache-2.0"
LABEL org.opencontainers.image.version="${OPENRESTY_VERSION}"

WORKDIR /usr/local/openresty
VOLUME /etc/nginx/conf.d /usr/local/openresty/nginx/html

EXPOSE 80 443

ENTRYPOINT [ "/entrypoint.sh" ]

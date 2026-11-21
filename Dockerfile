# syntax=docker/dockerfile:1
# Stage 1: take the xray binary from the official image (it has no shell,
# so it cannot be used directly as the runtime image with sh -c).
FROM ghcr.io/xtls/xray-core:latest AS xray

# Stage 2: small runtime image with a shell.
FROM alpine:3.20
COPY --from=xray /usr/local/bin/xray /usr/local/bin/xray
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
EXPOSE 10000
ENTRYPOINT ["/entrypoint.sh"]

# render-xray

Xray (VLESS + WebSocket + TLS) running on Render Free tier, Singapore region.

## Files

- `Dockerfile` — multi-stage build: stage 1 takes the `xray` binary from `ghcr.io/xtls/xray-core:latest` (that image has no shell), stage 2 copies it into `alpine:3.20` and runs it.
- `entrypoint.sh` — generates `/etc/xray/config.json` at startup from environment variables and starts Xray.
- `README.md` — this file. No secrets are stored in this repository.

## Render setup

- New Web Service from this Git repository, Runtime: Docker, Region: Singapore, Instance Type: Free.
- Environment variables: `UUID` (a fresh UUID) and `WSPATH=/tk-rail`. Do NOT set `PORT` — Render injects it.
- Health Check Path: leave empty (Render then only does a TCP port check; Xray does not return HTTP 200).

## Client

- Protocol: VLESS, network: ws, TLS: on (Render terminates TLS), port: 443, path: `/tk-rail`.
- Example link format: `vless://<UUID>@<name>.onrender.com:443?encryption=none&security=tls&sni=<name>.onrender.com&type=ws&host=<name>.onrender.com&path=%2Ftk-rail#Render-%E6%96%B0%E5%8A%A0%E5%9D%A1`

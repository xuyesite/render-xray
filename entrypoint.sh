#!/bin/sh
set -e
# Generate Xray config at startup from env vars.
# UUID and WSPATH are set in Render; PORT is injected by Render.
: "${UUID:?UUID env var is required}"
: "${WSPATH:=/tk-rail}"
: "${PORT:=10000}"
mkdir -p /etc/xray
cat > /etc/xray/config.json <<EOF
{
  "log": { "loglevel": "warning" },
  "inbounds": [
    {
      "port": ${PORT},
      "protocol": "vless",
      "settings": {
        "clients": [ { "id": "${UUID}", "flow": "" } ],
        "decryption": "none"
      },
      "streamSettings": {
        "network": "ws",
        "wsSettings": { "path": "${WSPATH}" }
      }
    }
  ],
  "outbounds": [
    { "protocol": "freedom", "tag": "direct" },
    { "protocol": "blackhole", "tag": "blocked" }
  ]
}
EOF
exec /usr/local/bin/xray run -config /etc/xray/config.json

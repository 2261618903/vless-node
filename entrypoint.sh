#!/bin/sh
set -eu
: "${PORT:=10000}"
: "${UUID:?UUID env is required}"
WS_PATH="${WS_PATH:-/ws}"
cat > /tmp/config.json <<JSON
{
  "log": {"loglevel": "warning"},
  "inbounds": [{
    "listen": "0.0.0.0",
    "port": ${PORT},
    "protocol": "vless",
    "settings": {"clients": [{"id": "${UUID}"}], "decryption": "none"},
    "streamSettings": {"network": "ws", "wsSettings": {"path": "${WS_PATH}"}}
  }],
  "outbounds": [{"protocol": "freedom", "settings": {"domainStrategy": "UseIPv4"}}]
}
JSON
exec "${XRAY_BIN:-/usr/local/bin/xray}" run -config /tmp/config.json

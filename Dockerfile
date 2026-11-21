FROM alpine:3.20
RUN apk add --no-cache ca-certificates curl unzip tzdata
ARG XRAY_VERSION=1.8.24
RUN curl -fsSL -o /tmp/xray.zip https://github.com/XTLS/Xray-core/releases/download/v${XRAY_VERSION}/Xray-linux-64.zip && unzip -o /tmp/xray.zip -d /usr/local/bin xray geoip.dat geosite.dat && chmod +x /usr/local/bin/xray && rm /tmp/xray.zip
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

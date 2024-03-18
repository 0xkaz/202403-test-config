#!/bin/sh
set -e

LISTEN_PORT=${LISTEN_PORT:-8080}
ADMIN_LISTEN_PORT=${ADMIN_LISTEN_PORT:-9901}
SERVICE_DISCOVERY_ADDRESS=${SERVICE_DISCOVERY_ADDRESS:-0.0.0.0}
SERVICE_DISCOVERY_PORT=${SERVICE_DISCOVERY_PORT:-9090}
HTTPS_DOMAIN=${HTTPS_DOMAIN:-test.raas.weavedb-node.xyz}

# envoy.https.tmpl.yaml

# envoy.tmpl.yaml


cat /weavedb/grpc-node/envoy/envoy.https.tmpl.yaml | \
/bin/sed -e "s/\$LISTEN_PORT/$LISTEN_PORT/g" | \
/bin/sed -e "s/\$ADMIN_LISTEN_PORT/$ADMIN_LISTEN_PORT/g" | \
/bin/sed -e "s/\$SERVICE_DISCOVERY_PORT/$SERVICE_DISCOVERY_PORT/g" | \
/bin/sed -e "s/\$HTTPS_DOMAIN/$HTTPS_DOMAIN/g" | \
/bin/sed -e "s/\$SERVICE_DISCOVERY_ADDRESS/$SERVICE_DISCOVERY_ADDRESS/g" \
> /weavedb/grpc-node/envoy/envoy.yaml

cat /weavedb/grpc-node/envoy/envoy.yaml

/usr/local/bin/envoy -c /weavedb/grpc-node/envoy/envoy.yaml
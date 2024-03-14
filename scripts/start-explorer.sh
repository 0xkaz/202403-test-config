#!/bin/sh

set -e

ADDITIONAL_NODE_JSON_STR=${ADDITIONAL_NODE_JSON_STR}
ADDITIONAL_NODE_NETWORK=${ADDITIONAL_NODE_NETWORK:-localhost}
ADDITIONAL_NODE_KEY=${ADDITIONAL_NODE_KEY:-localhost}
ADDITIONAL_NODE_ENDPOINT=${ADDITIONAL_NODE_ENDPOINT:-"localhost:8080"}

cat /weavedb/explorer/lib/nodes.tmpl.js | /bin/sed -e "s/\$ADDITIONAL_NODE_JSON_STR/$ADDITIONAL_NODE_JSON_STR/g" \
| /bin/sed -e "s/\$ADDITIONAL_NODE_NETWORK/$ADDITIONAL_NODE_NETWORK/g" \
| /bin/sed -e "s/\$ADDITIONAL_NODE_KEY/$ADDITIONAL_NODE_KEY/g" \
| /bin/sed -e "s/\$ADDITIONAL_NODE_ENDPOINT/$ADDITIONAL_NODE_ENDPOINT/g" > /weavedb/explorer/lib/nodes.js

cat /weavedb/explorer/lib/nodes.js

cd /weavedb/explorer ; /usr/local/bin/yarn dev
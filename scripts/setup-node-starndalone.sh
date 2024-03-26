#!/bin/sh
set -e
set -a
. ./standalone.env
set +a

ADMIN_PRIVATE_KEY=${ADMIN_PRIVATE_KEY}
BUNDLER_KTY=${BUNDLER_KTY:-RSA}
BUNDLER__N=${BUNDLER__N}
BUNDLER__E=${BUNDLER__E}
BUNDLER__D=${BUNDLER__D}
BUNDLER__P=${BUNDLER__P}
BUNDLER__Q=${BUNDLER__Q}
BUNDLER_DP=${BUNDLER_DP}
BUNDLER_DQ=${BUNDLER_DQ}
BUNDLER_QI=${BUNDLER_QI}

cat /weavedb/grpc-node/node-server/weavedb.standalone.config.tmpl.js | \
/bin/sed -e "s/\$ADMIN_PRIVATE_KEY/$ADMIN_PRIVATE_KEY/g" |  \
/bin/sed -e "s/\$BUNDLER_KTY/$BUNDLER_KTY/g" |  \
/bin/sed -e "s/\$BUNDLER__N/$BUNDLER__N/g" | \
/bin/sed -e "s/\$BUNDLER__E/$BUNDLER__E/g" | \
/bin/sed -e "s/\$BUNDLER__D/$BUNDLER__D/g" | \
/bin/sed -e "s/\$BUNDLER__P/$BUNDLER__P/g" | \
/bin/sed -e "s/\$BUNDLER__Q/$BUNDLER__Q/g" | \
/bin/sed -e "s/\$BUNDLER_DP/$BUNDLER_DP/g" | \
/bin/sed -e "s/\$BUNDLER_DQ/$BUNDLER_DQ/g" | \
/bin/sed -e "s/\$BUNDLER_QI/$BUNDLER_QI/g" > /tmp/weavedb.standalone.config.js

cp /tmp/weavedb.standalone.config.js /weavedb/grpc-node/node-server/weavedb.standalone.config.js


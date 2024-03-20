#!/bin/sh
set -e
set -a
. ./standalone.env
set +a

ADMIN_PRIVATE_KEY=${ADMIN_PRIVATE_KEY}
BUNDLER_KTY=${BUNDLER_KTY:-RSA}
BUNDLER_N=${BUNDLER_N}
BUNDLER_E=${BUNDLER_E}
BUNDLER_D=${BUNDLER_D}
BUNDLER_P=${BUNDLER_P}
BUNDLER_Q=${BUNDLER_Q}
BUNDLER_DP=${BUNDLER_DP}
BUNDLER_DQ=${BUNDLER_DQ}
BUNDLER_QI=${BUNDLER_QI}

cat /rdk/node/node-server/weavedb.config.tmpl.js | \
/bin/sed -e "s/\$ADMIN_PRIVATE_KEY/$ADMIN_PRIVATE_KEY/g" |  \
/bin/sed -e "s/\$BUNDLER_KTY/$BUNDLER_KTY/g" |  \
/bin/sed -e "s/\$BUNDLER_N/$BUNDLER_N/g" | \
/bin/sed -e "s/\$BUNDLER_E/$BUNDLER_E/g" | \
/bin/sed -e "s/\$BUNDLER_D/$BUNDLER_D/g" | \
/bin/sed -e "s/\$BUNDLER_P/$BUNDLER_P/g" | \
/bin/sed -e "s/\$BUNDLER_Q/$BUNDLER_Q/g" | \
/bin/sed -e "s/\$BUNDLER_DP/$BUNDLER_DP/g" | \
/bin/sed -e "s/\$BUNDLER_DQ/$BUNDLER_DQ/g" | \
/bin/sed -e "s/\$BUNDLER_QI/$BUNDLER_QI/g" > /tmp/weavedb.config.js

cp /tmp/weavedb.config.js /rdk/node/node-server/weavedb.config.js


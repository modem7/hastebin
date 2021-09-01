#!/bin/sh

## write config file from environment vars
cat > /app/config.js <<EOF
{
  "host": "${HOST:-0.0.0.0}",
  "port": ${PORT:-7777},
  "keyLength": ${KEY_LENGTH:-5},
  "maxLength": ${MAX_LENGTH:-400000},
  "staticMaxAge": ${STATIC_MAX_AGE:-86400},
  "recompressStaticAssets": ${RECOMPRESS_STATIC_ASSETS:-true},
  "logging": [
    {
      "level": "${LOGGING_LEVEL:-verbose}",
      "type": "${LOGGING_TYPE:-Console}",
      "colorize": ${LOGGING_COLORIZE:-true}
    }
  ],
  "keyGenerator": {
    "type": "${KEY_GENERATOR_TYPE:-phonetic}"
  },
  "rateLimits": {
    "categories": {
      "normal": {
        "totalRequests": "$RATE_LIMIT_TOTAL:-500}",
        "every": "$RATE_LIMIT_EVERY:-60000}"
            }
        }
    },
  "storage": {
    "type": "${STORAGE_TYPE:-file}",
    "path": "${STORAGE_PATH:-./data}",
  },
  "documents": {
    "about": "./about.md"
  }
}
EOF

set -xe

# we have to run the chown here since the VOLUME is mounted
# after the build with root:root
chown -R ${UID}:${GID} /app
su-exec ${UID}:${GID} npm start
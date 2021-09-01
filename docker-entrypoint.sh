#!/bin/sh

# We use this file to translate environmental variables to .env files used by the application

set -xe

node ./docker-entrypoint.js > ./config.js

exec "$@"

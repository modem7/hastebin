#!/bin/sh

set -xe

# we have to run the chown here since the VOLUME is mounted
# after the build with root:root
chown -R ${UID}:${GID} /app
su-exec ${UID}:${GID} npm start

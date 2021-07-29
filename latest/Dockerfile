FROM node:current-alpine

ARG HASTEBIN_VERSION
ENV UID=1005 GID=1005

COPY run.sh /usr/local/bin/run.sh

RUN apk -U upgrade \
  && apk --no-cache add git su-exec curl \
  && git clone --depth 1 https://github.com/seejohnrun/haste-server.git /app \
  && cd app \
  && git checkout ${HASTEBIN_VERSION} \
  && npm install \
  && npm cache clean --force \
  && apk del git \
  && rm -rf /var/lib/apk/* /var/cache/apk/* \
  && chmod +x /usr/local/bin/run.sh

# we cannot copy this before the RUN because
# git clone will fail if app/ is not empty
COPY config.js /app/config.js

WORKDIR /app
VOLUME /app/data
EXPOSE 7777

ENTRYPOINT ["run.sh"]

HEALTHCHECK --interval=30s --timeout=30s --start-period=5s \
    --retries=3 CMD [ "curl" , "-f" "localhost:7777", "||", "exit", "1"]
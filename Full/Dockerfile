FROM node:alpine3.15

RUN mkdir -p /usr/src/app && \
    chown node:node /usr/src/app && \
    apk add --no-cache curl

USER node:node 

WORKDIR /usr/src/app

COPY --chown=node:node . . 

RUN npm install --no-optional && \
    npm install --no-optional redis@0.8.1 && \
    npm install --no-optional pg@4.1.1 && \
    npm install --no-optional memcached@2.2.2 && \
    npm install --no-optional aws-sdk@2.738.0 && \
    npm install --no-optional rethinkdbdash@2.3.31

ENV STORAGE_TYPE=file \
    STORAGE_HOST= \
    STORAGE_PORT= \
    STORAGE_EXPIRE_SECONDS=2592000 \
    STORAGE_DB=2 \
    STORAGE_AWS_BUCKET= \
    STORAGE_AWS_REGION= \
    STORAGE_USERNAME= \
    STORAGE_PASSWORD= \
    STORAGE_FILEPATH=./data

ENV LOGGING_LEVEL=verbose \
    LOGGING_TYPE=Console \
    LOGGING_COLORIZE=true

ENV HOST=0.0.0.0 \
    PORT=7777 \
    KEY_LENGTH=5 \
    MAX_LENGTH=400000 \
    STATIC_MAX_AGE=86400 \
    RECOMPRESS_STATIC_ASSETS=true

ENV KEYGENERATOR_TYPE=phonetic \
    KEYGENERATOR_KEYSPACE=

ENV RATELIMITS_NORMAL_TOTAL_REQUESTS=500\
    RATELIMITS_NORMAL_EVERY_MILLISECONDS=60000 \
    RATELIMITS_WHITELIST_TOTAL_REQUESTS= \
    RATELIMITS_WHITELIST_EVERY_MILLISECONDS=  \
    # comma separated list for the whitelisted \
    RATELIMITS_WHITELIST=example1.whitelist,example2.whitelist \
    \   
    RATELIMITS_BLACKLIST_TOTAL_REQUESTS= \
    RATELIMITS_BLACKLIST_EVERY_MILLISECONDS= \
    # comma separated list for the blacklisted \
    RATELIMITS_BLACKLIST=example1.blacklist,example2.blacklist 
ENV DOCUMENTS=about=./about.md

EXPOSE ${PORT}
STOPSIGNAL SIGINT
ENTRYPOINT [ "/bin/sh", "docker-entrypoint.sh" ]

HEALTHCHECK --interval=30s --timeout=30s --start-period=5s \
    --retries=3 CMD [ "sh", "-c", "echo -n 'curl localhost:7777... '; \
    (\
        curl -sf localhost:7777 > /dev/null\
    ) && echo OK || (\
        echo Fail && exit 2\
    )"]
CMD ["npm", "start"]

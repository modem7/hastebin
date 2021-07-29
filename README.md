![Docker Pulls](https://img.shields.io/docker/pulls/modem7/hastebin) ![Docker Image Size (tag)](https://img.shields.io/docker/image-size/modem7/hastebin) [![Build Status](https://drone.modem7.com/api/badges/modem7/hastebin/status.svg)](https://drone.modem7.com/modem7/hastebin)

This repository provides the missing tagged releases for `haste-server`. It is
built [continuously](https://drone.friedl.net/container/hastebin-build/) from
[upstream](https://github.com/seejohnrun/haste-server). `haste-server` is a
pretty, simple, and easy to set up and use pastebin software written in node.js.

Most other `haste` docker repositories are unfortunately out of date and/or are
not built automatically on a regular basis. `Haste` itself has no versioned
releases or an official docker build. However, it is mature and stable. It might
as well be considered a 1.x release at this point in time.

<!-- markdown-toc start - Don't edit this section. Run M-x markdown-toc-refresh-toc -->
**Table of Contents**

- [Features](#features)
- [Tags](#tags)
- [Run](#run)
- [Compose](#compose)
- [Configuration](#configuration)
    - [Default](#default)
    - [Custom](#custom)

<!-- markdown-toc end -->

# Features
* Rolling release with weekly or yearly schedule
* Built from [upstream](https://github.com/seejohnrun/haste-server)
* Runs as non-root
* Easy to get started
* Tested and works well with [podman](https://podman.io/) too

# Tags
* latest: built on a weekly basis from master
* stable: built on a yearly basis from master

# Run
The simplest way to try out this `hastebin` build is to 

```shell
docker run -d -p7777:7777 modem7/hastebin:latest
```

and open http://localhost:7777/ in your browser.

# Compose
A simple `docker-compose` file with a persistent volume might look like:

```yaml
version: '3'

services:
  haste:
    container_name: haste
    image: modem7/hastebin:latest
    restart: always
    volumes:
      - /var/services/bin:/app/data
    ports:
      - 7777:7777
```

# Configuration
## Default
The default configuration (i.e. what goes into the
[`config.json`](https://github.com/seejohnrun/haste-server/blob/master/config.js))
for this `hastebin` build is intentionally simple. It uses reasonable defaults
and stores it's data into a directory located at `/app/data` in the container.
For personal and small scale usage it may be sufficient to just run the image
without any further configuration.

```json
{
    "host": "0.0.0.0",
    "port": 7777,
    "keyLength": 10,
    "maxLength": 400000,
    "staticMaxAge": 86400,
    "recompressStaticAssets": true,
    "logging": [{
        "level": "error",
        "type": "Console",
        "colorize": true
    }],
    "keyGenerator": {
        "type": "phonetic"
    },
    "rateLimits": {
        "categories": {
            "normal": {
                "totalRequests": 500,
                "every": 60000
            }
        }
    },
    "storage": {
        "type": "file",
        "path": "./data"
    },
    "documents": {
        "about": "./about.md"
    }
}
```

## Custom
For more advanced usage, create your own `config.js` with your settings
according to
[haste-server](https://github.com/seejohnrun/haste-server/blob/master/README.md).
You can then derive your own docker image with your custom configuration like so:

```docker
FROM modem7/hastebin:latest
COPY ./config.js /app/config.js
```

This `hastebin` exposes a volume that you can persist outside the container. It
contains all the pastes of your `hastebin` instance (if the default file-based
storage is used). To persist the volume you can start the container like this:

```sh
docker run -d -p7777:7777 -v /var/hastebin:/app/data modem7/hastebin:latest
```

where `/var/hastebin` is the local folder outside the container and `/app/data`
is the volume inside the container.

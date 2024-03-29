#!/bin/bash
#
# Starts a container using the ccertbot image for development

CCBOT_CERTS_DIR=$(pwd)/certs_le
CCBOT_ENV_FILE=$(pwd)/.env
CCBOT_CREDS_DO_FILE=$(pwd)/creds_digitalocean

# Run container
docker run -it --rm --name ccertbot           \
    -v "${CCBOT_CERTS_DIR}:/etc/letsencrypt"  \
    -v "${CCBOT_ENV_FILE}:/opt/ccertbot/.env" \
    -v "${CCBOT_CREDS_DO_FILE}:/opt/ccertbot/creds_digitalocean" \
    giobyte8/ccertbot:dev

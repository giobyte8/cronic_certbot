#!/bin/bash
#
# Starts a container using the ccertbot image for development

CCBOT_CERTS_DIR=$(pwd)/.runtime/certs_le
CCBOT_LOGS=$(pwd)/.runtime/logs
CCBOT_ENV_FILE=$(pwd)/src/.env
CCBOT_CREDS_DO_FILE=$(pwd)/src/.creds_digitalocean

# Retrieve user id and group id to run container
USER_ID=$(id -u)
GROUP_ID=$(id -g)

# Run container
docker run -it --rm --name ccertbot           \
    -u "${USER_ID}:${GROUP_ID}"               \
    -v "${CCBOT_CERTS_DIR}:/etc/letsencrypt"  \
    -v "${CCBOT_LOGS}:/opt/ccertbot/logs"     \
    -v "${CCBOT_ENV_FILE}:/opt/ccertbot/.env" \
    -v "${CCBOT_CREDS_DO_FILE}:/opt/ccertbot/.creds_digitalocean" \
    giobyte8/ccertbot:dev


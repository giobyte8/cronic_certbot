#!/bin/bash
#
# Reads setup domains from env config and makes sure there are
# valid certificates for them.
set -e

# ref: https://stackoverflow.com/a/4774063/3211029
HERE="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
USER_CURR_PATH=$(pwd)
cd "${HERE}"

# Load env file if it exists
ENV_FILE='.env'
if [ -f "${ENV_FILE}" ]; then
    source "${ENV_FILE}"
else
    echo "No ${ENV_FILE} file found."
    echo "  Proceeding with default config"
fi

# Validate digital ocean credentials file
if [ ! -f "${CCBOT_CREDS_DO_FILE}" ]; then
    echo "No digital ocean credentials file found."
    echo "Make sure to set 'CCBOT_CREDS_DO_FILE' in your env file"

    echo "Exiting..."
    exit 1
fi


# Generates a certificate using digital ocean
# plugin for DNS-1 challenge
#
# $1: The domain name (e.g. xx.mydomain.com)
function gen_certificate_digitalocean {
    local domain="${1}"

    # Consider using --quiet once it gets stable in prod
    certbot certonly \
        --non-interactive --agree-tos --keep-until-expiring \
        --email "${CCBOT_EMAIL}" \
        --dns-digitalocean \
        --dns-digitalocean-credentials "${CCBOT_CREDS_DO_FILE}" \
        -d "${domain}"
}

while true; do

    echo
    echo
    echo "==============================================================================="
    echo "Starting cronic_certbot execution"
    echo "At: $(date +"%Y-%m-%d %T")"

    # Generate certificates for configured domains
    for domain in "${CCBOT_DOMAINS[@]}"; do
        echo
        echo "==============================================================================="
        echo "Generating certificate for: ${domain}"
        echo

        gen_certificate_digitalocean "${domain}"
    done

    # Allow read permissions on certificates
    chmod 0755 /etc/letsencrypt/{live,archive}

    echo
    echo "All domains had been processed"
    echo "Now going to sleep for 8 days"
    sleep 875520
done


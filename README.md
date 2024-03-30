# Cronic Certbot

Automates generation and renewal of SSL certificates by running [certbot](https://eff-certbot.readthedocs.io/en/latest/using.html) command periodically inside a docker container.

Domain verification is done through [DNS-01 challenge](https://eff-certbot.readthedocs.io/en/stable/using.html#dns-plugins), hence, no webserver required to generate certificates.

## Deployment

Add `cronic_certbot` as a service to your `docker-compose.yaml`

```yaml
services:
	ccertbot:
    image: giobyte8/ccertbot:1.0.0
    container_name: ccertbot
    restart: unless-stopped
    volumes:
      - "${CCBOT_CERTS_DIR}:/etc/letsencrypt"
      - "${CCBOT_LOGS}:/var/log/letsencrypt"
      - "${CCBOT_ENV_FILE}:/opt/ccertbot/.env"
      - "${CCBOT_CREDS_DO_FILE}:/opt/ccertbot/.creds_digitalocean"
		
```

Make sure to add following variables to your compose `.env` file

```shell
# Host path where ccertbot will store SSL certificates
CCBOT_CERTS_DIR=</path/to/workspace/appdata/ccertbot/sslcerts>

# Host path to store runtime logs
CCBOT_LOGS=</path/to/workspace/appdata/ccertbot/logs>

# ccertbot env and digital ocean credentials, you can use default values
CCBOT_ENV_FILE=ccertbot/.env
CCBOT_CREDS_DO_FILE=ccertbot/.creds_digitalocean
```

Finally add your own values to ccertbot  `.env` and `.creds_digitalocean` files

```shell
wget -O ccertbot/.env https://raw.githubusercontent.com/giobyte8/cronic_certbot/main/src/template.env
vim ccertbot/.env
# Enter your values for EMAIL and your list of domains

wget -O ccertbot/.creds_digitalocean https://raw.githubusercontent.com/giobyte8/cronic_certbot/main/src/creds_do.template
chmod 700 ccertbot/.creds_digitalocean
vim ccertbot/.creds_digitalocean
# Enter your own token to access API
```

Now you can start the service

```shell
docker-compose up -d ccertbot
```

## Development

First, setup your env, credentials and verify permissions
```shell
cp src/creds_do.template src/.creds_digitalocean
vim src/.creds_digitalocean
# Enter your digitalocean token

cp src/template.env src/.env
# Enter values for environment variables

# Digitalocean credentials file should be accessible only to user
chmod 700 src/.creds_digitalocean
```

Once environment is configured, you can use included scripts to work on this project:

- `docker/ccertbot.dockerfile` Dockerfile for **ccertbot** image

- `docker/build.sh` Builds a development or production version of docker image.
- `run_dev_container.sh` Once development image is built, use this script to run the project and test the image

```shell
# Build and run for development testing
./docker/build.sh && ./run_dev_container.sh
```

### Release a new version

Use provided `build.sh` script to build a multi-platform image and upload into docker registry.

- [ ] Add execution example
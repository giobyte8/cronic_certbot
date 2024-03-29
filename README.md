# Cronic Certbot

Automates generation and renewal of SSL certificates by running [certbot](https://eff-certbot.readthedocs.io/en/latest/using.html) command periodically inside a docker container.

Domain verification is done through [DNS-01 challenge](https://eff-certbot.readthedocs.io/en/stable/using.html#dns-plugins), hence, no webserver required to generate certificates.

## Deployment

- [ ] Add deployment instructions using docker compose

## Development

- [x] Fix `for` iteration to generate certs for all domains in array
- [x] Fix permissions issues with creds file
- [x] Review `--text` argument for `certbot`
- [x] Add `--user` param to `docker run` and `docker compose` to prevent permissions issues on generated certificates.

First, setup your env values
```shell
cp src/creds_do.template src/.creds_digitalocean
vim src/.creds_digitalocean
# Enter your digitalocean token

cp src/template.env src/.env
# Enter values for environment variables
```

Once environment is configured, you can use included scripts to work on this project:

- `docker/ccertbot.dockerfile` Dockerfile for **ccertbot** image

- `docker/build.sh` Builds a development or production version of docker image.
- `run_dev_container.sh` Once development image is built, use this script to run the project and test the image

### Release a new version

Use provided `build.sh` script to build a multi-platform image and upload into docker registry.

- [ ] Add execution example
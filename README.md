# Cronic Certbot

Automates generation and renewal of SSL certificates by running [certbot](https://eff-certbot.readthedocs.io/en/latest/using.html) command periodically inside a docker container.

## Deployment

- [ ] Add deployment instructions using docker compose

## Development

First, setup your env values
```shell
cp creds_do.template .creds_digitalocean
vim .creds_digitalocean
# Enter your digitalocean token

cp template.env .env
# Enter values for environment variables
```

Once environment configured, you can use included scripts to work on this project.

- `docker/ccertbot.dockerfile` Dockerfile for **ccertbot** image

- `docker/build.sh` Builds a development or production version of docker image.
- `run_dev_container.sh` Once development image is built, use this script to run the project and test the image

### Release a new version

Use provided `build.sh` script to build a multi-platform image and upload into docker registry.

- [ ] Add execution example
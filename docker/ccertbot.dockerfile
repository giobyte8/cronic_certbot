FROM python:3.12-alpine
WORKDIR /opt/ccertbot

# Install certbot and dependencies
RUN apk add --no-cache tzdata build-base libffi-dev bash && \
    pip install certbot certbot-dns-digitalocean

# Copy certbot scripts (Assume build ctx is project root)
COPY src/run_certbot.sh /opt/ccertbot/run_certbot.sh

ENTRYPOINT ["bash", "/opt/ccertbot/run_certbot.sh"]

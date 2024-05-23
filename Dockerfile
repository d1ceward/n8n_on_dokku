ARG N8N_VERSION="1.42.1"

FROM n8nio/n8n:${N8N_VERSION}

USER root

COPY ./entrypoint.sh /docker-entrypoint.sh

RUN chown node:node /docker-entrypoint.sh && \
    chmod +x /docker-entrypoint.sh

USER node

EXPOSE 5000/tcp

ENTRYPOINT ["/docker-entrypoint.sh"]

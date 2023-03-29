FROM n8nio/n8n:0.221.2

USER root

WORKDIR /home/node/packages/cli
ENTRYPOINT []

COPY ./entrypoint.sh /
RUN chmod +x /entrypoint.sh

EXPOSE 5000/tcp

CMD ["/entrypoint.sh"]

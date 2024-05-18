ARG POSTGRES_VERSION=16
FROM postgres:${POSTGRES_VERSION}-alpine
LABEL org.opencontainers.image.authors="brconn5@gmail.com"

EXPOSE 5432
ENV PGDATA="/data"
ENV PGDUMP="/dump"
ENV PGUSER=postgres

COPY --chown=${PGUSER}:${PGUSER} \
   [ "dump.sh", \
     "entrypoint.sh", \
     "/" ]

USER root

RUN \
chmod 755 dump.sh && \
chmod 755 entrypoint.sh && \
mkdir ${PGDUMP} && \
chown ${PGUSER}:${PGUSER} ${PGDUMP} && \
mkdir ${PGDATA} && \
chown ${PGUSER}:${PGUSER} ${PGDATA}

VOLUME [ "${PGDUMP}", "${PGDATA}" ]
ENTRYPOINT ["bash", "/entrypoint.sh"]
CMD ["dump-cron"]

FROM mysql:8.4
ENV MYSQL_ROOT_PASSWORD=db1004 \
    MYSQL_DATABASE=tigerdb \
    MYSQL_USER=scott \
    MYSQL_PASSWORD=tiger
COPY initdb/ /docker-entrypoint-initdb.d/

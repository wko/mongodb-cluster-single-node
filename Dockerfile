FROM mongo:5

RUN apt-get update && apt-get install -y supervisor && apt-get clean

COPY ./supervisord.conf /etc/supervisor/conf.d/supervisord.conf
COPY ./start_mongo.sh /usr/bin/start_mongo.sh
COPY ./entrypoint.sh /entrypoint.sh
COPY ./setup.sh /setup.sh
RUN chmod +x /entrypoint.sh /usr/bin/start_mongo.sh /setup.sh


ENV MONGO_BASE_DIR /data/mongo


ENTRYPOINT ["/entrypoint.sh"]


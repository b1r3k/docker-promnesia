FROM python:3

RUN mkdir /data
COPY docker-entrypoint.sh /
RUN chmod +x /docker-entrypoint.sh
RUN useradd -ms /bin/bash promnesia
ENV MY_CONFIG="/data/hpi/my"
ENV XDG_CONFIG_DIRS="/data"

RUN pip install -e git+https://github.com/karlicoss/promnesia.git@v1.0.20201125#egg=promnesia[all]
VOLUME /data

EXPOSE 13131
USER promnesia
ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["promnesia", "serve", "--db", "/data/promnesia.sqlite", "--port", "13131"]

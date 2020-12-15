FROM python:3

RUN mkdir /data
COPY docker-entrypoint.sh /
RUN chmod +x /docker-entrypoint.sh
RUN useradd -ms /bin/bash promnesia
RUN pip install -e git+https://github.com/karlicoss/promnesia.git@v1.0.20201125#egg=promnesia[all]
# required by HPI pocket module
RUN pip install -e git+https://github.com/karlicoss/pockexport#egg=pockexport
VOLUME /data

EXPOSE 13131
USER promnesia
ENV MY_CONFIG="/data/hpi"
ENV XDG_CONFIG_HOME="/data"

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["promnesia", "serve", "--db", "/data/promnesia.sqlite", "--port", "13131"]

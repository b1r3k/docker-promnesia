FROM python:3
MAINTAINER lukasz <dot> jachym <at> gmail <dot> com

ENV PROMNESIA_USER="promnesia"
ENV MY_CONFIG="/data/hpi"
ENV XDG_CONFIG_HOME="/data"
ENV PROMNESIA_INDEX_POLICY="update"

RUN mkdir /data
COPY docker-entrypoint.sh /
RUN chmod +x /docker-entrypoint.sh
RUN useradd -ms /bin/bash ${PROMNESIA_USER}
RUN pip install -e git+https://github.com/karlicoss/promnesia.git@v1.0.20201125#egg=promnesia[all]
# required by HPI pocket module
RUN pip install -e git+https://github.com/karlicoss/pockexport#egg=pockexport
RUN pip install -e git+https://github.com/karlicoss/hypexport#egg=hypexport
VOLUME /data

EXPOSE 13131
USER ${PROMNESIA_USER}
ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["promnesia", "serve", "--db", "/data/promnesia.sqlite", "--port", "13131"]

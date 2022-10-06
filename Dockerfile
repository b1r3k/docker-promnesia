FROM python:3
MAINTAINER lukasz <dot> jachym <at> gmail <dot> com

ARG PROMNESIA_VERSION=v1.0.20220515
ENV MY_CONFIG="/data/hpi"
ENV XDG_CONFIG_HOME="/data"
ENV PROMNESIA_INDEX_POLICY="update"

RUN mkdir /data
COPY docker-entrypoint.sh /
RUN chmod +x /docker-entrypoint.sh
RUN pip install -e git+https://github.com/karlicoss/promnesia.git@$PROMNESIA_VERSION#egg=promnesia[all]
# required by HPI pocket module
RUN pip install -e git+https://github.com/karlicoss/pockexport#egg=pockexport
RUN pip install -e git+https://github.com/karlicoss/hypexport#egg=hypexport
# google takeout module
RUN pip install google_takeout_parser
VOLUME /data

EXPOSE 13131
ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["promnesia", "serve", "--db", "/data/promnesia.sqlite", "--port", "13131"]

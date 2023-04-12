## Build specific version

    docker build --build-arg PROMNESIA_VERSION=v1.1.20230129 -t <LOGIN>/docker-promnesia:v1.1.20230129 .

## Build for Raspberry PI

    docker buildx build --platform linux/arm64,linux/amd64,linux/amd64 -t <LOGIN>/docker-promnesia --push .

or with specific version
    
    docker buildx build --build-arg PROMNESIA_VERSION=v1.1.20230129 --platform linux/arm64,linux/amd64 -t ljachym/docker-promnesia:v1.1.20230129 --push .

Builds available here: https://hub.docker.com/r/ljachym/docker-promnesia 

## Running arm64 version on amd64 host

    docker run --privileged --rm tonistiigi/binfmt --install arm64
    docker run --platform linux/arm64 --name=promnesia-arm64 ljachym/docker-promnesia:v1.1.20230129

## Running indexer

Best solution for me was to use hosts' crontab to run docker container with indexing request thus:

    docker exec promnesia-server promnesia index 2>&

is enough and can be added as part of ansible role like this:

```yaml
- name: Install cron job fo indexing
  cron:
    name: "promnesia indexing"
    user: ubuntu
    special_time: daily
    job: "docker exec promnesia-server promnesia index 2>&"
```

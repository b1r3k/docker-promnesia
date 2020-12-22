## Build for Raspberry PI

    docker buildx build --platform linux/arm64 -t <LOGIN>/docker-promnesia --push .

Build available here: https://hub.docker.com/r/ljachym/docker-promnesia 


## Running inder

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

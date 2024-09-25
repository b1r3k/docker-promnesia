PROMNESIA_VERSION=v1.2.20240810


docker-image:
	docker buildx build --build-arg PROMNESIA_VERSION=$(PROMNESIA_VERSION) --platform linux/arm64,linux/amd64 -t ljachym/docker-promnesia:latest -t ljachym/docker-promnesia:$(PROMNESIA_VERSION) --push .

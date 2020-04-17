IMAGE := imapfilter

.PHONY: build
build:
	podman build \
		-t \
		local/${IMAGE} .

.PHONY: run
run:
	podman run \
		-ti \
		-v ./volume/config:/volume/config \
		--rm \
		--security-opt label=disable \
		--name=${IMAGE} \
		local/imapfilter

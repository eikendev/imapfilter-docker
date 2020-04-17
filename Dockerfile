FROM alpine:latest

VOLUME /volume/configuration

WORKDIR /volume/configuration

RUN set -xe \
	&& addgroup --gid 2000 app \
	&& adduser --uid 2000 --disabled-password --no-create-home --ingroup app app

RUN set -xe \
	&& apk update \
	&& apk upgrade \
	&& apk add --no-cache \
		libcrypto1.1 libssl1.1 \
	&& apk add --no-cache --repository http://dl-3.alpinelinux.org/alpine/edge/testing/ \
		imapfilter \
	&& apk del --progress --purge \
	&& rm -rf /var/cache/apk/*

USER app

ENTRYPOINT ["imapfilter"]

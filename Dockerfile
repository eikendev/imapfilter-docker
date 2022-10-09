FROM alpine:latest

ENV IMAPFILTER_HOME=/volume/configuration

VOLUME ${IMAPFILTER_HOME}

WORKDIR ${IMAPFILTER_HOME}

RUN set -xe \
	&& addgroup --gid 2000 app \
	&& adduser --uid 2000 --disabled-password --no-create-home --ingroup app app

RUN set -xe \
	&& apk update \
	&& apk upgrade \
	&& apk add --no-cache \
		libcrypto3 libssl3 \
	&& apk add --no-cache --repository http://dl-cdn.alpinelinux.org/alpine/edge/testing/ \
		imapfilter \
	&& apk del --progress --purge \
	&& rm -rf /var/cache/apk/*

USER app

ENTRYPOINT ["imapfilter"]

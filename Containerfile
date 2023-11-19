FROM docker.io/library/alpine:3

RUN apk add --no-cache curl vlc ffmpeg libaacs libbluray
COPY cache-keydb /usr/bin/

RUN adduser -D vlc
RUN mkdir /home/vlc/.config
RUN chown -R vlc:vlc /home/vlc

LABEL org.label-schema.vcs-url="https://github.com/jmanero/container-image-converter"

USER vlc

FROM alpine:latest

RUN apk add --no-cache bash

COPY ./src/ /usr/local/bin/scripts/
RUN chmod u+x /usr/local/bin/scripts/*

ENTRYPOINT ["/usr/local/bin/scripts/test.sh"]

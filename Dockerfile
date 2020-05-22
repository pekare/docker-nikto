FROM alpine:edge AS builder

WORKDIR /tmp

RUN apk add --no-cache --update git && \
    rm -rf /tmp/* /var/cache/apk/* && \
    git clone https://github.com/sullo/nikto.git

FROM alpine:edge

COPY --from=builder /tmp/nikto/program /nikto

RUN apk add --no-cache --update perl perl-net-ssleay && \
    rm -rf /tmp/* /var/cache/apk/*

ENV PATH=${PATH}:/nikto

ENTRYPOINT ["nikto.pl"]
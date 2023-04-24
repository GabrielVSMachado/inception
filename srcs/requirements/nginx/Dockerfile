#setup
FROM alpine:3.16 as genCertificate

RUN apk update; apk add openssl

COPY certificate.sh .

RUN chmod +x certificate.sh; sh certificate.sh

FROM alpine:3.16 as final

ARG DOMAIN_INCEPTION="www.inception.com"

RUN apk update; \
    apk add nginx; \
    adduser -D -g 'www' www; \
    mkdir -p /www/wordpress; \
    chown -RL www:www /www/wordpress; \
    chown -RL www:www /var/lib/nginx

COPY --from=genCertificate ${DOMAIN_INCEPTION}.key ${DOMAIN_INCEPTION}.crt /etc/nginx/

#nginx config
COPY nginx.conf /etc/nginx/

ENTRYPOINT ["nginx", "-g", "daemon off;error_log /dev/stdout warn;"]

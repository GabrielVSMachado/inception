#setup
FROM alpine:3.16 as genCertificate

WORKDIR /

RUN apk update; apk add openssl

COPY certificate.sh .

RUN chmod +x certificate.sh; sh certificate.sh

FROM alpine:3.16 as final

ENV DOMAIN_INCEPTION="www.inception.com"

RUN apk update; \
    apk add nginx; \
    adduser -D -g 'www' www; \
    mkdir /www; \
    chown -R www:www /var/lib/nginx; \
    chown -R www:www /www; \
    chown -RL www:www /var/lib/nginx; \
    ln -s /www/wordpress /var/www/localhost/htdocs/wordpress

COPY --from=genCertificate --chown=www:www \
      ${DOMAIN_INCEPTION}.key ${DOMAIN_INCEPTION}.crt /etc/nginx/

#nginx config
COPY --chown=www:www nginx.conf /etc/nginx/

CMD ["tail", "-f"]

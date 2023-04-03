#setup
FROM alpine:3.16

RUN apk update; \
    apk add nginx; \
    adduser -D -g 'www' www; \
    mkdir /www; \
    chown -R www:www /var/lib/nginx; \
    chown -R www:www /www;


#index.html
COPY index.html /www

#nginx config
COPY nginx.conf /etc/nginx/

CMD ["nginx"]

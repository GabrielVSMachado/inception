#!/bin/sh

DOMAIN_INCEPTION="www.inception.com"

openssl req -newkey rsa:4096 -x509 -sha256 -days 365 -nodes \
    -out $DOMAIN_INCEPTION.crt \
    -keyout $DOMAIN_INCEPTION.key \
<< EOF
BR
Sao-Paulo
Sao-Paulo
42sp
School
inception.com
admin@inception.com
EOF

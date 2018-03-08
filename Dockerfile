FROM alpine:3.7

RUN apk --no-cache add bash python nginx curl apache2-utils

RUN mkdir -p /var/www/es-head && \
    curl -L -s https://github.com/mobz/elasticsearch-head/archive/master.tar.gz | \
      tar xfvz - -C /var/www/es-head --strip-components=2 'elasticsearch-head-master/_site' && \
    mkdir -p /var/www/es-kopf && \
    curl -L -s https://github.com/micw/elasticsearch-kopf/releases/download/v6.0.1/site.tgz | \
      tar xfvz - -C /var/www/es-kopf

ADD run.sh /run.sh
ADD update_config.py /update_config.py
ADD generate_htpasswd.py /generate_htpasswd.py

ADD nginx.conf /etc/nginx/nginx.conf

# admin:password - use http://aspirine.org/htpasswd_en.html to generate more
ENV USERS='admin:$2y$11$cShofGClacp9BQZOuEGFWunqYyo00l7ftDUR2as1oP7Af85YU9vzK'

CMD ["/run.sh"]

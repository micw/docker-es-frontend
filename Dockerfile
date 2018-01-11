FROM alpine:3.7

RUN apk --no-cache add bash python nginx curl apache2-utils

RUN curl -L -s -i https://github.com/micw/elasticsearch-head/archive/master.tar.gz

RUN mkdir -p /var/www/es-head && \
    curl -L -s https://github.com/micw/elasticsearch-head/archive/master.tar.gz | \
      tar xfvz - -C /var/www/es-head --strip-components=2 'elasticsearch-head-master/_site'

RUN mkdir -p /var/www/es-kopf && \
    curl -L -s https://github.com/micw/elasticsearch-kopf/archive/5.x.tar.gz | \
      tar xfvz - -C /var/www/es-kopf --strip-components=2 'elasticsearch-kopf-5.x/_site'

ADD run.sh /run.sh
ADD update_config.py /update_config.py
RUN chmod 755 /run.sh /update_config.py

ADD nginx.conf /etc/nginx/nginx.conf

CMD ["/run.sh"]

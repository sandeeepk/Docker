FROM ubuntu:16.04
MAINTAINER ssr
RUN sed -i'' 's/archive\.ubuntu\.com/us\.archive\.ubuntu\.com/' /etc/apt/sources.list
RUN apt-get -y update && apt-get -y upgrade
RUN apt-get install build-essential tcl -y
RUN cd /tmp
RUN apt-get install curl -y
RUN curl -O http://download.redis.io/redis-stable.tar.gz
RUN tar xzvf redis-stable.tar.gz
RUN cd redis-stable
RUN make
RUN make test
RUN make install

RUN rm -rf /tmp/redis-stable/redis.conf

COPY redis.conf /tmp/redis-stable/

RUN mkdir /etc/redis

RUN cp /tmp/redis-stable/redis.conf /etc/redis

RUN rm -rf /etc/systemd/system/redis.service

COPY redis.service /etc/systemd/system/

RUN adduser --system --group --no-create-home redis
RUN mkdir /var/lib/redis
RUN chown redis:redis /var/lib/redis
RUN chmod 770 /var/lib/redis
RUN systemctl restart redis

EXPOSE 6379

CMD ["redis-server"]

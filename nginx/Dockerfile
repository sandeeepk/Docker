FROM ubuntu:16.04
MAINTAINER payswiff
RUN sed -i'' 's/archive\.ubuntu\.com/us\.archive\.ubuntu\.com/' /etc/apt/sources.list
RUN apt-get update -y 
RUN apt-get install -y nginx supervisor
COPY nginx-supervisor.conf /etc/supervisor/conf.d/

#RUN mkdir -p /etc/nginx/ssl
#COPY etc/nginx/ssl/nginx.crt /etc/nginx/ssl/
#COPY etc/nginx/ssl/nginx.key /etc/nginx/ssl/

#COPY etc/nginx/nginx.conf /etc/nginx
COPY run-nginx.sh /usr/local/bin/

EXPOSE 80
EXPOSE 443

CMD ["/usr/bin/supervisord"]


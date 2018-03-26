FROM ubuntu:16.04
MAINTAINER payswiff
RUN sed -i'' 's/archive\.ubuntu\.com/us\.archive\.ubuntu\.com/' /etc/apt/sources.list
RUN apt-get update -y
RUN apt-get -y install postgresql postgresql-contrib phppgadmin
RUN EXPOSE 5432

CMD ["/bin/bash"]

FROM ubuntu:16.04
MAINTAINER sudarshan
RUN sed -i'' 's/archive\.ubuntu\.com/us\.archive\.ubuntu\.com/' /etc/apt/sources.list
RUN apt-get -y update && apt-get -y upgrade
RUN gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB
#RUN \curl -sSL https://get.rvm.io | bash -s stable
#RUN rvm list
#RUN \curl -sSL https://get.rvm.io | bash -s -- --trace
RUN type rvm | head -n 1
#RUN rvm list known
#RUN rvm reload
RUN rvm install 2.3.3
RUN rvm use ruby-2.3.3 --default
RUN gem install rails -v 5.0.1
CMD ["/bin/bash"]


FROM ubuntu:16.04
MAINTAINER ssr
RUN apt-get update -y
RUN apt-get install curl -y
RUN gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB
RUN \curl -sSL https://get.rvm.io | bash -s stable
RUN bash -c "source /etc/profile.d/rvm.sh"
RUN \curl -sSL https://get.rvm.io | bash -s -- --trace
RUN bash -c "source /etc/profile.d/rvm.sh && rvm reload"
RUN bash -c "source /etc/profile.d/rvm.sh && rvm install 2.3.3"
RUN bash -c "source /etc/profile.d/rvm.sh && rvm use ruby-2.3.3 --default && echo 'source /etc/profile.d/rvm.sh' >> ~/.profile;"
RUN bash -c "source /etc/profile.d/rvm.sh && gem install rails -v 5.0.1 "
COPY ruby.sh /
#ENTRYPOINT ["./ruby.sh"]
CMD ["./ruby.sh"]


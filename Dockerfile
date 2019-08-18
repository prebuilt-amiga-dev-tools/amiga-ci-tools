FROM ubuntu:18.04

MAINTAINER Mikael Kalms <mikael@kalms.org>

# Use /builder as temp folder while building

WORKDIR /builder

# install basic tools (git/ssh, archive handling, fetching files from network, handling of GPG keys)
RUN apt-get update && apt-get install -y \
	git ssh \
	tar gzip zip unzip \
	ca-certificates \
	wget curl \
	gnupg2

# install GCC
RUN apt-get update && apt-get install -y gcc

# install make
RUN apt-get update && apt-get install -y make

# install vasm
RUN wget http://server.owl.de/~frank/tags/vasm1_8f.tar.gz
RUN tar -xvf vasm1_8f.tar.gz
RUN cd vasm && make CPU=m68k SYNTAX=mot && chmod ugo+rx vasmm68k_mot && mv vasmm68k_mot /usr/bin
RUN rm -rf vasm*

# install vlink
RUN wget http://server.owl.de/~frank/tags/vlink0_16c.tar.gz
RUN tar -xvf vlink0_16c.tar.gz
RUN cd vlink && make && chmod ugo+rx vlink && mv vlink /usr/bin
RUN rm -rf vlink*

# install testrunner-68k
RUN echo "deb https://testrunner-68k-apt.s3-eu-west-1.amazonaws.com stable main" | tee /etc/apt/sources.list.d/testrunner-68k.list
RUN wget https://testrunner-68k-apt.s3-eu-west-1.amazonaws.com/Release.key -O - | apt-key add -
RUN apt-get update && apt-get install -y testrunner-68k=0.1.8

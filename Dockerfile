FROM ubuntu:18.04

MAINTAINER Mikael Kalms <mikael@kalms.org>


# Use /builder as home folder

WORKDIR /builder

# install basic tools (git/ssh, archive handling, fetching files from network, handling of GPG keys)
RUN apt-get update && apt-get install -y \
	git ssh \
	tar zip unzip \
	wget curl \
	gnupg2

# install GCC
RUN apt-get update && apt-get install -y gcc

# install make
RUN apt-get update && apt-get install -y make


# install vasm
RUN wget http://server.owl.de/~frank/tags/vasm1_8f.tar.gz
RUN tar -xvf vasm1_8f.tar.gz
RUN cd vasm && make CPU=m68k SYNTAX=mot
ENV PATH /builder/vasm:$PATH

# install vlink
RUN wget http://server.owl.de/~frank/tags/vlink0_16c.tar.gz
RUN tar -xvf vlink0_16c.tar.gz
RUN cd vlink && make
ENV PATH /builder/vlink:$PATH

# install testrunner-68k
RUN echo "deb https://testrunner-68k-apt.s3-eu-west-1.amazonaws.com stable main" | tee /etc/apt/sources.list.d/testrunner-68k.list
RUN wget https://testrunner-68k-apt.s3-eu-west-1.amazonaws.com/Release.key -O - | apt-key add -
RUN apt-get update && apt-get install -y testrunner-68k


# Run future build jobs as user "builder"

RUN groupadd -r builder && useradd -r -g builder builder
USER builder
 

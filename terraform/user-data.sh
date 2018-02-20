#!/bin/bash
apt-get install -y software-properties-common
add-apt-repository ppa:webupd8team/java
apt-get update
echo "oracle-java8-installer shared/accepted-oracle-license-v1-1 select true" | debconf-set-selections
echo "oracle-java8-installer shared/accepted-oracle-license-v1-1 seen true" | debconf-set-selections
apt-get install -y oracle-java8-installer

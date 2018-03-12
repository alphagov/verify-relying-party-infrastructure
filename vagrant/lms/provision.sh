#!/usr/bin/env bash

# Install dependencies
sudo add-apt-repository ppa:webupd8team/java
sudo apt-get -qq update
sudo debconf-set-selections <<< 'oracle-java8-installer shared/accepted-oracle-license-v1-1 select true'
sudo debconf-set-selections <<< 'oracle-java8-installer shared/accepted-oracle-license-v1-1 seen true'
sudo apt-get -qq install -y unzip oracle-java8-installer

# Download the LMS
if [ ! -d verify-local-matching-service-example ]
then
  curl --silent -LO https://github.com/alphagov/verify-local-matching-service-example/releases/download/0.0.1/verify-local-matching-service-example.zip
  unzip verify-local-matching-service-example.zip
fi

if [ ! -d /opt/verify ]
then
  sudo mkdir -p /opt/verify
else
  sudo rm -rf /opt/verify/verify-local-matching-service-example
fi

sudo mv verify-local-matching-service-example /opt/verify/verify-local-matching-service-example
sudo mv lms.env /opt/verify/verify-local-matching-service-example/.env
sudo chown ubuntu:ubuntu /opt/verify/verify-local-matching-service-example/.env
sudo chmod 400 /opt/verify/verify-local-matching-service-example/.env

sudo mv verify-local-matching-service-example.conf /etc/init
sudo service verify-local-matching-service-example start

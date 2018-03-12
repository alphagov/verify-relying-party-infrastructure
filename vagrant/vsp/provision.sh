#!/usr/bin/env bash

# Install dependencies
sudo add-apt-repository ppa:webupd8team/java
sudo apt-get -qq update
sudo debconf-set-selections <<< 'oracle-java8-installer shared/accepted-oracle-license-v1-1 select true'
sudo debconf-set-selections <<< 'oracle-java8-installer shared/accepted-oracle-license-v1-1 seen true'
sudo apt-get -qq install -y unzip oracle-java8-installer

# Download the VSP
if [ ! -d verify-service-provider-1.0.0 ]
then
  curl --silent -LO https://github.com/alphagov/verify-service-provider/releases/download/1.0.0/verify-service-provider-1.0.0.zip
  unzip verify-service-provider-1.0.0.zip
fi

sudo rm -rf /opt/verify/verify-service-provider
sudo mv verify-service-provider-1.0.0 /opt/verify/verify-service-provider
sudo mv vsp.env /opt/verify/verify-service-provider/.env

sudo mv verify-service-provider.conf /etc/init
sudo service verify-service-provider start

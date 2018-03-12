#!/usr/bin/env bash
version='2.2.0-737'

# Install dependencies
sudo add-apt-repository ppa:webupd8team/java
sudo apt-get -qq update
sudo debconf-set-selections <<< 'oracle-java8-installer shared/accepted-oracle-license-v1-1 select true'
sudo debconf-set-selections <<< 'oracle-java8-installer shared/accepted-oracle-license-v1-1 seen true'
sudo apt-get -qq install -y unzip oracle-java8-installer 2> /dev/null

# Download the MSA
if [ ! -d "verify-matching-service-adapter-$version" ]
then
  curl --silent -LO "https://github.com/alphagov/verify-matching-service-adapter/releases/download/$version/verify-matching-service-adapter-$version.zip"
  unzip "verify-matching-service-adapter-$version.zip"
fi

if [ ! -d /opt/verify ]
then
  sudo mkdir -p /opt/verify
else
  sudo rm -rf /opt/verify/verify-matching-service-adapter
fi

sudo mv "verify-matching-service-adapter-$version" /opt/verify/verify-matching-service-adapter
sudo mv msa.env /opt/verify/verify-matching-service-adapter/.env
sudo mv config.yml /opt/verify/verify-matching-service-adapter/config.yml
sudo chown ubuntu:ubuntu /opt/verify/verify-matching-service-adapter/.env
sudo chmod 400 /opt/verify/verify-matching-service-adapter/.env

sudo mv verify-matching-service-adapter.conf /etc/init
sudo service verify-matching-service-adapter start

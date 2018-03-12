#!/usr/bin/env bash

# Configure apt to know about node
curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash -

# Configure apt to know about yarn
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list

sudo apt-get -qq update

# Install dependencies
sudo apt-get -qq install -y nodejs yarn

# Download the PVSRP
if [ ! -d passport-verify-stub-relying-party ]
then
  curl --silent -LO https://github.com/alphagov/passport-verify-stub-relying-party/releases/download/1.0.0/passport-verify-stub-relying-party-1.0.0.tgz
  tar -xf passport-verify-stub-relying-party-1.0.0.tgz
  mv package passport-verify-stub-relying-party
  (cd passport-verify-stub-relying-party && npm install --production)
fi

if [ ! -d /opt/verify ]
then
  sudo mkdir -p /opt/verify
else
  sudo rm -rf /opt/verify/passport-verify-stub-relying-party
fi

sudo mv passport-verify-stub-relying-party /opt/verify/passport-verify-stub-relying-party
sudo mv pvsrp.env /opt/verify/passport-verify-stub-relying-party/.env
sudo chown ubuntu:ubuntu /opt/verify/passport-verify-stub-relying-party/.env
sudo chmod 400 /opt/verify/passport-verify-stub-relying-party/.env

sudo mv passport-verify-stub-relying-party.conf /etc/init
sudo service passport-verify-stub-relying-party start

#!/usr/bin/env bash
version='2.2.0-737'

cd /home/ubuntu

# Install dependencies
add-apt-repository ppa:webupd8team/java
apt-get -qq update
debconf-set-selections <<< 'oracle-java8-installer shared/accepted-oracle-license-v1-1 select true'
debconf-set-selections <<< 'oracle-java8-installer shared/accepted-oracle-license-v1-1 seen true'
apt-get -qq install -y unzip oracle-java8-installer 2> /dev/null

echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDXmBraPYRMsCCj0Hw1q73SW8d4hBXcoZMxdifRqVYs4/4GZqaJJbWKRaQ2eRAN6yeHgkAWdsrPx6NBbq12QGRIVpNF6C3eaIVQaU+fdOWepFi9dDbFWymPFspWC1pSwXBl/A3k4JbwyCsaUO7TfjzL4XB3CYjVkopmlvjjQTHBB8sdSm922A/czEK6DAqmDXrU5iDaiauN/dXx2qk9El6dfTyXDFXADgFXN3rMvPGY+V8UPSGUDSkB5K+SjyrtbkP+QaKvavoyHF/k+Tvib7Wp3fZgcBF9vQZ9tTQ22CBd4YJbrUSqMCVNFMpc09WDHw/o15acmUtKdfvbbowdPuyt2mUzkJsj5brfHTs22uHln5Bojs3RcnO74mO8aEIJ0WmbExM/Um4wuBrSOSAxxBsktnVAKkEfb2XtbYLEruyp9z/ycPELBf4iaES3pgbBVogvX+cq8TPSOSu7x8hM3+Cvkw7j07GhZsmTQEHERKPnHMa+LeaXkKAQOecHPUQZ6HhVDHuEI9agQ0GVufsUs3asOcwIZwXSLvXGymbsgnhogpxU9Cy5CXZtsPfZWSbq5n+OuRDKjT19Eks/8fSenvSuIaDkKZbCuhEwIutvTO3rZmzm/7vFnGA0YTkJX5qKNDgvtPDJJkn2MuEwyRbSCX2CH66WOEfkCE4MJqDthjERBw== richard.towers@digital.cabinet-office.gov.uk" >> /home/ubuntu/.ssh/authorized_keys


# Download the MSA
if [ ! -d "verify-matching-service-adapter-$version" ]
then
  curl --silent -LO "https://github.com/alphagov/verify-matching-service-adapter/releases/download/$version/verify-matching-service-adapter-$version.zip"
  unzip "verify-matching-service-adapter-$version.zip"
fi

if [ ! -d /opt/verify ]
then
  mkdir -p /opt/verify
else
  rm -rf /opt/verify/verify-matching-service-adapter
fi

mv "verify-matching-service-adapter-$version" /opt/verify/verify-matching-service-adapter
mv msa.env /opt/verify/verify-matching-service-adapter/.env
mv config.yml /opt/verify/verify-matching-service-adapter/config.yml

chown ubuntu:ubuntu /opt/verify/verify-matching-service-adapter/.env
chmod 400 /opt/verify/verify-matching-service-adapter/.env

mv verify-matching-service-adapter.conf /etc/init

service verify-matching-service-adapter start


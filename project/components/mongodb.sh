#!/bin/bash

source components/common.sh
info  "Setting up MongoDB"
info "Setting up YUM repository"
echo '[mongodb-org-4.2]
name=MongoDB Repository
baseurl=https://repo.mongodb.org/yum/redhat/$releasever/mongodb-org/4.2/x86_64/
gpgcheck=1
enabled=1
gpgkey=https://www.mongodb.org/static/pgp/server-4.2.asc' > /etc/yum.repos.d/mongodb-org-4.2.repo

if [ $? -eq 0 ]; then
  echo SUCCESS
  else
    echo ERROR
    fi
 info "Installing MONGODB"
    yum install -y mongodb-org -y &>> ${LOG_FILE}
if [ $? -eq 0 ]; then
  echo SUCCESS
  else
    echo ERROR
    fi
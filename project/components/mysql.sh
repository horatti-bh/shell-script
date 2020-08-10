#!/bin/bash
source components/common.sh
info  "Setting up MYSQL"

info "start: Downloading MYSQL"
cd /tmp
yum list installed | grep mysql-community-server &> /dev/null
if [[ $? -eq 0 ]]; then
  STAT $? "Finish: Skipping Package is already installed"
  else
     wget -qO- https://downloads.mysql.com/archives/get/p/23/file/mysql-5.7.28-1.el7.x86_64.rpm-bundle.tar | tar -x
 STAT $? "Finish: Finished downloading MYSQL"
  fi

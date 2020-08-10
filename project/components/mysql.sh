#!/bin/bash
source components/common.sh
info  "Setting up MYSQL"

info "start: Downloading MYSQL"
cd /tmp
yum list installed | grep mysql-community-server &> /dev/null
if [[ $? -eq 0 ]]; then
  STAT $? "Finish: Skipping Package is already installed"
  else
    if [[ ! -f /tmp/mysql-community-server-5.7.28-1.el7.x86_64.rpm ]]; then
 wget -qO- https://downloads.mysql.com/archives/get/p/23/file/mysql-5.7.28-1.el7.x86_64.rpm-bundle.tar | tar -x
fi
 STAT $? "Finish: Finished downloading MYSQL"
 info "start: Installing the MYSQL"
yum install mysql-community-client-5.7.28-1.el7.x86_64.rpm \
              mysql-community-common-5.7.28-1.el7.x86_64.rpm \
              mysql-community-libs-5.7.28-1.el7.x86_64.rpm \
              mysql-community-server-5.7.28-1.el7.x86_64.rpm -y &>> ${LOG_FILE}
STAT $? "Finish: MYSQL installation finished"
  fi

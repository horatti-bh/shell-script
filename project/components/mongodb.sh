#!/bin/bash

source components/common.sh
info  "Setting up MongoDB"
info "start: Setting up YUM repository"
echo '[mongodb-org-4.2]
name=MongoDB Repository
baseurl=https://repo.mongodb.org/yum/redhat/$releasever/mongodb-org/4.2/x86_64/
gpgcheck=1
enabled=1
gpgkey=https://www.mongodb.org/static/pgp/server-4.2.asc' > /etc/yum.repos.d/mongodb-org-4.2.repo

STAT $? "Finish : YUM repo Information"
#  if [ $? -eq 0 ]; then
#  echo SUCCESS
#  else
#    echo ERROR
#    fi
 info "Start: Installing MONGODB"
    yum install -y mongodb-org -y &>> ${LOG_FILE}
    STAT $? "Finish: Installing MONGODB"
 info "Start: Start the MONGODB Service"
  systemctl enable mongod &>/dev/null
  systemctl start mongod &>> ${LOG_FILE}
  STAT $? "Finish: Started MONGODB service"

info "Start: Clone the MONGODB repo"
CLONE mongodb &>> ${LOG_FILE}
STAT $? "Finish: Finished cloning the MONGODB repository"

info "Start: Loading the Schema"
echo 'show dbs' | mongo | grep catalogue &>> ${LOG_FILE}
if [[ $? -ne 0 ]]; then
mongo /tmp/mongodb/catalogue.js &>> ${LOG_FILE}
fi
echo 'show dbs' | mongo | grep users &>> ${LOG_FILE}
if [[ $? -ne 0 ]]; then
mongo /tmp/mongodb/users.js &>> ${LOG_FILE}
fi
STAT $? "Finish: Loaded Schema"
#mkdir -p /tmp/mongobd
#  git clone https://github.com/horatti-bh/mongodb.git /tmp/mongobd
# STAT $? "Finish: Cloned the repo"

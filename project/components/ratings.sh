#!/bin/bash

export service=ratings
export APP_USER=roboshop
export APP_HOME=/home/${APP_USER}/${service}

source components/common.sh
info  "Setting up ratings micro service"

info "start: setup HTTPD Web Server"
yum list install | grep remi-release-7 &>>/dev/null
if [[ $? -eq 0 ]]; then
  STAT $? "Finish: Done HTTPD Web Server"
  else
    yum install  http://rpms.remirepo.net/enterprise/remi-release-7.rpm -y &>> ${LOG_FILE}
     STAT $? "Finish: Done rpms HTTPD Web Server"
  fi
  info "start: Install Apach web server"
yum install httpd -y &>> ${LOG_FILE}
yum -y install yum-utils -y &>> ${LOG_FILE}
STAT $? "Finish: Installed APAche web app"

info "start: Install PHP"
yum-config-manager --enable remi-php73 &>> ${LOG_FILE}
yum -y install php php-opcache php73-php-pdo composer &>> ${LOG_FILE}
STAT $? "Finish: Installed PHP"


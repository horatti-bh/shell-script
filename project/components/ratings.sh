#!/bin/bash

export service=ratings
export APP_USER=roboshop
export APP_HOME=/home/${APP_USER}/${service}

source components/common.sh
info  "Setting up ratings micro service"


  info "start: Install Apach web server"
yum install httpd -y &>> ${LOG_FILE}
yum -y install yum-utils -y &>> ${LOG_FILE}
STAT $? "Finish: Installed APAche web app"

info "start: Install PHP"
yum-config-manager --enable remi-php73 &>> ${LOG_FILE}
yum -y install php php-opcache php73-php-pdo composer &>> ${LOG_FILE}
STAT $? "Finish: Installed PHP"

info "start: updated port number"
sed -i '/^Listen/ c Listen 7004' /etc/httpd/conf/httpd.conf &>> ${LOG_FILE}
STAT $? "Finish: Updated port number"

info "start: Clone repo and update HTDOCS"
CLONE_TMP ratings &>> ${LOG_FILE}
cp /tmp/ratings/status.conf /etc/httpd/conf.d/ &>> ${LOG_FILE}
rm -rf /var/www/html &>> ${LOG_FILE}
cp -r /tmp/ratings/html /var/www/html &>> ${LOG_FILE}
STAT $? "Finish: Clone repo and updated"

info "start: Install PHP dependencies"
cd /var/www/html
composer install &>> ${LOG_FILE}
STAT $? "Finish: Installed PHP dependencies"

info "start: Start the HTTPD Service"
systemctl enable httpd &>> ${LOG_FILE}
systemctl start httpd &>> ${LOG_FILE}
STAT $? "Finish: Started the HTTPD Service"

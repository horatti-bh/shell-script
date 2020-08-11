#!/bin/bash

export service=frontend
export APP_USER=roboshop
export APP_HOME=/home/${APP_USER}/${service}

source components/common.sh
info  "Setting up frontend micro service"

info "start: Install NGINX"
yum install nginx -y &> ${LOG_FILE}
STAT $? "Finish:  Installed NGINX"

info "start: Clone the frontend repo"
CLONE_TMP ${service} &> ${LOG_FILE}
cp /tmp/frontend/nginx-localhost.conf /etc/nginx/nginx.conf  &> ${LOG_FILE}
rm -rf /usr/share/nginx/html
cp -r /tmp/frontend/static /usr/share/nginx/html
STAT $? "Finish: Clone the frontend repo"

info "start: Start nginx service"
systemctl enable nginx &>> ${LOG_FILE}
systemctl start nginx &>> ${LOG_FILE}
STAT $? "Finish: Start nginx service"
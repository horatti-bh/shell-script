#!/bin/bash

export service=shipping
export APP_USER=roboshop
export APP_HOME=/home/${APP_USER}/${service}

source components/common.sh
info  "Setting up shipping micro service"
info "start: Install JAVA"
yum install java -y &>>${LOG_FILE}
STAT $? "Finish: Installed JAVA"

info "start: adding application user"
createAppuser ${APP_USER}
STAT $? "Finish: created application user"

info "start: Clone the shipping repo"
CLONE_APP ${service} ${APP_USER} &> ${LOG_FILE}
STAT $? "Finish: Clone the shipping repo"

info "start: Permissions to application"
chown ${APP_USER}:${APP_USER} ${APP_HOME} -R
STAT $? "Finish: Permissions to application"

info "start: Setup shipping systemD service"
# mkdir -p /var/log/robo-shop/
envsubst < /home/${APP_USER}/${service}/${service}.service  > /etc/systemd/system/${service}.service &>> ${LOG_FILE}
STAT $? "Finish: Setup shipping systemD service"

info "start: Start shipping service"
systemctl daemon-reload &>> ${LOG_FILE}
systemctl enable shipping &>> ${LOG_FILE}
systemctl start shipping &>> ${LOG_FILE}
STAT $? "Finish: Start shipping  service"



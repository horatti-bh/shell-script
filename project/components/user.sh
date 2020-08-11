#!/bin/bash

export service=user
export APP_USER=roboshop
export APP_HOME=/home/${APP_USER}/${service}

source components/common.sh
info  "Setting up user micro service"
info "start: Install NodeJS"
InstallNodeJS
STAT $? "Finish: Installed NodeJS"

info "start: adding application user"
createAppuser ${APP_USER}
STAT $? "Finish: created application user"

info "start: Clone the user repo"
mkdir -p ${APP_HOME}
CLONE_APP ${service} ${APP_USER} &> ${LOG_FILE}
STAT $? "Finish: Clone the user repo"

info "start: install NodeJS dependencies"
cd ${APP_HOME}
npm install &>> ${LOG_FILE}
STAT $? "Finish: installed NodeJS dependencies"

info "start: Permissions to application"
chown ${APP_USER}:${APP_USER} ${APP_HOME} -R
STAT $? "Finish: Permissions to application"

info "start: Setup user systemD service"
# mkdir -p /var/log/robo-shop/
envsubst < /home/${APP_USER}/${service}/${service}.service  > /etc/systemd/system/${service}.service &>> ${LOG_FILE}
STAT $? "Finish: Setup catalogue systemD service"

info "start: Start user service"
systemctl daemon-reload &>> ${LOG_FILE}
systemctl enable user &>> ${LOG_FILE}
systemctl start user &>> ${LOG_FILE}
STAT $? "Finish: Start user service"



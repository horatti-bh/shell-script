#!/bin/bash

service=catalogue
APP_USER=roboshop
APP_HOME=/home/${APP_USER}/${service}

source components/common.sh
info  "Setting up catalogue micro service"
info "start: Install NodeJS"
InstallNodeJS
STAT $? "Finish: Installed NodeJS"

info "start: adding application user"
createAppuser ${APP_USER}
STAT $? "Finish: created application user"

info "start: Clone the catalogue repo"
mkdir -p ${APP_HOME}
CLONE_APP ${service} ${APP_USER} &> ${LOG_FILE}
STAT $? "Finish: Clone the catalogue repo"

info "start: install NodeJS dependencies"
cd ${APP_USER}/${service}
npm install &>> ${LOG_FILE}
STAT $? "Finish: installed NodeJS dependencies"

info "start: Permissions to application"
chown ${APP_USER}:${APP_USER}:${APP_HOME} -R
STAT $? "Finish: Permissions to application"




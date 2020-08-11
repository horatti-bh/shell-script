#!/bin/bash

export service=cart
export APP_USER=roboshop
export APP_HOME=/home/${APP_USER}/${service}

source components/common.sh
info  "Setting up cart micro service"
info "start: Install NodeJS"
InstallNodeJS
STAT $? "Finish: Installed NodeJS"

info "start: adding application user"
createAppuser ${APP_USER}
STAT $? "Finish: created application user"

info "start: Clone the cart repo"
CLONE_APP ${service} ${APP_USER} &> ${LOG_FILE}
STAT $? "Finish: Clone the cart repo"

info "start: install NodeJS dependencies"
cd ${APP_HOME}
npm install &>> ${LOG_FILE}
STAT $? "Finish: installed NodeJS dependencies"

info "start: Permissions to application"
chown ${APP_USER}:${APP_USER} ${APP_HOME} -R
STAT $? "Finish: Permissions to application"

info "start: Setup cart systemD service"
# mkdir -p /var/log/robo-shop/
envsubst < /home/${APP_USER}/${service}/${service}.service  > /etc/systemd/system/${service}.service &>> ${LOG_FILE}
STAT $? "Finish: Setup cart systemD service"

info "start: Start cart service"
systemctl daemon-reload &>> ${LOG_FILE}
systemctl enable cart &>> ${LOG_FILE}
systemctl start cart &>> ${LOG_FILE}
STAT $? "Finish: Start cart service"



#!/bin/bash

export service=dispatch
export APP_USER=roboshop
export APP_HOME=/home/${APP_USER}/${service}

source components/common.sh
info  "Setting up dispatch micro service"

info "start: adding application user"
createAppuser ${APP_USER}
STAT $? "Finish: created application user"

info "start: Clone the dispatch repo"
CLONE_APP ${service} ${APP_USER} &> ${LOG_FILE}
STAT $? "Finish: Clone the dispatch repo"

info "start: Permissions to application"
chmod ugo+x ${APP_HOME}dispatch
chown ${APP_USER}:${APP_USER} ${APP_HOME} -R
STAT $? "Finish: Permissions to application"

info "start: Setup dispatch systemD service"
envsubst < /home/${APP_USER}/${service}/${service}.service  > /etc/systemd/system/${service}.service &>> ${LOG_FILE}
STAT $? "Finish: Setup dispatch systemD service"

info "start: Start dispatch service"
systemctl daemon-reload &>> ${LOG_FILE}
systemctl enable dispatch &>> ${LOG_FILE}
systemctl start dispatch &>> ${LOG_FILE}
STAT $? "Finish: Start dispatch service"
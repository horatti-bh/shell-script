#!/bin/bash

export service=payment
export APP_USER=roboshop
export APP_HOME=/home/${APP_USER}/${service}

source components/common.sh
info  "Setting up payment micro service"

info "start: Install Python 3"
yum install python36 gcc python3-devel -y &>>${LOG_FILE}
STAT $? "Finish: Installed python3"

info "start: adding application user"
createAppuser ${APP_USER}
STAT $? "Finish: created application user"

info "start: Clone the payment repo"
CLONE_APP ${service} ${APP_USER} &> ${LOG_FILE}
STAT $? "Finish: Clone the payment repo"

info "start: install the payment dependencies"
cd ${APP_HOME}
pip3 install -r requirements.txt &> ${LOG_FILE}
STAT $? "Finish: installed the payment dependencies"

info "start: Setup payment systemD service"
envsubst < /home/${APP_USER}/${service}/${service}-ss.service  > /etc/systemd/system/${service}.service &>> ${LOG_FILE}
STAT $? "Finish: Setup payment systemD service"

info "start: Start payment service"
systemctl daemon-reload &>> ${LOG_FILE}
systemctl enable payment &>> ${LOG_FILE}
systemctl start payment &>> ${LOG_FILE}
STAT $? "Finish: Start payment service"
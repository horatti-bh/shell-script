#!/bin/bash

APP_USER=roboshop
APP_HOME=/home/${APP_USER}

source components/common.sh
info  "Setting up catalogue micro service"
info "start: Install NodeJS"
InstallNodeJS
STAT $? "Finish: Installed NodeJS"
info "start: adding application user"
createAppuser ${APP_USER}
STAT $? "Finish: created application user"






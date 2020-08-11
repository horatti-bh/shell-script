#!/bin/bash

source components/common.sh
info  "Setting up catalogue micro service"
info "start: Install NodeJS"
InstallNodeJS
curl -s https://raw.githubusercontent.com/linuxautomations/labautomation/master/tools/nodejs/install.sh | bash &>> ${LOG_FILE}
STAT $? "Finish: Installed NodeJS"


#!/bin/bash

source components/common.sh
info  "Setting up catalogue"
info "start: Setting up YUM repository"
curl -s https://raw.githubusercontent.com/linuxautomations/labautomation/master/tools/nodejs/install.sh | bash &>> ${LOG_FILE}
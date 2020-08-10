#!/bin/bash
source components/common.sh
info  "Setting up Redis"

info "start: Setting up YUM repository"

yum install epel-release yum-utils -y &>> ${LOG_FILE}
yum install http://rpms.remirepo.net/enterprise/remi-release-7.rpm -y &>> ${LOG_FILE}
yum-config-manager --enable remi &>> ${LOG_FILE}
STAT $? "Finish: yum repo's are updated"

info "start: Install the Redis"
yum install redis -y &>> ${LOG_FILE}
STAT $? "Finish: Redis installation finished"


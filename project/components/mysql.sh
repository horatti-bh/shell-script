#!/bin/bash
source components/common.sh
info  "Setting up MYSQL"

info "start: Downloading MYSQL"
cd /tmp
yum list installed | grep mysql-community-server &> /dev/null
if [[ $? -eq 0 ]]; then
  STAT $? "Finish: Skipping Package is already installed"
  else
    if [[ ! -f /tmp/mysql-community-server-5.7.28-1.el7.x86_64.rpm ]]; then
 wget -qO- https://downloads.mysql.com/archives/get/p/23/file/mysql-5.7.28-1.el7.x86_64.rpm-bundle.tar | tar -x
fi
 STAT $? "Finish: Finished downloading MYSQL"
 info "start: Installing the MYSQL"
yum install mysql-community-client-5.7.28-1.el7.x86_64.rpm \
              mysql-community-common-5.7.28-1.el7.x86_64.rpm \
              mysql-community-libs-5.7.28-1.el7.x86_64.rpm \
              mysql-community-server-5.7.28-1.el7.x86_64.rpm -y &>> ${LOG_FILE}
STAT $? "Finish: MYSQL installation finished"
  fi
   info "Start: Start the mysql Service"
   systemctl enable mysqld &>/dev/null
  systemctl start mysqld &>> ${LOG_FILE}
  STAT $? "Finish: Started mysql service"

sleep 10
info "Start: Resetting mysql password"
MYSQL_TMP_PASSWORD=$(cat /var/log/mysqld.log | grep password | tail -1 | awk '{print $NF}')
echo -e "ALTER USER 'root'@'localhost' IDENTIFIED BY 'MyNewPass@1';\nuninstall plugin validate_password;\nALTER USER 'root'@'localhost' IDENTIFIED BY 'password';" >/tmp/remove-plugin.sql
mysql --connect-expired-password -uroot -p </tmp/remove-plugin.sql &>> ${LOG_FILE}
STAT $? "Finish: reset password"

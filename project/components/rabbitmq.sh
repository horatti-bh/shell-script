#!/bin/bash
source components/common.sh
info  "Setting up RABBITMQ"

info "start: Install Erlang"
yum list installed | grep esl-erlang &>/dev/null
if [[ $? -eq 0 ]]; then
  STAT $? "Finish: Installed Erlang"
  else
yum install https://packages.erlang-solutions.com/erlang/rpm/centos/7/x86_64/esl-erlang_22.2.1-1~centos~7_amd64.rpm -y &>> ${LOG_FILE}
fi
STAT $? "Finish: Installed Erlang"

info "start: Setting up yum repo"
curl -s https://packagecloud.io/install/repositories/rabbitmq/rabbitmq-server/script.rpm.sh | sudo bash &>> ${LOG_FILE}
STAT $? "Finish: Setup yum repo"

info "start: Installing RABBITMQ"
 yum install rabbitmq-server -y &> ${LOG_FILE}
 STAT $? "Finish: Installed RabbitMQ"

  info "Start: Start the rabbitmq Service"
  systemctl enable rabbitmq-server  &>/dev/null
  systemctl start rabbitmq-server &>> ${LOG_FILE}
  STAT $? "Finish: Started rabbitmq service"

